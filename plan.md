# Reusable Agent Skills Repository Plan

## Goal

Create a public skills repository where reusable agent skills can be stored, documented, versioned, and installed into agents such as Pi, Claude Code, Codex, and other Agent-Skills-compatible harnesses.

This should be more than a folder of prompts. It should be a maintainable, distributable skill system.

## Inspiration

This plan is inspired by Matt Pocock's `mattpocock/skills` repository.

Key lessons from that repo:

- Skills need lifecycle buckets, not one flat folder.
- Public/promoted skills should be separated from drafts, personal skills, deprecated skills, and miscellaneous experiments.
- `SKILL.md` is the canonical agent instruction file.
- Human-facing docs should explain when and why to use a skill, not duplicate `SKILL.md`.
- Each skill may need agent-specific metadata.
- Distribution should use standard installers/plugins where possible, not only custom shell scripts.
- The repo needs governance rules so future edits stay consistent.

---

## Repository Structure

```txt
skills/
  README.md
  LICENSE
  CONTRIBUTING.md
  CHANGELOG.md
  package.json
  CLAUDE.md

  .github/
    workflows/
      validate.yml
      release.yml

  .claude-plugin/
    plugin.json
    marketplace.json

  docs/
    writing-a-skill.md
    promotion-checklist.md
    installing-in-pi.md
    installing-in-claude-code.md
    installing-in-codex.md
    adr/
      0001-repo-structure.md
      0002-user-vs-model-invoked-skills.md
      0003-distribution-strategy.md
    engineering/
      tdd.md
      diagnosing-bugs.md
      code-review.md
    productivity/
      ask-skills.md
      handoff.md

  skills/
    engineering/
      README.md
      tdd/
        SKILL.md
        agents/
          openai.yaml
        tests.md
        mocking.md
      diagnosing-bugs/
        SKILL.md
        agents/
          openai.yaml
      code-review/
        SKILL.md
        agents/
          openai.yaml

    productivity/
      README.md
      ask-skills/
        SKILL.md
        agents/
          openai.yaml
      handoff/
        SKILL.md
        agents/
          openai.yaml

    misc/
      README.md

    personal/
      README.md

    in-progress/
      README.md

    deprecated/
      README.md

  templates/
    skill/
      SKILL.md
      agents/
        openai.yaml
      README.md

  scripts/
    list-skills.sh
    validate-skills.sh
    link-skills.sh
```

---

## Skill Buckets

### Promoted buckets

These are public, stable, documented skills.

```txt
skills/engineering/
skills/productivity/
```

Promoted skills must appear in:

- root `README.md`
- bucket `README.md`
- human docs under `docs/<bucket>/<skill>.md`
- plugin manifests, if plugin distribution is enabled
- router/discovery skill, if user-facing

### Non-promoted buckets

These are not part of the public catalog.

```txt
skills/misc/
skills/personal/
skills/in-progress/
skills/deprecated/
```

Use them as follows:

- `misc/` — useful but not core or not actively promoted
- `personal/` — tied to private/local workflows
- `in-progress/` — drafts and experiments
- `deprecated/` — replaced or retired skills kept for reference

---

## Standard Skill Folder

Each skill should live in its own folder:

```txt
skills/engineering/tdd/
  SKILL.md
  agents/
    openai.yaml
  README.md              # optional local human note
  examples/              # optional
  scripts/               # optional
  templates/             # optional
  supporting-docs.md     # optional
```

### Required files

```txt
SKILL.md
agents/openai.yaml
```

### Optional files

Use supporting files when they reduce token load or make the skill clearer:

```txt
examples/
scripts/
templates/
fixtures/
mocking.md
tests.md
```

---

## `SKILL.md` Template

```md
---
name: skill-name
description: One-line description. For model-invoked skills, include trigger phrasing such as "Use when...".
---

# Skill Name

## When to use this skill

Describe the situations where this skill applies.

## Instructions

Describe the workflow the agent should follow.

## Rules

- Rule one
- Rule two
- Rule three

## Outputs

Describe any expected artifacts.

## Anti-patterns

Describe common mistakes this skill should avoid.
```

---

## User-Invoked vs Model-Invoked Skills

Every skill should be classified as one of two types.

### User-invoked skills

The human must explicitly call these. They should not be automatically invoked by the model.

Use for orchestration skills, workflows, and slash-command-like tools.

Example frontmatter:

```md
---
name: implement
description: Implement a piece of work based on a spec or set of tickets.
disable-model-invocation: true
---
```

Example `agents/openai.yaml`:

```yaml
interface:
  display_name: "Implement"
  short_description: "Build work from a spec or tickets"
policy:
  allow_implicit_invocation: false
```

### Model-invoked skills

The model may automatically use these when the task fits.

Use for reusable disciplines like TDD, debugging, research, code review, and domain modeling.

Example frontmatter:

```md
---
name: tdd
description: Test-driven development. Use when the user wants to build features or fix bugs test-first, mentions red-green-refactor, or wants integration tests.
---
```

Example `agents/openai.yaml`:

```yaml
interface:
  display_name: "TDD"
  short_description: "Test-driven red-green-refactor"
```

---

## Human Documentation Strategy

Human docs are separate from `SKILL.md`.

`SKILL.md` is for the agent.

`docs/<bucket>/<skill>.md` is for people deciding whether to install or invoke the skill.

Each promoted skill gets a docs page:

```txt
docs/engineering/tdd.md
docs/productivity/ask-skills.md
```

### Docs page template

```md
Quickstart:

```bash
npx skills add YOUR_USERNAME/skills --skill=<skill-name>
```

```bash
npx skills update <skill-name>
```

[Source](https://github.com/YOUR_USERNAME/skills/tree/main/skills/<bucket>/<skill-name>)

## What it does

Explain the skill in one or two paragraphs.

## When to reach for it

Say whether the user invokes it explicitly or the model can invoke it automatically.

## Prerequisites

Include only if needed.

## How it works

Explain the core idea, not every step from `SKILL.md`.

## It's working if

Optional checklist of observable signals.

## Where it fits

Explain how this skill relates to neighboring skills.
```

---

## Root README Strategy

The root `README.md` should be product-facing.

It should include:

1. What this repo is
2. Why skills are useful
3. Quickstart install
4. Available promoted skills
5. Installation options by agent
6. Contribution guide link
7. Skill-writing guide link
8. License

Example catalog:

```md
## Engineering Skills

### User-invoked

- [`ask-skills`](./skills/productivity/ask-skills/SKILL.md) — Ask which skill fits your situation.
- [`implement`](./skills/engineering/implement/SKILL.md) — Build from a spec or tickets.

### Model-invoked

- [`tdd`](./skills/engineering/tdd/SKILL.md) — Test-driven development.
- [`diagnosing-bugs`](./skills/engineering/diagnosing-bugs/SKILL.md) — Disciplined debugging loop.
- [`code-review`](./skills/engineering/code-review/SKILL.md) — Review changes against standards and spec.
```

---

## Bucket README Strategy

Each bucket should have its own `README.md`.

Example:

```md
# Engineering

Skills for daily software engineering work.

## User-invoked

- [`ask-skills`](./ask-skills/SKILL.md) — Ask which skill fits your situation.

## Model-invoked

- [`tdd`](./tdd/SKILL.md) — Test-driven development.
- [`diagnosing-bugs`](./diagnosing-bugs/SKILL.md) — Debug hard failures systematically.
```

---

## Distribution Strategy

### Phase 1: Manual and `skills.sh` installation

Support installation through the standard skills installer:

```bash
npx skills add YOUR_USERNAME/skills
```

Single skill:

```bash
npx skills add YOUR_USERNAME/skills --skill=tdd
```

Also document manual installation for Pi, Claude Code, and Codex.

### Phase 2: Claude Code plugin

Add:

```txt
.claude-plugin/plugin.json
.claude-plugin/marketplace.json
```

Example plugin manifest:

```json
{
  "name": "your-skills",
  "version": "0.1.0",
  "description": "Reusable agent skills for engineering and productivity.",
  "skills": [
    "./skills/engineering/tdd",
    "./skills/engineering/diagnosing-bugs",
    "./skills/engineering/code-review",
    "./skills/productivity/ask-skills"
  ]
}
```

Install command:

```bash
claude plugin marketplace add YOUR_USERNAME/skills
claude plugin install your-skills@YOUR_USERNAME
```

### Phase 3: Other native plugin formats

Investigate native packaging for:

- Codex
- Pi
- other Agent-Skills-compatible harnesses

Avoid claiming full support until tested.

---

## Maintainer Tooling

### `scripts/list-skills.sh`

Lists all skill files.

```bash
find skills -name SKILL.md | sort
```

### `scripts/validate-skills.sh`

Should check:

- every promoted skill has `SKILL.md`
- every promoted skill has `agents/openai.yaml`
- every promoted skill appears in bucket README
- every promoted skill appears in root README
- every promoted skill has human docs
- user-invoked skills have matching metadata in both `SKILL.md` and `agents/openai.yaml`
- plugin manifest includes all promoted skills
- deprecated/in-progress/personal skills are not in public manifests

### `scripts/link-skills.sh`

Maintainer-only local symlink helper.

Targets may include:

```txt
~/.claude/skills
~/.agents/skills
~/.pi/agent/skills
```

This is not the public installer.

---

## Governance File

Create `CLAUDE.md` or `AGENTS.md` at the repo root.

It should document invariants such as:

- which buckets are promoted
- what must be updated when a promoted skill changes
- docs requirements
- invocation metadata rules
- plugin manifest rules
- version sync rules
- router skill update rules
- validation command

Example rules:

```md
# Repo Rules

Promoted skills live in `skills/engineering` and `skills/productivity`.

Every promoted skill must be listed in:

- root `README.md`
- its bucket `README.md`
- `docs/<bucket>/<skill>.md`
- `.claude-plugin/plugin.json`, if plugin support is enabled

User-invoked skills must include:

- `disable-model-invocation: true` in `SKILL.md`
- `policy.allow_implicit_invocation: false` in `agents/openai.yaml`

Model-invoked skills must have rich trigger phrasing in their description.
```

---

## ADRs

Add lightweight architectural decision records.

```txt
docs/adr/0001-repo-structure.md
docs/adr/0002-user-vs-model-invoked-skills.md
docs/adr/0003-distribution-strategy.md
```

These should explain why the repo is structured this way so future agents do not accidentally flatten or break it.

---

## Router / Discovery Skill

Create a skill that helps users choose which skill to use.

```txt
skills/productivity/ask-skills/
  SKILL.md
  agents/openai.yaml
```

Purpose:

> Ask which skill or workflow fits the user's current situation.

This skill should be updated whenever promoted user-facing skills are added, removed, renamed, or significantly changed.

---

## Initial Skill Set

### Engineering

```txt
tdd
diagnosing-bugs
code-review
research
refactor-planning
```

### Productivity

```txt
ask-skills
handoff
grilling
```

### In-progress

```txt
api-design
domain-modeling
qa-session
```

---

## MVP Scope

Build the smallest useful version first.

```txt
README.md
LICENSE
CONTRIBUTING.md
CLAUDE.md
package.json

skills/
  engineering/
    README.md
    tdd/
      SKILL.md
      agents/openai.yaml
    diagnosing-bugs/
      SKILL.md
      agents/openai.yaml
    code-review/
      SKILL.md
      agents/openai.yaml
  productivity/
    README.md
    ask-skills/
      SKILL.md
      agents/openai.yaml
  in-progress/
    README.md
  deprecated/
    README.md

docs/
  writing-a-skill.md
  promotion-checklist.md
  engineering/tdd.md
  engineering/diagnosing-bugs.md
  engineering/code-review.md
  productivity/ask-skills.md

scripts/
  list-skills.sh
  validate-skills.sh
```

Defer until Phase 2:

```txt
.claude-plugin/
CHANGELOG.md
release workflow
advanced installer scripts
```

---

## Implementation Phases

### Phase 1: Repository skeleton

- Create repo files
- Create bucket directories
- Add README files
- Add `CLAUDE.md`
- Add initial docs
- Add templates

### Phase 2: Initial skills

Add first promoted skills:

- `tdd`
- `diagnosing-bugs`
- `code-review`
- `ask-skills`

Each gets:

- `SKILL.md`
- `agents/openai.yaml`
- docs page
- README entry

### Phase 3: Validation

Add scripts to validate:

- skill structure
- docs coverage
- metadata consistency
- README coverage

Add GitHub Actions to run validation.

### Phase 4: Distribution

Support:

```bash
npx skills add YOUR_USERNAME/skills
```

Then add Claude plugin support.

### Phase 5: Release process

Add:

- `CHANGELOG.md`
- versioning process
- release workflow
- contribution checklist

### Phase 6: Expand library

Add more skills gradually:

- research
- refactor-planning
- domain-modeling
- qa-session
- api-design
- setup-pre-commit

Promote only once documented and validated.

---

## Definition of Done

The repo is ready when:

- skills are bucketed by lifecycle
- promoted skills are clearly listed
- each promoted skill has `SKILL.md`
- each promoted skill has metadata
- each promoted skill has human docs
- install instructions are clear
- validation scripts catch drift
- README explains the system
- users can install at least one skill into their agent
- future contributors know how to add or promote a skill
