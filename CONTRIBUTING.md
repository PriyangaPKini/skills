# Contributing

Thanks for helping improve this skills repository.

## Adding a skill

1. Choose the right bucket under `skills/`.
2. Start from `templates/skill` once templates exist.
3. Add a `SKILL.md` with clear frontmatter.
4. Add `agents/openai.yaml` metadata.
5. If the skill is promoted, add human docs under `docs/<bucket>/<skill>.md`.
6. Update the root README and bucket README.
7. Run validation before opening a PR.

## Promoting a skill

A promoted skill must be stable enough for other people to install and use.

Before promoting a skill, make sure it has:

- a focused job
- clear invocation metadata
- a docs page
- README entries
- validation passing

## Deprecated skills

Do not delete useful retired skills immediately. Move them to `skills/deprecated` and document the replacement when possible.
