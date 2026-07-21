# Code Review

Quickstart:

```bash
npx skills add PriyangaPKini/skills --skill=code-review
```

Source: [`skills/engineering/code-review`](https://github.com/PriyangaPKini/skills/tree/main/skills/engineering/code-review)

## Inspiration

This skill is inspired by and adapted from Matt Pocock's skills repository:

https://github.com/mattpocock/skills

## What it does

The code-review skill reviews a diff along two axes: standards and spec. Standards asks whether the code is maintainable, clear, tested, and consistent with the surrounding repo. Spec asks whether the change faithfully implements what was requested.

Its defining constraint is separation: standards findings and spec findings should not blur together.

## When to reach for it

This is a model-invoked skill. Type `/code-review`, or let the agent reach for it automatically when you ask to review a PR, branch, diff, or work-in-progress change.

Reach for it before merging or when you want a second pass after implementation.

## How it works

The skill identifies the review range, inspects changed files, checks implementation quality, checks the requested behavior, and reports blocking findings separately from non-blocking suggestions.

Findings should cite file paths and line numbers where possible.

## It's working if

- Findings are specific and actionable.
- Standards and spec concerns are separated.
- Blocking issues are clearly marked.
- The final summary states readiness and residual risk.

## Where it fits

Use this after implementation, after a TDD cycle, or after a bug fix. If the behavior is still unclear, clarify the spec before reviewing. If a failure is not understood, use `diagnosing-bugs` before reviewing the fix.
