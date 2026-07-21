---
name: ask-skills
description: Ask which skill or workflow fits the current situation.
disable-model-invocation: true
---

# Ask Skills

Use this skill when the user explicitly asks which skill to use, how to approach a task with this skills repo, or whether a reusable workflow exists for their situation.

## Instructions

1. Clarify the user's goal in one or two questions if needed.
2. Match the goal to the smallest useful skill.
3. Explain why that skill fits.
4. If no promoted skill fits, say so and suggest either normal agent work or drafting a new skill in `skills/in-progress`.
5. Do not invoke another user-invoked skill automatically. Tell the user which skill to invoke.

## Current skill map

### Engineering

- `tdd` — use for test-first feature work, bug fixes with regression tests, red-green-refactor, or integration-test-driven implementation.
- `diagnosing-bugs` — use for broken, failing, flaky, throwing, or slow behavior where the cause is not yet clear.
- `code-review` — use for reviewing a PR, branch, diff, or work-in-progress changes against standards and spec.
- `incremental-delivery-workflow` — use for implementing or resuming a finalized plan as small reviewable Git/GitHub PR slices, preserving linear Git history, coordinating serial phases, or parallelizing independent task branches when requested.

### Productivity

- `ask-skills` — use when the user wants help choosing a skill.

## Rules

- Prefer the smallest skill that solves the user's problem.
- Do not recommend draft, personal, miscellaneous, or deprecated skills as public options unless the user explicitly asks to inspect them.
- Make uncertainty explicit when more context is needed.
- Keep the answer short and actionable.

## Output format

```md
Recommended skill: `<skill-name>`

Why:
- <reason>

How to invoke:
- <command or wording>
```
