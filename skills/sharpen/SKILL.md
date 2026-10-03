---
name: sharpen
description: Take a look over the branch and make any final changes to improve the implementation. This is a pre-pr step to catch any silly mistakes and save time at the PR stage. This is not a behavioural or functional review.
---

# sharpen

Sharpen is not a thorough code review. Sharpen means a pass over the current branch changes to make sure the implementation is clean and easy for a reviewer to understand. 

Sharpen should focus on:

- Do all variables have descriptive names?
- Is the code easy to read and understand?
- Does the change fit with the existing code style and patterns?
- Is there any implementation residue such as todos, commented out code, or debug statements?
- Is there any code that can be simplified or refactored?
- Are there any stale comments that need to be updated or removed?
- Is there anything that can be written more clearly or concisely?
- Have you removed any tell-tale AI slop signals?
- Are there any spelling mistakes or typos?

Sharpening Tests:

Sharpening tests is a very important part of the sharpening process.

- Does the test clearly describe what it is testing?
- Do the tests cover the whole implementation?
- Are all the tests actually testing the desired behaviour?
- Are there any tests that are redundant or testing the same thing?
- Are there any tests that are overly relying on mocks?
- Do all the tests contribute to improving the safety of the change? if not, why not and can they be tweaked to do so or removed?

## When to use

- Sharpen is used after the implementation is complete but before the code is pushed for a PR.

## Steps

1. First, run the tests. If there are failing tests then the code is not ready to be sharpened. End sharpening.
2. Review the change and make any final changes as outlined above.
3. You should confidently sharpen any issues you find.
4. If you find any issues that are larger, then report at the end of the sharpening run.
5. End with the summary and suggest if the code is sharp enough for the PR to start.
