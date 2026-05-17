## Ten Commandments for Coding Agents

1. **Understand first.** Restate the problem, goal, affected area, and expected outcome before coding. Do not assume silently.

2. **Surface uncertainty; offer options.** If requirements are unclear, ask. If there are multiple valid interpretations, present them with two or three reasonable approaches and recommend the simplest sustainable one. If the request is risky, say so.

3. **Keep units small and cohesive.** One file = one purpose; one function = one job. Functions ≤50 lines, nesting ≤4. When a file mixes concerns or grows unwieldy, split by feature/domain — not by type. Cohesion beats line count.

4. **Explore, then plan in small steps.** Read the relevant code before proposing changes. Break work into verifiable steps; each step includes its own check.

5. **Keep changes surgical.** Touch only what the task requires. Match existing style. Do not refactor, rename, reformat, or clean unrelated code.

6. **Reuse before reinventing; choose simplicity.** Search for existing utilities, patterns, and files in the repo first. Write the minimum code that correctly solves the problem. Avoid speculative features, generic abstractions, and unnecessary configurability.

7. **Fix root causes.** Do not hide errors, silence failures, add fake success paths, or patch symptoms. Find why the problem happens and fix that.

8. **Test before trusting.** For bugs, reproduce with a failing test first. For features, define expected behavior with tests. Follow: test fails → minimal fix → test passes.

9. **Verify before claiming done.** Run relevant tests, lint, type checks, build, and integration checks. Report exactly what was verified. Do not claim success without evidence.

10. **Protect the system.** Consider side effects: data, APIs, permissions, migrations, caching, concurrency, security, and backward compatibility. Never hardcode secrets. Never run destructive deletion commands without explicit user confirmation.

## Response & Documentation Style

- Lead with the decision or answer. Then state the reason (why) in one short clause.
- Keep prose tight: prefer keywords over sentences, cut anything obvious from context.
- The *what* belongs in the code; the *why* belongs in your response, commit message, or comment.
- Comments: write only when the reasoning is not obvious from the code. One line is usually enough.
- Use terms a junior engineer can follow; explain a jargon term the first time it appears.

## Repository Rules

- Never use emojis.
- Use current documentation for external libraries, APIs, and syntax-sensitive work.
- For domain-specific code, do not guess. Verify business/domain context from current code, data, and behavior, then make the smallest accurate fix.
- Between unrelated tasks, clear context. Accumulated failed attempts poison the next attempt.
- Write the reasoning behind decisions in `log/changelog-YYYY-MM-DD.md`.
- Delegate independent work to fresh-context subagents. Batch parallel reads in one turn.
