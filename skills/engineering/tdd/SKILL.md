---
name: tdd
description: Test-driven development. Use when the user wants to build features or fix bugs test-first, mentions red-green-refactor, or wants integration tests.
---

# Test-Driven Development

Use this skill to work in small red → green cycles that produce tests worth keeping.

## When to use this skill

Use when the user wants to:

- build a feature test-first
- fix a bug with a regression test
- add integration tests around behavior
- follow red-green-refactor

## Instructions

1. Identify the behavior the user wants.
2. Choose the public seam where that behavior should be tested.
3. Confirm the seam with the user when it is ambiguous.
4. Write one failing test for one vertical slice.
5. Run the test and confirm it fails for the expected reason.
6. Implement the smallest change that makes the test pass.
7. Run the targeted test again.
8. Repeat with the next slice.

## Rules

- Red before green: write the failing test first.
- Test behavior through public interfaces, not implementation details.
- One test, one seam, one minimal implementation per cycle.
- Prefer integration tests when behavior crosses module boundaries.
- Do not add speculative code for future tests.

## Supporting guidance

- Read [`tests.md`](./tests.md) for test quality guidance.
- Read [`mocking.md`](./mocking.md) before introducing mocks.

## Anti-patterns

- Testing private methods.
- Mocking internal collaborators just to make assertions easy.
- Writing a large batch of tests before learning from the first cycle.
- Adding implementation before a failing test exists.
