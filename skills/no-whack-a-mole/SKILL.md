---
name: no-whack-a-mole
description: Use when asked to "fix this bug", or when fixing any bug, error or failing test. No whack-a-mole. Find the root cause and fix it there, rather than patching the symptom where it appears.
---

# no-whack-a-mole

This bug needs to be fixed properly. A whack-a-mole fix is a surface-level fix: it makes the symptom go away where it appeared, but leaves the underlying cause in place. These fixes often create new bugs, or fix the problem in one place while it remains in another. Find the root cause, and fix it there.

## Steps

1. **Reproduce.** Confirm the bug before reasoning about a fix, ideally with a failing test, otherwise with reliable steps. If you can't reproduce it, say so and tell me what you need.
2. **Trace from symptom to cause.** Keep asking "why did this happen?" until you reach the point where the wrong value, state or assumption first appears. That is usually not where the error shows up.
3. **Check the cause.** A root cause explains every symptom, and you can say why the bug exists, not just where it fails. If your explanation doesn't account for everything, keep going.
4. **Look for the same cause elsewhere.** Search for other places with the same pattern or assumption. Fix them with the same change or list them.
5. **Agree the fix.** If the cause is uncertain, or the fix reaches beyond the code that failed, present the cause, your evidence and the proposed fix, start a discussion. If the cause is clear and the fix is local, go ahead.
6. **Verify.** Run the reproduction again and the wider test suite. The bug should be gone and nothing else should break.

## Whack-a-mole warning signs

If the fix looks like one of these, stop and check you have found the cause:

- Adding a null check or try/catch to make an error go away
- Special-casing the exact input that failed
- Adding retries, sleeps or longer timeouts
- Changing a test's expectations to match the broken behaviour
- Fixing the one place it failed when the same pattern exists elsewhere

These are sometimes the right fix. When they are, explain why.

## When a surface fix is the right call

Sometimes a quick patch is right, for example an urgent hotfix. That's fine if it's deliberate: say clearly that it treats the symptom, and record the root cause so it can be fixed properly later.

## Summary

End with:

- **Cause**: what was actually wrong, and why
- **Fix**: what you changed, and why it fixes the cause rather than the symptom
- **Elsewhere**: other places with the same cause, fixed or still to do
- **Verified**: how you know it works
