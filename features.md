# Skills Repository Feature Breakdown

This breaks `plan.md` into meaningful, reviewable implementation features. These are designed to map cleanly onto a linear PR workflow later: one base feature branch, then one slice PR per feature or phase.

## Proposed execution shape

Use a **serial phase workflow** for the first implementation because several features depend on earlier structure being present.

Recommended base branch:

```txt
feature/skills-repo-foundation
```

Recommended slice branch pattern:

```txt
phase/<number>-<feature-slug>
```

---

## Feature 1: Repository foundation

### Goal

Create the minimal root-level repository structure and identity for the `skills` repo.

### Scope

Add:

```txt
README.md
LICENSE
CONTRIBUTING.md
package.json
CLAUDE.md
.gitignore
```

### Requirements

- `README.md` explains what the repo is and who it is for.
- `package.json` identifies the repo as `skills` and includes basic metadata.
- `CLAUDE.md` documents maintainer rules for future agents.
- `CONTRIBUTING.md` explains how to propose or edit skills.
- `LICENSE` should likely be MIT unless we choose otherwise.

### Out of scope

- Actual skill content
- Plugin manifests
- CI workflows
- Release automation

### Acceptance criteria

- A fresh visitor can understand the purpose of the repo from `README.md`.
- A future agent can understand the repo invariants from `CLAUDE.md`.
- Root files are in place and internally consistent.

### Suggested slice branch

```txt
phase/1-repository-foundation
```

---

## Feature 2: Skill bucket architecture

### Goal

Create the lifecycle/category bucket structure for skills.

### Scope

Add:

```txt
skills/
  engineering/
    README.md
  productivity/
    README.md
  misc/
    README.md
  personal/
    README.md
  in-progress/
    README.md
  deprecated/
    README.md
```

### Requirements

- `engineering/` and `productivity/` are documented as promoted/public buckets.
- `misc/`, `personal/`, `in-progress/`, and `deprecated/` are documented as non-promoted buckets.
- Bucket READMEs explain what belongs there.
- Root README links to promoted bucket READMEs.

### Out of scope

- Adding real skill folders
- Validation scripts
- Plugin manifests

### Acceptance criteria

- The distinction between promoted and non-promoted skills is clear.
- Someone adding a new skill knows which bucket to choose.

### Suggested slice branch

```txt
phase/2-skill-buckets
```

---

## Feature 3: Skill authoring templates and docs

### Goal

Make it easy to add new skills consistently.

### Scope

Add:

```txt
templates/
  skill/
    SKILL.md
    agents/
      openai.yaml
    README.md

docs/
  writing-a-skill.md
  promotion-checklist.md
```

### Requirements

- `templates/skill/SKILL.md` includes standard frontmatter and instruction sections.
- `templates/skill/agents/openai.yaml` includes display metadata.
- `writing-a-skill.md` explains how to write useful, focused skills.
- `promotion-checklist.md` explains what is required before moving a skill into a promoted bucket.
- Docs explain user-invoked vs model-invoked skills.

### Out of scope

- Real promoted skills
- Validation automation

### Acceptance criteria

- A contributor can scaffold a new skill from the template.
- The invocation metadata rules are documented.
- Promotion rules are clear and checkable.

### Suggested slice branch

```txt
phase/3-skill-authoring-templates
```

---

## Feature 4: Initial promoted engineering skills

### Goal

Add the first stable engineering skills.

### Scope

Add:

```txt
skills/engineering/tdd/
  SKILL.md
  agents/openai.yaml
  tests.md
  mocking.md

skills/engineering/diagnosing-bugs/
  SKILL.md
  agents/openai.yaml

skills/engineering/code-review/
  SKILL.md
  agents/openai.yaml
```

Update:

```txt
skills/engineering/README.md
README.md
```

### Requirements

- Each skill has a clear `name` and `description` in `SKILL.md` frontmatter.
- Each skill has `agents/openai.yaml` metadata.
- These skills should be model-invoked by default.
- Descriptions should include trigger phrasing such as “Use when...”.
- Engineering bucket README lists each skill.
- Root README lists each promoted skill.

### Out of scope

- Human docs pages for each skill, unless combined with Feature 5
- Plugin manifests
- CI validation

### Acceptance criteria

- TDD skill defines a red/green/refactor loop and testing rules.
- Diagnosing bugs skill defines a reproduce → minimize → hypothesize → instrument → fix → regression-test loop.
- Code review skill defines at least standards review and spec review.
- Promoted skill lists are updated.

### Suggested slice branch

```txt
phase/4-initial-engineering-skills
```

---

## Feature 5: Human-facing docs for promoted skills

### Goal

Create docs pages that help people understand when and why to use each promoted skill.

### Scope

Add:

```txt
docs/
  engineering/
    tdd.md
    diagnosing-bugs.md
    code-review.md
```

### Requirements

Each docs page should include:

- Quickstart install command
- Source link
- What it does
- When to reach for it
- Prerequisites, if any
- How it works at a conceptual level
- Where it fits with neighboring skills

### Out of scope

- Copying full `SKILL.md` instructions into docs
- Plugin support

### Acceptance criteria

- Every promoted engineering skill has a docs page.
- Docs explain why/when, not just implementation steps.
- Links point to the correct skill folders.

### Suggested slice branch

```txt
phase/5-promoted-skill-docs
```

---

## Feature 6: Router / discovery skill

### Goal

Add a user-invoked skill that helps users decide which skill to use.

### Scope

Add:

```txt
skills/productivity/ask-skills/
  SKILL.md
  agents/openai.yaml

docs/productivity/ask-skills.md
```

Update:

```txt
skills/productivity/README.md
README.md
CLAUDE.md
```

### Requirements

- `ask-skills` is user-invoked only.
- `SKILL.md` includes `disable-model-invocation: true`.
- `agents/openai.yaml` includes `policy.allow_implicit_invocation: false`.
- The skill maps users to available promoted skills.
- `CLAUDE.md` says this router must be updated when user-facing promoted skills change.

### Out of scope

- Complex interactive setup
- External issue tracker integration

### Acceptance criteria

- Users can ask which skill fits their current situation.
- Invocation metadata correctly prevents implicit model invocation.
- README and docs list the skill correctly.

### Suggested slice branch

```txt
phase/6-router-discovery-skill
```

---

## Feature 7: Installation documentation

### Goal

Document how users install these skills into different agent harnesses.

### Scope

Add:

```txt
docs/
  installing-in-pi.md
  installing-in-claude-code.md
  installing-in-codex.md
```

Update:

```txt
README.md
```

### Requirements

- Explain `npx skills add YOUR_USERNAME/skills` as the preferred generic install path.
- Explain manual install paths where known.
- Clearly mark untested or future-native plugin support.
- Avoid claiming full support for an agent until verified.

### Out of scope

- Building plugin manifests
- Building installer scripts

### Acceptance criteria

- A user can install at least one skill manually.
- Generic `skills.sh` installation is documented.
- Pi, Claude Code, and Codex each have a dedicated install doc.

### Suggested slice branch

```txt
phase/7-installation-docs
```

---

## Feature 8: Validation scripts

### Goal

Add basic automation to catch drift between skills, docs, READMEs, and metadata.

### Scope

Add:

```txt
scripts/
  list-skills.sh
  validate-skills.sh
```

Update:

```txt
package.json
README.md
CLAUDE.md
```

### Requirements

`list-skills.sh` should list all `SKILL.md` files.

`validate-skills.sh` should check at least:

- promoted skills have `SKILL.md`
- promoted skills have `agents/openai.yaml`
- promoted skills appear in bucket README
- promoted skills appear in root README
- promoted skills have docs pages
- user-invoked skills have matching metadata in `SKILL.md` and `agents/openai.yaml`
- non-promoted skills are not listed as promoted

### Out of scope

- Full schema validation
- Release automation
- GitHub Actions, unless simple enough to add separately

### Acceptance criteria

- `scripts/list-skills.sh` runs successfully.
- `scripts/validate-skills.sh` runs successfully on the current repo.
- Validation failures produce actionable messages.

### Suggested slice branch

```txt
phase/8-validation-scripts
```

---

## Feature 9: CI validation workflow

### Goal

Run validation automatically on pull requests.

### Scope

Add:

```txt
.github/workflows/validate.yml
```

Update:

```txt
README.md
CONTRIBUTING.md
```

### Requirements

- CI runs the validation script.
- CI uses a simple, reliable environment.
- Contribution docs tell contributors to run validation locally.

### Out of scope

- Release workflow
- Plugin validation

### Acceptance criteria

- Pull requests run validation automatically.
- Local and CI validation commands match.

### Suggested slice branch

```txt
phase/9-ci-validation
```

---

## Feature 10: Claude Code plugin distribution

### Goal

Package promoted skills as a Claude Code plugin.

### Scope

Add:

```txt
.claude-plugin/
  plugin.json
  marketplace.json
```

Update:

```txt
README.md
docs/installing-in-claude-code.md
CLAUDE.md
package.json
```

### Requirements

- Plugin manifest lists only promoted skills.
- Plugin metadata describes the repo clearly.
- Version in plugin manifest stays in sync with `package.json`.
- Docs explain plugin install commands.
- `CLAUDE.md` documents plugin sync rules.

### Out of scope

- Native Codex plugin
- Release automation, unless implemented in Feature 11

### Acceptance criteria

- Claude plugin manifest is valid.
- Promoted skills are included.
- Non-promoted skills are excluded.
- Install docs explain plugin vs editable install tradeoff.

### Suggested slice branch

```txt
phase/10-claude-plugin-distribution
```

---

## Feature 11: Release and changelog process

### Goal

Add a lightweight release process for users who subscribe to the repo or plugin.

### Scope

Add:

```txt
CHANGELOG.md
.github/workflows/release.yml
```

Update:

```txt
package.json
CONTRIBUTING.md
CLAUDE.md
```

Optional:

```txt
.changeset/
```

### Requirements

- Define how versions are bumped.
- Define how changes are recorded.
- Keep package/plugin versions synchronized if plugin support exists.
- Document release steps for maintainers.

### Out of scope

- Publishing to npm unless explicitly chosen
- Native Codex plugin

### Acceptance criteria

- There is a clear changelog policy.
- Maintainers know how to cut a release.
- Version sync rules are documented.

### Suggested slice branch

```txt
phase/11-release-process
```

---

## Feature 12: Future skill expansion

### Goal

Add more skills after the foundation is stable.

### Candidate skills

Engineering:

```txt
research
refactor-planning
domain-modeling
qa-session
api-design
setup-pre-commit
```

Productivity:

```txt
handoff
grilling
teach
```

### Requirements

Each new promoted skill must include:

- `SKILL.md`
- `agents/openai.yaml`
- docs page
- root README entry
- bucket README entry
- router update, if user-facing
- validation pass

### Acceptance criteria

- New skills follow the same structure as the initial skills.
- The promoted catalog remains accurate.
- In-progress skills are not promoted until they meet the checklist.

### Suggested slice branch

```txt
phase/12-expand-skill-library
```

---

## Recommended MVP features

For the first implementation pass, complete only these features:

1. Repository foundation
2. Skill bucket architecture
3. Skill authoring templates and docs
4. Initial promoted engineering skills
5. Human-facing docs for promoted skills
6. Router / discovery skill
7. Installation documentation
8. Validation scripts

Defer these until after the MVP is reviewed:

9. CI validation workflow
10. Claude Code plugin distribution
11. Release and changelog process
12. Future skill expansion

---

## Dependency map

```txt
Feature 1: Repository foundation
  -> Feature 2: Skill bucket architecture
    -> Feature 3: Skill authoring templates and docs
      -> Feature 4: Initial promoted engineering skills
        -> Feature 5: Human-facing docs for promoted skills
          -> Feature 6: Router / discovery skill
            -> Feature 7: Installation documentation
              -> Feature 8: Validation scripts
                -> Feature 9: CI validation workflow
                  -> Feature 10: Claude Code plugin distribution
                    -> Feature 11: Release and changelog process
                      -> Feature 12: Future skill expansion
```

Some features can later be parallelized after Feature 3, but the MVP should stay serial for simpler review.

---

## Linear PR workflow mapping

When ready to implement, use this mapping:

- Base branch: `feature/skills-repo-foundation`
- Aggregate PR: `feature/skills-repo-foundation` -> deployment branch
- Slice PRs:
  - `phase/1-repository-foundation` -> `feature/skills-repo-foundation`
  - `phase/2-skill-buckets` -> `feature/skills-repo-foundation`
  - `phase/3-skill-authoring-templates` -> `feature/skills-repo-foundation`
  - `phase/4-initial-engineering-skills` -> `feature/skills-repo-foundation`
  - `phase/5-promoted-skill-docs` -> `feature/skills-repo-foundation`
  - `phase/6-router-discovery-skill` -> `feature/skills-repo-foundation`
  - `phase/7-installation-docs` -> `feature/skills-repo-foundation`
  - `phase/8-validation-scripts` -> `feature/skills-repo-foundation`

Do not start implementation until this feature breakdown is reviewed and approved.
