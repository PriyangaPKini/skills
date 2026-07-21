# Promotion checklist

Use this checklist before moving a skill into a promoted bucket:

```txt
skills/engineering/
skills/productivity/
```

Promoted skills are part of the public catalog and should be stable enough for other people to install.

## Required structure

- [ ] Skill lives under `skills/engineering/<name>` or `skills/productivity/<name>`.
- [ ] Skill has `SKILL.md`.
- [ ] Skill has `agents/openai.yaml`.
- [ ] Skill name is kebab-case.
- [ ] Supporting files are local to the skill folder.

## Required metadata

- [ ] `SKILL.md` frontmatter has `name`.
- [ ] `SKILL.md` frontmatter has `description`.
- [ ] `agents/openai.yaml` has `interface.display_name`.
- [ ] `agents/openai.yaml` has `interface.short_description`.

## Invocation rules

For user-invoked skills:

- [ ] `SKILL.md` includes `disable-model-invocation: true`.
- [ ] `agents/openai.yaml` includes `policy.allow_implicit_invocation: false`.
- [ ] Description is human-facing and concise.

For model-invoked skills:

- [ ] `SKILL.md` does not disable model invocation.
- [ ] `agents/openai.yaml` does not disable implicit invocation.
- [ ] Description includes clear trigger phrasing.

## Documentation

- [ ] Root `README.md` lists the skill.
- [ ] Bucket `README.md` lists the skill.
- [ ] Human docs page exists at `docs/<bucket>/<skill>.md`.
- [ ] Human docs explain when and why to use the skill.
- [ ] Human docs do not duplicate the full `SKILL.md`.

## Router and manifests

- [ ] Router/discovery skill is updated if the skill is user-facing.
- [ ] Plugin manifests are updated if plugin distribution is enabled.
- [ ] Non-promoted skills are not listed in public manifests.

## Validation

- [ ] `npm run validate` passes.
- [ ] Links in README and docs are correct.
- [ ] Examples or scripts referenced by the skill exist.
