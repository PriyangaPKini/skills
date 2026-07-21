# Diagnosing Bugs

Quickstart:

```bash
npx skills add PriyangaPKini/skills --skill=diagnosing-bugs
```

Source: [`skills/engineering/diagnosing-bugs`](https://github.com/PriyangaPKini/skills/tree/main/skills/engineering/diagnosing-bugs)

## Inspiration

This skill is inspired by and adapted from Matt Pocock's skills repository:

https://github.com/mattpocock/skills

## What it does

The diagnosing-bugs skill makes the agent investigate before changing code. It follows a reproduce → minimize → hypothesize → instrument → fix → regression-test loop.

Its defining constraint is evidence: the agent should not guess-and-fix before it has reproduced the problem or clearly stated what evidence is missing.

## When to reach for it

This is a model-invoked skill. Type `/diagnosing-bugs`, or let the agent reach for it automatically when you report something broken, throwing, failing, flaky, or slow.

Reach for it when the cause is unclear or when a quick fix would be risky.

## How it works

The skill slows the agent down enough to isolate the fault. It asks for a reproduction, reduces the problem to the smallest useful case, tests one hypothesis at a time, and only then applies the smallest proven fix.

The regression test is part of the diagnosis result, not an optional cleanup step.

## It's working if

- The bug is reproduced or the missing reproduction evidence is named.
- The agent records hypotheses and outcomes for non-trivial bugs.
- The fix is tied to a root cause, not just a symptom.
- A regression test or explicit test rationale is included.

## Where it fits

Use this before TDD when the problem is not yet understood. After the fix, use `code-review` to check whether the change is minimal, tested, and aligned with the requested behavior.
