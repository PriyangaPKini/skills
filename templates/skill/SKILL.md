---
name: skill-name
description: One-line description. For model-invoked skills, include trigger phrasing such as "Use when...".
# Add this only for user-invoked skills:
# disable-model-invocation: true
---

# Skill Name

## When to use this skill

Describe the situations where this skill applies.

For model-invoked skills, make the trigger boundary concrete enough that the model can decide when to reach for it.

For user-invoked skills, explain what the human is explicitly asking the agent to do.

## Instructions

Describe the workflow the agent should follow.

Prefer small, concrete steps. Make the loop or decision tree obvious.

## Rules

- Keep the skill focused on one job.
- State hard constraints clearly.
- Prefer reusable discipline over project-specific details.

## Outputs

Describe any files, commits, reports, issues, or other artifacts the skill should produce.

## Anti-patterns

- Doing unrelated work.
- Hiding prerequisites.
- Duplicating large docs that should be supporting files instead.
