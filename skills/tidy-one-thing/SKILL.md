---
name: tidy-one-thing
description: Make exactly one small, behaviour-preserving tidying (from Kent Beck's Tidy First?) somewhere in the codebase and ship it as its own change. Built to run unattended at regular intervals (/loop, cron, a scheduled routine) or on demand with /tidy-one-thing. Not for feature work, bug fixes or large refactors.
---

# tidy-one-thing

Leave the code a little easier to read than you found it. Each run picks **one** tidying, applies it, proves nothing changed behaviour, and ships it as a tiny change of its own. Many small tidyings over time add up. One big clean-up does not.

A tidying is a tiny refactoring: it changes structure, never behaviour. It should be obvious to a reviewer at a glance, and easy to undo if it turns out to be wrong.

## Rules

- **One tidying per run.** Tidyings lead to more tidyings. Do not chain them. Write the next one down in the report so a later run can do it.
- **Structure only.** No behaviour changes, no bug fixes, no new features, no dependency or config changes. If you spot a bug, report it. Do not fix it.
- **Small enough to review in under a minute.** "Small" means easy to understand, not a line count. One clause, one routine or one file is fine.
- **Doing nothing is a valid result.** If nothing clearly qualifies, or you aren't sure a change preserves behaviour, make no change and say so.
- **Never push to the default branch.** Every tidying gets its own branch.

## Steps

1. **Preflight.** Start from an up-to-date default branch with a clean working tree. Find the repo's test, lint, typecheck and format commands (CLAUDE.md, README, package scripts, Makefile, CI config). Run the tests. If the tree is dirty or the tests are already failing, stop and report it. A tidying can't be verified on a red baseline.

2. **Look where change happens.** Changes cluster in a small part of the code, so tidying there pays off soonest. List files by how often they changed recently, for example `git log --since=90.days --name-only --format= | sort | uniq -c | sort -rn`. Skip generated, vendored and lock files, migrations, and anything with an open PR or branch touching it if you can check. This lowers the risk of merge conflicts.

3. **Don't repeat yourself.** Check past runs with `git log --all --oneline --grep='^tidy'`. Skip files tidied in the last few runs, and prefer a different kind of tidying from the last one, so the work spreads out.

4. **Read, then pick one.** Read the candidate files as a newcomer would. Note where you got stuck, lost track or had to work something out. Match that spot against the catalogue in [references/tidyings.md](references/tidyings.md). Pick the candidate that:
   - matches a tidying's "Look for" exactly, not just roughly
   - obviously preserves behaviour
   - most helps the next person who reads or changes this code

5. **Apply it, and only it.** Make the single change and nothing else: no drive-by renames, no reformatting of nearby lines, no second tidying. Follow the file's existing style.

6. **Prove it.** Run the formatter, linter, typechecker and tests. Then re-read the diff as a suspicious reviewer. Could the evaluation order, a data dependency, a side effect, an early return, declaration order or a dynamic or reflective reference have changed? If anything fails, or you have any doubt, revert. Then try a smaller version or make no change.

7. **Ship it.** Create a branch named `tidy/<kind>-<short-slug>` and commit with:

   ```
   tidy(<kind>): <what changed> in <file>

   <one or two sentences: what was hard to read and how this helps>
   ```

   Push and open a small PR with the same title, if the environment allows it and the user hasn't asked for commits only. Mention in the PR body that it is a structure-only change.

## Report

End every run with:

- **Tidied**: the tidying, the file and location, and the branch or PR. Or "nothing", with the reason.
- **Verified**: which checks ran and passed.
- **Next**: one or two follow-up tidyings this one makes possible, for a future run.
- **Noticed**: anything bigger you saw but must not do here (bugs, coupling worth breaking up, a missing abstraction), for a human to decide on.
