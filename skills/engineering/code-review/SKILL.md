---
name: code-review
description: Review code changes against standards and spec. Use when the user asks to review a branch, PR, diff, or work-in-progress changes.
---

# Code Review

Use this skill to review changes along two axes: standards and spec.

## When to use this skill

Use when the user asks for:

- a PR review
- a branch review
- review of uncommitted changes
- review since a commit, tag, or branch
- a second pass before merging

## Instructions

1. Identify the review range.
2. Inspect the changed files.
3. Review against standards:
   - clarity
   - maintainability
   - test quality
   - error handling
   - consistency with nearby code
4. Review against spec:
   - what the user asked for
   - issue or PRD requirements
   - acceptance criteria
   - missing or extra behavior
5. Separate blocking findings from non-blocking suggestions.
6. Cite file paths and line numbers where possible.
7. Summarize residual risk.

## Rules

- Do not rewrite the code during review unless the user explicitly asks.
- Prefer specific findings over vague advice.
- Do not invent requirements that are not in the spec or surrounding codebase.
- Mark uncertainty clearly.

## Output format

```md
## Standards review

- [blocking|non-blocking] Finding with file path and reason.

## Spec review

- [blocking|non-blocking] Finding with file path and reason.

## Summary

- Overall readiness
- Residual risks
```

## Anti-patterns

- Mixing style nits with correctness issues.
- Reviewing only formatting while missing behavior.
- Assuming the implementation goal without checking the spec.
