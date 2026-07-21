# Ask Skills

Quickstart:

```bash
npx skills add PriyangaPKini/skills --skill=ask-skills
```

Source: [`skills/productivity/ask-skills`](https://github.com/PriyangaPKini/skills/tree/main/skills/productivity/ask-skills)

## Inspiration

This skill is inspired by Matt Pocock's `ask-matt` router skill and his skills repository:

https://github.com/mattpocock/skills

## What it does

The ask-skills skill is a router over the promoted skills in this repository. It helps the user decide which skill best fits their current task.

Its defining constraint is that it chooses and explains; it does not silently invoke other user-invoked skills.

## When to reach for it

This is a user-invoked skill. You invoke it explicitly when you are unsure which skill to use.

Reach for it when you have a goal like debugging, implementation, review, planning, or documentation work and want the agent to map that goal to the right reusable workflow.

## How it works

The skill compares the user's goal against the promoted skill catalog, recommends the smallest useful skill, and explains how to invoke it.

If no promoted skill fits, it says so and can suggest drafting a new skill in `skills/in-progress`.

## It's working if

- The recommendation is short and specific.
- The skill explains why the recommendation fits.
- It does not recommend non-promoted skills as public options by default.
- It tells the user how to invoke the chosen skill.

## Where it fits

Use this as the entry point when you do not remember the catalog. It currently routes to engineering skills such as `tdd`, `diagnosing-bugs`, and `code-review`.
