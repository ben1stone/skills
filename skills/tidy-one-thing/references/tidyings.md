# Tidyings catalogue

Based on Part I of Kent Beck's *Tidy First?* and summarised here in our own words. Each entry says what to look for, what to do, what to watch out for, and what it often leads to. Put the "leads to" items in the report's **Next**. Don't do them in the same run.

Kinds marked **unattended: no** depend on an upcoming behaviour change or need too much judgement to do on a schedule. Mention them under **Noticed** instead.

---

## guard-clause

- **Look for:** a routine whose whole remaining body sits inside an `if`, or inside nested `if`s.
- **Do:** flip the condition and return early, so the preconditions come first and the main path isn't indented.
- **Watch out:** only when the `if` wraps *everything* that follows. If other code comes after the block, it doesn't qualify. Don't add so many guards that the top of the routine becomes a wall of them. Respect `finally`, cleanup and resource handling.
- **Leads to:** explaining-variable or extract-helper for the condition. delete-redundant-comment.

## dead-code

- **Look for:** code that can never run, such as an unused private function, an unreachable branch, a condition that is always true or false, or an unused import or variable.
- **Do:** delete it. Version control keeps it if it's ever needed again.
- **Watch out:** only delete what you can *prove* is dead. Check for reflection, dynamic dispatch, string-based lookups, framework conventions (routes, hooks, DI, serialisers), public or exported API in a library, and use from other packages or repos. If you can't prove it, don't delete it. Mention it under **Noticed**, and suggest adding logging to confirm it's unused. Delete a little at a time.
- **Leads to:** reading-order, cohesion-order.

## normalize-symmetry

- **Look for:** the same idea written in different ways in the same area, for example two styles of lazy initialisation, mixed error-handling idioms, or loops and comprehensions doing the same job.
- **Do:** pick the style used most often and convert *one* outlier to it. When similar routines differ slightly, separate the identical parts from the parts that differ, so the real difference stands out.
- **Watch out:** one kind of variation per run. Make sure the variants really are equivalent, including edge cases like falsy values versus null.
- **Leads to:** reading-order (parallel code can now be grouped together).

## new-interface-old-implementation — unattended: no

- **Look for:** a routine that is awkward to call.
- **Do:** write the interface you wish existed and implement it by calling the old one. Move callers across later.
- **Why not unattended:** it pays off for a specific upcoming change. Without one it's speculative.

## reading-order

- **Look for:** a file where the detail that explains everything else comes last, or where the order fights the way a reader takes it in.
- **Do:** reorder the elements into the order a first-time reader would want, for example the public entry points first, then the helpers they use.
- **Watch out:** some languages care about declaration order (hoisting, C-style declare-before-use, decorators, module-level side effects, Python definitions used at import time). Move only the parts that matter most. Don't mix in any other change: a move-only diff is easy to review.
- **Leads to:** normalize-symmetry (similar things are now next to each other).

## cohesion-order

- **Look for:** elements in one file that change together but are far apart, for example a function and the constant or helper it depends on.
- **Do:** move them next to each other. Unattended runs stay within one file. Moving files between directories or repos is **unattended: no**.
- **Watch out:** the same declaration-order risks as reading-order. Only move things, never change them.
- **Leads to:** extracting the group into its own unit (beyond tidying, so put it under **Noticed**).

## move-declaration-and-initialization-together

- **Look for:** a variable declared in one place and given its value much later.
- **Do:** declare and initialise it in one place, close to where it's first used.
- **Watch out:** data dependencies. Anything used to compute the value must still come first, and nothing in between may read or change it. If you'd have to track dependencies by hand across many lines, pick something smaller.
- **Leads to:** explaining-variable, extract-helper.

## explaining-variable

- **Look for:** a long or tangled expression, often an argument to a call or a compound condition, whose meaning you had to work out.
- **Do:** extract the subexpression into a local variable named for what it *means*, for example `width` or `isEligible`, not `tmp` or `result1`.
- **Watch out:** keep the evaluation order and short-circuiting the same. Don't hoist an expression out of a branch or a lazy `&&`/`||` if it has side effects or could throw.
- **Leads to:** extract-helper for the right-hand side. delete-redundant-comment.

## explaining-constant

- **Look for:** a magic number or string whose meaning you had to work out, or the same literal repeated with the same meaning.
- **Do:** introduce a named constant and use it in place of the literal. Put it near related constants.
- **Watch out:** the same literal can mean different things in different places. Only replace the uses that share a meaning. Never create meaningless names like `ONE = 1`. Reuse an existing constant if there is one.
- **Leads to:** cohesion-order (group constants that change together).

## explicit-parameters

- **Look for:** a routine that reads its inputs from a loose map, options bag or `params` object, or from environment variables or globals deep in the code.
- **Do:** split it. The outer routine unpacks the inputs and passes them as named parameters to an inner routine that holds the logic.
- **Watch out:** keep the outer signature unchanged so callers don't change. Keep defaulting and missing-key behaviour exactly the same. Don't push the change up to callers in the same run.
- **Leads to:** pushing the explicit parameters further up the call chain. Grouping parameters into an object (beyond tidying).

## chunk-statements

- **Look for:** a long block that does several separate things one after another with no visual break.
- **Do:** add a blank line between the logical steps. That's all.
- **Watch out:** nothing, except style rules that forbid blank lines in some places. The simplest tidying is a good fallback when nothing else qualifies cleanly.
- **Leads to:** explaining-comment before a chunk, extract-helper for a chunk, explaining-variable.

## extract-helper

- **Look for:** a block inside a routine with a clear purpose and few links to the code around it. Or a pair of calls that always have to happen together, in order.
- **Do:** extract it into a helper named for *what* it does, not *how*. Use the language tooling's automated extract if one is available.
- **Watch out:** watch for captured and mutated locals, early returns or `break`s inside the block, `this` and closure binding, and exceptions. Don't also replace other places that could use the helper. That's a separate run.
- **Leads to:** guard-clause, explaining-constant or explaining-variable inside the helper, using the helper at other call sites.

## one-pile — unattended: no

- **Look for:** code broken into many tiny pieces in a way that makes it harder to follow: long repeated argument lists, repeated conditionals, poorly named helpers, shared mutable state.
- **Do:** inline the pieces back together, then extract better pieces.
- **Why not unattended:** it makes things messier before they get tidier, and it needs follow-up steps in the same session. Put it under **Noticed**.

## explaining-comment

- **Look for:** a spot where you had to stop and work something out that the code can't easily say: a reason, a constraint, an outside requirement, or a hidden link to another file. Or a file with no header saying why someone would read it.
- **Do:** write a short comment with only what wasn't obvious, aimed at a specific future reader. A link to another place that must change at the same time is especially worth writing down.
- **Watch out:** never restate what the code says. Only write what you actually confirmed. Don't guess at intent. If the explanation could live in the code instead (a name, a constant, a helper), prefer that tidying.
- **Leads to:** turning the comment into code with explaining-variable, explaining-constant or extract-helper.

## delete-redundant-comment

- **Look for:** a comment that says exactly what the code next to it already says, such as `// return x` above `return x`. Or one made redundant by an earlier tidying.
- **Do:** delete it.
- **Watch out:** only delete comments that are *completely* redundant. Keep anything that gives a reason, context, a warning or a link. Don't touch license headers, doc comments that generate API docs, lint or type directives, or TODOs that point to a ticket.
- **Leads to:** reading-order, explicit-parameters.

---

## Not tidyings

These come up while tidying but are bigger, harder to undo or speculative. Never do them in a run. Report them under **Noticed**:

- extracting a class, module or service, or moving files between packages or repos
- removing coupling that needs coordinated changes in several places
- changing public APIs, signatures, names visible outside the module, or data formats
- moving every caller to a new interface
- anything that changes behaviour, even "obviously harmless" fixes
