# skills

Personal agent skills, installable with [skills.sh](https://skills.sh).

## Install

```bash
npx skills add ben1stone/skills                   # pick from all skills
npx skills add ben1stone/skills --skill my-skill  # one skill
npx skills add ben1stone/skills -g                # globally (user-level)
```

Pin a version:

```bash
npx skills add https://github.com/ben1stone/skills/tree/v0.1.0
```

## Add a skill

```bash
npm run new -- my-skill   # creates skills/my-skill/SKILL.md from the template
npm run list              # check the CLI finds it
```

Edit `name` and `description` in the frontmatter, then write the instructions.

## Release

```bash
npm version minor         # bumps package.json, commits, tags vX.Y.Z
git push --follow-tags
```

Installed skills update with `npx skills update`.
