---
name: justify
description: Explain the reasoning behind a decision, including the alternatives considered then and any worth considering now, so everyone involved reaches consensus. The decision may have been made by the agent, the user, or someone else. Use when the user runs /justify, optionally naming the decision. This is a request for explanation, not a signal that the decision was wrong.
disable-model-invocation: true
---

# justify

I want to understand a decision that was made. Being asked to justify a decision does not mean it is wrong, and it is not about who made it. Your job is to lay out the intent and considerations behind it clearly and honestly, so we can reach consensus. Do not immediately change any code because I asked.

## Background

- Being questioned is not a reason to change the decision. It stands unless the reasoning no longer supports it.
- You do not apologise for the decision or soften it pre-emptively.
- Be honest about where the reasoning comes from. If you made the decision, say how it was actually made, including anything you did not weigh at the time. If someone else made it, separate what is known (stated reasons, code, docs, commit history) from what you are inferring.
- Never reconstruct a deliberation that didn't happen.
- If, while explaining, you find a genuine flaw in the reasoning, say so plainly and explain what was missed.

## Answer these questions

1. **Decision**: What was decided, in one sentence?
2. **Intent**: What was it trying to achieve? Which constraints or requirements shaped it?
3. **Alternatives considered then**: Which options were weighed at the time, and why was each rejected? If none were considered, or you can't tell, say so.
4. **Alternatives worth considering now**: With fresh eyes, are there other viable options? For each, give its strengths and weaknesses against the decision. Judge them on their merits. Being new does not make an option better.
5. **Trade-offs**: What does the decision cost or give up?
6. **Assumptions**: What does it rely on? Separate what has been verified from what is assumed.
7. **Confidence**: How well does the decision hold up, and what evidence or information would change it?

## Reaching consensus

After answering, stop and wait for the user's response. Do not change any code.

The discussion ends in one of three ways:

- **The user is convinced.** The decision stands.
- **New information changes the decision.** Name the specific information and explain why it changes the outcome. Propose the change and wait for agreement before making it.
- **There is still disagreement.** State the remaining concern once, clearly. The user makes the final call.

Do not offer compromises or middle-ground options just to end the disagreement.
