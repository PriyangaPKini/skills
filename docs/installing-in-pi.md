# Installing in Pi

Pi can use local skills from the user's skill directory.

## Preferred generic install

Use the Agent Skills installer when available:

```bash
npx skills add PriyangaPKini/skills
```

Install one skill:

```bash
npx skills add PriyangaPKini/skills --skill=tdd
```

## Manual install

Copy a skill folder into Pi's skills directory:

```bash
mkdir -p ~/.pi/agent/skills/tdd
curl -fsSL https://raw.githubusercontent.com/PriyangaPKini/skills/main/skills/engineering/tdd/SKILL.md \
  -o ~/.pi/agent/skills/tdd/SKILL.md
```

For skills with supporting files, copy the entire skill folder rather than only `SKILL.md`.

## Notes

- Restart or reload Pi if your session does not discover the new skill immediately.
- Prefer copying the full folder for skills that reference local files such as `tests.md` or `mocking.md`.
- Native Pi plugin packaging is not implemented yet.
