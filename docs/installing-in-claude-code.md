# Installing in Claude Code

Claude Code can use skills installed through generic Agent Skills-compatible tooling or, later, a native plugin manifest.

## Preferred generic install

```bash
npx skills add PriyangaPKini/skills
```

Install one skill:

```bash
npx skills add PriyangaPKini/skills --skill=code-review
```

This installs editable skill files so you can adapt them to your own workflow.

## Manual install

Copy skill folders into Claude's local skills directory:

```bash
mkdir -p ~/.claude/skills
cp -R skills/engineering/tdd ~/.claude/skills/tdd
```

If installing from GitHub without cloning, download the full skill folder when it contains supporting files.

## Future plugin install

A native Claude Code plugin is planned as a later feature. Until `.claude-plugin/plugin.json` exists and is validated, use the generic or manual installation path.

## Notes

- User-invoked skills may appear as slash-command-like skills depending on the harness.
- Model-invoked skills rely on their description metadata to be discovered automatically.
