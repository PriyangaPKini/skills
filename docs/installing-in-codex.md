# Installing in Codex

Codex and other OpenAI Agent-Skills-compatible harnesses can use `SKILL.md` folders with `agents/openai.yaml` metadata.

## Preferred generic install

```bash
npx skills add PriyangaPKini/skills
```

Install one skill:

```bash
npx skills add PriyangaPKini/skills --skill=diagnosing-bugs
```

## Manual install

Copy skill folders into your Agent Skills directory:

```bash
mkdir -p ~/.agents/skills
cp -R skills/engineering/diagnosing-bugs ~/.agents/skills/diagnosing-bugs
```

## Metadata

Each promoted skill includes:

```txt
agents/openai.yaml
```

This file provides display metadata and, for user-invoked skills, implicit-invocation policy.

## Notes

- Prefer copying the full skill folder so `agents/openai.yaml` and supporting files are preserved.
- Native Codex plugin packaging is not implemented yet.
- Do not assume a native plugin is available until it has been tested and documented.
