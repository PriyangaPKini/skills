# Installing in Claude Code

Claude Code can use skills installed through generic Agent Skills-compatible tooling or through the native plugin manifest in this repository.

## Preferred generic install

```bash
npx skills add PriyangaPKini/skills
```

Install one skill:

```bash
npx skills add PriyangaPKini/skills --skill=code-review
```

This installs editable skill files so you can adapt them to your own workflow.

## Updating installed skills

Editable/manual skill files do not update automatically. After a repository change is merged, rerun the installer to refresh all skills:

```bash
npx skills add PriyangaPKini/skills
```

Or refresh one skill:

```bash
npx skills add PriyangaPKini/skills --skill=incremental-delivery-workflow
```

For plugin installs, update or reinstall through Claude Code's plugin workflow.

## Manual install

Copy skill folders into Claude's local skills directory:

```bash
mkdir -p ~/.claude/skills
cp -R skills/engineering/tdd ~/.claude/skills/tdd
```

If installing from GitHub without cloning, download the full skill folder when it contains supporting files.

## Plugin install

This repository includes Claude Code plugin metadata at [`.claude-plugin/plugin.json`](../.claude-plugin/plugin.json). The plugin manifest includes only promoted skills.

Add the repository as a Claude plugin marketplace, then install the plugin:

```bash
claude plugin marketplace add PriyangaPKini/skills
claude plugin install skills@PriyangaPKini
```

Use the generic installer when you want editable local skill files. Use the plugin path when you want Claude Code to consume the promoted catalog through its native plugin workflow.

## Notes

- User-invoked skills may appear as slash-command-like skills depending on the harness.
- Model-invoked skills rely on their description metadata to be discovered automatically.
