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

## Invocation rules

User-invoked skills must include:

- `disable-model-invocation: true` in `SKILL.md` frontmatter
- `policy.allow_implicit_invocation: false` in `agents/openai.yaml`

Model-invoked skills should omit those settings and use rich trigger phrasing in their `description`.

## Router skill

When promoted user-facing skills are added, renamed, removed, or meaningfully changed, update the router/discovery skill.

## Validation

Run validation before opening or updating PRs:

```bash
npm run validate
```
