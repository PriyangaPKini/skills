---
name: diagnosing-bugs
description: Disciplined diagnosis loop for hard bugs and performance regressions. Use when the user reports something broken, throwing, failing, flaky, or slow.
---

# Diagnosing Bugs

Use this skill to diagnose before fixing.

## When to use this skill

Use when the user reports:

- a failing test
- an exception or crash
- broken behavior
- a performance regression
- flaky behavior
- a bug with unclear cause

## Instructions

Follow this loop:

1. Reproduce the problem.
2. Minimize the reproduction to the smallest useful case.
3. State the observed behavior and expected behavior.
4. Form one hypothesis at a time.
5. Add instrumentation or targeted checks to test the hypothesis.
6. Use the result to eliminate or confirm the hypothesis.
7. Fix the smallest proven cause.
8. Add or update a regression test.
9. Run the relevant checks.

## Rules

- Do not guess-and-fix before reproducing.
- Change one variable at a time.
- Prefer direct evidence over intuition.
- Keep notes on hypotheses and outcomes for hard bugs.
- If the reproduction cannot be created, explain what evidence is missing.

## Outputs

For non-trivial bugs, report:

- reproduction steps
- root cause
- fix summary
- regression test or reason one was not added
- checks run

## Anti-patterns

- Applying broad rewrites before identifying the cause.
- Treating symptoms as root causes.
- Ignoring flaky or intermittent evidence.
- Declaring success without rerunning the reproduction.
