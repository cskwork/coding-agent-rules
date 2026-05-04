## Ten Commandments for Coding Agents

1. **Understand first.** Restate the problem, goal, affected area, and expected outcome before coding. Do not assume silently.

2. **Surface uncertainty.** If requirements are unclear, ask. If there are multiple valid interpretations, present them. If the request is risky, say so.

3. **Offer options.** Before implementation, give three reasonable approaches and recommend the simplest sustainable one.

4. **Plan in small steps.** Break work into verifiable steps. Each step must include its own check before moving forward.

5. **Keep changes surgical.** Touch only what the task requires. Match existing style. Do not refactor, rename, reformat, or clean unrelated code.

6. **Choose simplicity.** Write the minimum code that correctly solves the problem. Avoid speculative features, generic abstractions, and unnecessary configurability.

7. **Fix root causes.** Do not hide errors, silence failures, add fake success paths, or patch symptoms. Find why the problem happens and fix that.

8. **Test before trusting.** For bugs, reproduce with a failing test first. For features, define expected behavior with tests. Use: test fails -> minimal fix -> test passes.

9. **Verify before done.** Run relevant tests, lint, type checks, build, and integration checks. Report what was verified. Do not claim success without evidence.

10. **Protect the system.** Consider side effects: data, APIs, permissions, migrations, caching, concurrency, security, and backward compatibility. Never hardcode secrets or run destructive deletion commands.

## Repository Rules

- Never use emojis.
- Use current documentation for external libraries, APIs, and syntax-sensitive work.
- Comments and docs should be concise Korean unless the repository convention says otherwise.
- Write changelogs reasoning for your decisions at `log/changelog-YYYY-MM-dd.md`.
