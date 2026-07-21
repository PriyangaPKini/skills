# Repository Rules

This repository stores reusable agent skills.

## Skill buckets

Promoted/public skills live in:

- `skills/engineering`
- `skills/productivity`

Non-promoted skills live in:

- `skills/misc`
- `skills/personal`
- `skills/in-progress`
- `skills/deprecated`

Only promoted skills should appear in the public catalog, human docs, and plugin manifests.

## Promoted skill requirements

Every promoted skill must have:

- `SKILL.md`
- `agents/openai.yaml`
- an entry in the root `README.md`
- an entry in its bucket `README.md`
- a human-facing docs page at `docs/<bucket>/<skill>.md`
- an entry in `.claude-plugin/plugin.json` when plugin distribution is enabled

## Invocation rules

User-invoked skills must include:

- `disable-model-invocation: true` in `SKILL.md` frontmatter
- `policy.allow_implicit_invocation: false` in `agents/openai.yaml`

Model-invoked skills should omit those settings and use rich trigger phrasing in their `description`.

## Router skill

When promoted user-facing skills are added, renamed, removed, or meaningfully changed, update the router/discovery skill.

## Claude plugin

`.claude-plugin/plugin.json` must list only promoted skill directories. Keep its `version` synchronized with `package.json`, and update `docs/installing-in-claude-code.md` when plugin installation instructions change.

## Releases

Keep `CHANGELOG.md` up to date for user-visible changes. Release commits must synchronize the version in `package.json` and `.claude-plugin/plugin.json`; release tags use `v<version>` and run `.github/workflows/release.yml`.

## Validation

Use the repository scripts to catch catalog and metadata drift:

```bash
npm run list-skills
npm run validate
```

`validate` checks promoted skill structure, docs coverage, README coverage, user-invoked metadata consistency, Claude plugin manifest sync, and that non-promoted skills are not exposed as public docs/catalog entries.

Run validation before opening or updating PRs.
