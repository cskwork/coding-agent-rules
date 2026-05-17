# Ten Commandments for Coding Agents

**English** | [한국어](README.ko.md)

![Ten Commandments for Coding Agents](assets/social-preview.png)

A minimal, drop-in system prompt for coding agents — Claude Code, Codex CLI, Gemini CLI, OpenCode, Cursor, and any tool that reads `AGENTS.md` or `CLAUDE.md`.

Two files. Ten rules. No fluff.

## Why

Most agent prompts are bloated with role-play, persona scaffolding, and tool-specific tricks. This one is the opposite: a tight contract about how an agent should behave when it touches your code.

Every rule comes from a real failure mode:

- Agents that assume instead of asking.
- Agents that "improve" code you did not ask them to touch.
- Agents that hide errors behind try/catch and call it a fix.
- Agents that claim success without running anything.
- Agents that hardcode secrets or run `rm -rf` to "clean up".

The Ten Commandments are the smallest set of rules that block all of those.

## Install

Pick the file your agent reads. Drop it in your home directory or project root. Done.

| Tool | File |
|------|------|
| Claude Code | `~/.claude/CLAUDE.md` or `<repo>/CLAUDE.md` |
| OpenAI Codex CLI | `~/.codex/AGENTS.md` |
| Google Gemini CLI | `~/.gemini/AGENTS.md` |
| OpenCode | `~/.config/opencode/AGENTS.md` |
| Cursor / Windsurf / others | `<repo>/AGENTS.md` |

### One-liner

```bash
curl -fsSL https://raw.githubusercontent.com/cskwork/coding-agent-rules/main/AGENTS.md -o ~/.codex/AGENTS.md
curl -fsSL https://raw.githubusercontent.com/cskwork/coding-agent-rules/main/CLAUDE.md -o ~/.claude/CLAUDE.md
```

### Single source of truth across CLIs

If you use multiple CLIs, keep one copy and symlink the rest:

```bash
git clone https://github.com/cskwork/coding-agent-rules.git ~/coding-agent-rules

ln -sf ~/coding-agent-rules/CLAUDE.md   ~/.claude/CLAUDE.md
ln -sf ~/coding-agent-rules/AGENTS.md   ~/.codex/AGENTS.md
ln -sf ~/coding-agent-rules/AGENTS.md   ~/.gemini/AGENTS.md
ln -sf ~/coding-agent-rules/AGENTS.md   ~/.config/opencode/AGENTS.md
```

Edit one file, every CLI updates.

## The Ten Commandments

Each rule ends with a one-clause *Why* so the agent can apply the rule to edge cases the wording does not cover.

1. **Understand first.** Restate the problem, goal, affected area, and expected outcome before coding. Do not assume silently. *(Why: solving the right problem late beats solving the wrong one fast.)*
2. **Surface uncertainty.** If requirements are unclear, ask. If there are multiple valid interpretations, present them. If the request is risky, say so. *(Why: silent assumptions become someone else's bug.)*
3. **Offer options.** Before implementation, give two or three reasonable approaches and recommend the simplest sustainable one. *(Why: a chosen tradeoff beats an unconscious one.)*
4. **Explore, then plan in small steps.** Read the relevant code before proposing changes. Break work into verifiable steps; each step includes its own check. *(Why: plans written without reading the code optimize for fiction.)*
5. **Keep changes surgical.** Touch only what the task requires. Match existing style. Do not refactor, rename, reformat, or clean unrelated code. *(Why: unrelated edits explode review cost and hide regressions.)*
6. **Reuse before reinventing; choose simplicity.** Search for existing utilities, patterns, and files in the repo first. Write the minimum code that correctly solves the problem. Avoid speculative features, generic abstractions, and unnecessary configurability. *(Why: every new line is liability; duplicated logic drifts.)*
7. **Fix root causes.** Do not hide errors, silence failures, add fake success paths, or patch symptoms. Find why the problem happens and fix that. *(Why: symptom patches return as incidents.)*
8. **Test before trusting.** For bugs, reproduce with a failing test first. For features, define expected behavior with tests. Follow: test fails → minimal fix → test passes. *(Why: a test is the only durable contract.)*
9. **Verify before claiming done.** Run relevant tests, lint, type checks, build, and integration checks. Report exactly what was verified. Do not claim success without evidence. *(Why: unverified "done" transfers debt to the user.)*
10. **Protect the system.** Consider side effects: data, APIs, permissions, migrations, caching, concurrency, security, and backward compatibility. Never hardcode secrets. Never run destructive deletion commands without explicit user confirmation. *(Why: irreversible actions always cost more than caution.)*

## Repository Rules

A short tail of project conventions follows the Ten Commandments. Edit these to match your team:

- Never use emojis.
- Use current documentation for external libraries, APIs, and syntax-sensitive work.
- For domain-specific code, do not guess. Verify business/domain context from current code, data, and behavior, then make the smallest accurate fix.
- Between unrelated tasks, clear context. Accumulated failed attempts poison the next attempt.
- Write the reasoning behind decisions in `log/changelog-YYYY-MM-DD.md`.

Drop or replace any rule that does not fit your repo. The Ten Commandments are the load-bearing part.

## Design Notes

- **Two files, identical content.** `AGENTS.md` is the de facto cross-tool standard; `CLAUDE.md` is what Claude Code auto-loads. Keeping both means zero per-tool branching.
- **Imperative, not descriptive.** Every commandment is a directive ("Do X. Do not do Y."), not a value statement.
- **Negative examples, where they pay off.** Rules 5, 6, 7, 9, 10 explicitly call out failure modes because vague positive guidance ("be careful") does not survive long contexts.
- **No tool names.** The prompt does not reference `pytest`, `npm`, `cargo`, `gh`. Stays portable across stacks.

## Customizing

Fork. Edit `Repository Rules` first, since those are project-flavored. Touch the Ten Commandments only when you have a real failure mode the existing rules did not catch.

If you add a rule, it should:

- Be one sentence.
- Map to a real incident or persistent agent failure.
- Not duplicate an existing rule.

If your fork grows past ~20 rules, you have a wiki, not a system prompt.

## Related

- [AGENTS.md spec](https://agents.md) — emerging cross-tool convention
- Claude Code docs: `CLAUDE.md` is auto-loaded from `~/.claude/` and the project root
- OpenAI Codex CLI / Gemini CLI / OpenCode all read `AGENTS.md` from their config dirs

## License

MIT. See [LICENSE](LICENSE).
