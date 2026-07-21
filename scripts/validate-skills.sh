#!/usr/bin/env bash
set -euo pipefail

failures=0

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  failures=$((failures + 1))
}

pass() {
  printf 'PASS: %s\n' "$1"
}

require_file() {
  local path="$1"
  local label="$2"

  if [[ -f "$path" ]]; then
    pass "$label exists ($path)"
  else
    fail "$label missing ($path)"
  fi
}

require_fixed_string() {
  local path="$1"
  local needle="$2"
  local label="$3"

  if [[ ! -f "$path" ]]; then
    fail "$label cannot be checked because $path is missing"
    return
  fi

  if grep -Fq -- "$needle" "$path"; then
    pass "$label"
  else
    fail "$label missing '$needle' in $path"
  fi
}

promoted_buckets=(engineering productivity)
non_promoted_buckets=(misc personal in-progress deprecated)

printf 'Validating promoted skills...\n'

for bucket in "${promoted_buckets[@]}"; do
  bucket_dir="skills/$bucket"
  bucket_readme="$bucket_dir/README.md"

  require_file "$bucket_readme" "$bucket bucket README"

  if [[ ! -d "$bucket_dir" ]]; then
    fail "promoted bucket missing ($bucket_dir)"
    continue
  fi

  found_skill=false
  for skill_dir in "$bucket_dir"/*; do
    [[ -d "$skill_dir" ]] || continue
    found_skill=true

    skill="$(basename "$skill_dir")"
    skill_file="$skill_dir/SKILL.md"
    metadata_file="$skill_dir/agents/openai.yaml"
    docs_file="docs/$bucket/$skill.md"

    require_file "$skill_file" "$bucket/$skill SKILL.md"
    require_file "$metadata_file" "$bucket/$skill OpenAI metadata"
    require_file "$docs_file" "$bucket/$skill human docs"
    require_fixed_string "README.md" "skills/$bucket/$skill/SKILL.md" "$bucket/$skill is listed in root README"
    require_fixed_string "$bucket_readme" "./$skill/SKILL.md" "$bucket/$skill is listed in bucket README"

    skill_disables_model=false
    metadata_disables_implicit=false

    if [[ -f "$skill_file" ]] && grep -Eq '^disable-model-invocation:[[:space:]]*true[[:space:]]*$' "$skill_file"; then
      skill_disables_model=true
    fi

    if [[ -f "$metadata_file" ]] && grep -Eq '^[[:space:]]*allow_implicit_invocation:[[:space:]]*false[[:space:]]*$' "$metadata_file"; then
      metadata_disables_implicit=true
    fi

    if [[ "$skill_disables_model" == true || "$metadata_disables_implicit" == true ]]; then
      if [[ "$skill_disables_model" == true && "$metadata_disables_implicit" == true ]]; then
        pass "$bucket/$skill user-invoked metadata is consistent"
      else
        fail "$bucket/$skill user-invoked metadata is inconsistent; set both disable-model-invocation: true and policy.allow_implicit_invocation: false"
      fi
    else
      if [[ -f "$skill_file" ]] && grep -Eq '^description:.*Use when' "$skill_file"; then
        pass "$bucket/$skill model-invoked description includes trigger phrasing"
      else
        fail "$bucket/$skill model-invoked description should include trigger phrasing such as 'Use when...'"
      fi
    fi
  done

  if [[ "$found_skill" == false ]]; then
    pass "$bucket has no promoted skill directories to validate"
  fi
done

printf '\nValidating non-promoted buckets...\n'

for bucket in "${non_promoted_buckets[@]}"; do
  bucket_dir="skills/$bucket"
  require_file "$bucket_dir/README.md" "$bucket bucket README"

  [[ -d "$bucket_dir" ]] || continue

  for skill_file in "$bucket_dir"/*/SKILL.md; do
    [[ -f "$skill_file" ]] || continue

    skill_dir="$(dirname "$skill_file")"
    skill="$(basename "$skill_dir")"

    if grep -Fq -- "skills/$bucket/$skill/SKILL.md" README.md; then
      fail "non-promoted skill $bucket/$skill is linked as a promoted skill in root README"
    else
      pass "non-promoted skill $bucket/$skill is not linked in root promoted catalog"
    fi

    if [[ -f "docs/$bucket/$skill.md" ]]; then
      fail "non-promoted skill $bucket/$skill has a public docs page at docs/$bucket/$skill.md"
    else
      pass "non-promoted skill $bucket/$skill has no public docs page"
    fi
  done
done

printf '\nValidating scripts...\n'
require_file "scripts/list-skills.sh" "list-skills script"
require_file "scripts/validate-skills.sh" "validate-skills script"
require_fixed_string "package.json" '"list-skills": "bash scripts/list-skills.sh"' "package.json exposes list-skills script"
require_fixed_string "package.json" '"validate": "bash scripts/validate-skills.sh"' "package.json exposes validate script"

printf '\nValidating Claude plugin manifest...\n'
require_file ".claude-plugin/plugin.json" "Claude plugin manifest"
require_file ".claude-plugin/marketplace.json" "Claude plugin marketplace metadata"

if node <<'NODE'
const fs = require('fs');
const promotedBuckets = ['engineering', 'productivity'];
const packageJson = JSON.parse(fs.readFileSync('package.json', 'utf8'));
const plugin = JSON.parse(fs.readFileSync('.claude-plugin/plugin.json', 'utf8'));
const marketplace = JSON.parse(fs.readFileSync('.claude-plugin/marketplace.json', 'utf8'));

const expectedSkills = promotedBuckets.flatMap((bucket) => {
  const bucketDir = `skills/${bucket}`;
  if (!fs.existsSync(bucketDir)) return [];
  return fs.readdirSync(bucketDir, { withFileTypes: true })
    .filter((entry) => entry.isDirectory())
    .map((entry) => `./${bucketDir}/${entry.name}`)
    .filter((skillPath) => fs.existsSync(`${skillPath.slice(2)}/SKILL.md`));
}).sort();

const actualSkills = Array.isArray(plugin.skills) ? [...plugin.skills].sort() : null;
const errors = [];

if (plugin.version !== packageJson.version) {
  errors.push(`plugin.json version ${plugin.version || '(missing)'} does not match package.json version ${packageJson.version}`);
}

if (!actualSkills) {
  errors.push('plugin.json skills must be an array');
} else if (JSON.stringify(actualSkills) !== JSON.stringify(expectedSkills)) {
  errors.push(`plugin.json skills must exactly match promoted skills. expected ${JSON.stringify(expectedSkills)}, got ${JSON.stringify(actualSkills)}`);
}

for (const skillPath of actualSkills || []) {
  if (!skillPath.startsWith('./skills/engineering/') && !skillPath.startsWith('./skills/productivity/')) {
    errors.push(`plugin.json exposes non-promoted skill path ${skillPath}`);
  }
}

if (!marketplace.plugins || !Array.isArray(marketplace.plugins) || !marketplace.plugins.some((entry) => entry.name === plugin.name && entry.path === '.')) {
  errors.push('marketplace.json must include this plugin with path "."');
}

if (errors.length > 0) {
  for (const error of errors) console.error(error);
  process.exit(1);
}
NODE
then
  pass "Claude plugin manifest is synchronized with promoted skills and package version"
else
  fail "Claude plugin manifest validation failed"
fi

if [[ "$failures" -gt 0 ]]; then
  printf '\nValidation failed with %s issue(s).\n' "$failures" >&2
  exit 1
fi

printf '\nValidation passed.\n'
