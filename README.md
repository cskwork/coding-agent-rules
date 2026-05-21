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
- Agents that pile every concern into one 2,000-line file.
- Agents that hide errors behind try/catch and call it a fix.
- Agents that claim success without running anything.
- Agents that hardcode secrets or run `rm -rf` to "clean up".
- Agents that bury the decision in narrative and never say *why*.
- Agents that read the whole codebase into the main context, then ask you to re-explain it.

The Ten Commandments — plus the short *Response & Documentation Style* section — block all of those.

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

The Ten Commandments govern *what the agent does*. This section governs *how the agent communicates*: responses, commit messages, doc updates, code comments.

- Lead with the decision or answer. Then state the reason (why) in one short clause.
- Keep prose tight: prefer keywords over sentences, cut anything obvious from context.
- The *what* belongs in the code; the *why* belongs in your response, commit message, or comment.
- Comments: write only when the reasoning is not obvious from the code. One line is usually enough.
- Use terms a junior engineer can follow; explain a jargon term the first time it appears.

## Repository Rules

A short tail of project conventions follows the Ten Commandments. Edit these to match your team:

- Never use emojis.
- Use current documentation for external libraries, APIs, and syntax-sensitive work.
- For domain-specific code, do not guess. Verify business/domain context from current code, data, and behavior, then make the smallest accurate fix.
- Between unrelated tasks, clear context. Accumulated failed attempts poison the next attempt.
- Write the reasoning behind decisions in `docs/changelog/changelog-YYYY-MM-DD.md`.
- Delegate independent work to fresh-context subagents. Batch parallel reads in one turn.

Drop or replace any rule that does not fit your repo. The Ten Commandments are the load-bearing part.

## Design Notes

- **Two files, identical content.** `AGENTS.md` is the de facto cross-tool standard; `CLAUDE.md` is what Claude Code auto-loads. Keeping both means zero per-tool branching.
- **Imperative, not descriptive.** Every commandment is a directive ("Do X. Do not do Y."), not a value statement.
- **Negative examples, where they pay off.** Rules 3, 5, 6, 7, 9, 10 explicitly call out failure modes because vague positive guidance ("be careful") does not survive long contexts.
- **No tool names.** The prompt does not reference `pytest`, `npm`, `cargo`, `gh`. Stays portable across stacks.
- **Behavior vs communication.** The Ten Commandments govern *what the agent does*; *Response & Documentation Style* governs *how it talks*. Different audiences, different rules.

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
