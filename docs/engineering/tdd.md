# TDD

Quickstart:

```bash
npx skills add PriyangaPKini/skills --skill=tdd
```

Source: [`skills/engineering/tdd`](https://github.com/PriyangaPKini/skills/tree/main/skills/engineering/tdd)

## Inspiration

This skill is inspired by and adapted from Matt Pocock's skills repository:

https://github.com/mattpocock/skills

## What it does

The TDD skill guides the agent through a red → green implementation loop: write one failing test, make it pass with the smallest useful change, then continue in small vertical slices.

Its defining constraint is that implementation should not come before a failing test for the behavior being added or fixed.

## When to reach for it

This is a model-invoked skill. Type `/tdd`, or let the agent reach for it automatically when you ask for test-first implementation, red-green-refactor, bug fixes with regression tests, or integration tests.

Reach for it when correctness matters and the behavior can be captured through a public seam.

## How it works

The core idea is a tight feedback loop. The agent picks one behavior, chooses the public seam where that behavior should be observed, writes one failing test, and then implements only enough code to pass that test.

The supporting docs cover test quality and mocking boundaries so the resulting tests stay useful after refactors.

## It's working if

- The agent writes or updates a failing test before implementation.
- The test verifies public behavior, not private implementation details.
- Each cycle is small enough to understand in isolation.
- The final change includes tests that would fail if the behavior regressed.

## Where it fits

Use TDD during implementation. Use `diagnosing-bugs` first when the cause of a failure is unknown, and use `code-review` afterward to check standards, spec fit, and test quality.
