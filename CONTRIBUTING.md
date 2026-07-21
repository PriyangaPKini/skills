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

```bash
npm run validate
```

## Promoting a skill

A promoted skill must be stable enough for other people to install and use.

Before promoting a skill, make sure it has:

- a focused job
- clear invocation metadata
- a docs page
- README entries
- validation passing

## Pull requests

Before opening a pull request:

- run `npm run validate` locally
- make sure README and docs changes are included for promoted skills
- keep non-promoted skills out of the public catalog

GitHub Actions runs the same validation command on pull requests.

## Deprecated skills

Do not delete useful retired skills immediately. Move them to `skills/deprecated` and document the replacement when possible.

## Releases

This repository uses a lightweight manual release process.

Before cutting a release:

1. Update `CHANGELOG.md`.
2. Keep the version in `package.json` synchronized with `.claude-plugin/plugin.json`.
3. Run `npm run validate`.
4. Tag the release as `v<version>` after the release commit lands on `main`.

Release tags run validation in GitHub Actions before GitHub release notes are created.
