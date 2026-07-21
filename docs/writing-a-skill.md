# Writing a skill

A skill is a reusable agent capability packaged around a canonical `SKILL.md` file.

Good skills are small, specific, and repeatable. They should teach the agent a discipline or workflow it can reliably apply across repositories.

## Start from the template

Copy:

```txt
templates/skill/
```

into the right bucket:

```txt
skills/engineering/<skill-name>/
skills/productivity/<skill-name>/
skills/in-progress/<skill-name>/
```

Use `in-progress` when the skill is still experimental.

## Choose the invocation type

Every skill is either user-invoked or model-invoked.

### User-invoked skills

Use this for workflows the human must explicitly request, such as router skills, setup flows, or large orchestration commands.

`SKILL.md` frontmatter must include:

```yaml
disable-model-invocation: true
```

`agents/openai.yaml` must include:

```yaml
policy:
  allow_implicit_invocation: false
```

The description should be human-facing and concise.

### Model-invoked skills

Use this for reusable disciplines the model can automatically apply when relevant, such as TDD, debugging, research, or code review.

Do not disable model invocation.

The description should include trigger phrasing:

```yaml
description: Use when the user wants..., mentions..., asks for...
```

## Keep the skill focused

A skill should have one job. If it starts handling several unrelated workflows, split it into smaller skills.

Prefer:

- a named loop
- clear trigger boundaries
- hard rules
- checkable outputs

Avoid:

- broad generic advice
- project-specific assumptions in promoted skills
- duplicating long reference material inside `SKILL.md`

## Use supporting files

Supporting files are useful when they keep `SKILL.md` focused:

```txt
examples/
scripts/
templates/
fixtures/
mocking.md
tests.md
```

Reference these files from `SKILL.md` when the agent should read them.

## Human docs are different

`SKILL.md` is for the agent.

`docs/<bucket>/<skill>.md` is for people deciding whether to use the skill.

Human docs should explain:

- what the skill does
- when to reach for it
- prerequisites
- where it fits with neighboring skills

Do not copy the entire `SKILL.md` into docs.
