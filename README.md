# Skills

Reusable agent skills for engineering and productivity workflows.

This repository stores portable `SKILL.md` files that can be installed into Pi, Claude Code, Codex, and other Agent-Skills-compatible coding agents.

The goal is to provide a maintainable skill system, not just a folder of prompts:

- stable skills are documented and promoted intentionally
- draft, personal, deprecated, and miscellaneous skills are separated from the public catalog
- each skill has agent-facing instructions plus human-facing usage docs
- validation scripts catch drift between docs, manifests, and skill metadata

## Status

This repository is being built from [`plan.md`](./plan.md) and [`features.md`](./features.md).

## Skill buckets

Skills are organized by lifecycle and audience.

### Promoted skill buckets

These buckets are the public catalog. Skills here are expected to be stable, documented, and installable.

- [`skills/engineering`](./skills/engineering/README.md) — daily software engineering skills
- [`skills/productivity`](./skills/productivity/README.md) — general workflow and productivity skills

#### Engineering skills

Model-invoked:

- [`tdd`](./skills/engineering/tdd/SKILL.md) — Test-driven development with red-green implementation.
- [`diagnosing-bugs`](./skills/engineering/diagnosing-bugs/SKILL.md) — Reproduce, isolate, fix, and regression-test bugs.
- [`code-review`](./skills/engineering/code-review/SKILL.md) — Review changes against standards and spec.

#### Productivity skills

User-invoked:

- [`ask-skills`](./skills/productivity/ask-skills/SKILL.md) — Ask which skill or workflow fits the current situation.

### Non-promoted buckets

These buckets are intentionally excluded from the public catalog and future plugin manifests.

- [`skills/misc`](./skills/misc/README.md) — useful but not core or not actively promoted
- [`skills/personal`](./skills/personal/README.md) — private/local workflow skills
- [`skills/in-progress`](./skills/in-progress/README.md) — drafts and experiments
- [`skills/deprecated`](./skills/deprecated/README.md) — retired or replaced skills kept for reference

## Installation

Installation documentation will be added during the installation docs feature.

## Creating skills

- Read [`docs/writing-a-skill.md`](./docs/writing-a-skill.md) before adding a skill.
- Use [`templates/skill`](./templates/skill) as the starting point.
- Use [`docs/promotion-checklist.md`](./docs/promotion-checklist.md) before promoting a skill.

## Contributing

See [`CONTRIBUTING.md`](./CONTRIBUTING.md).
