# Ten Commandments for Coding Agents

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

A short tail of project conventions follows the Ten Commandments. Edit these to match your team:

- Never use emojis.
- Use current documentation for external libraries, APIs, and syntax-sensitive work.
- Comments and docs should be concise Korean unless the repository convention says otherwise.
- Write changelogs reasoning for your decisions at `log/changelog-YYYY-MM-dd.md`.

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

---

## 한국어

코딩 에이전트(Claude Code, Codex CLI, Gemini CLI, OpenCode, Cursor 등)를 위한 최소 시스템 프롬프트. 두 파일, 열 가지 규칙. 군더더기 없음.

### 왜 필요한가

대부분의 에이전트 프롬프트는 역할극과 페르소나로 부풀어 있다. 이 프롬프트는 정반대 — 코드를 만질 때 어떻게 행동해야 하는지에 대한 짧은 계약이다.

모든 규칙은 실제 실패 사례에서 왔다:

- 묻지 않고 추측하는 에이전트
- 부탁하지 않은 코드까지 "개선"하는 에이전트
- try/catch로 에러를 숨기고 수정이라 부르는 에이전트
- 아무것도 실행하지 않고 성공이라 주장하는 에이전트
- 시크릿을 하드코딩하거나 "정리한다"며 `rm -rf` 하는 에이전트

10계명은 이 모든 실패를 막는 최소 규칙 모음이다.

### 설치

```bash
# Claude Code
curl -fsSL https://raw.githubusercontent.com/cskwork/coding-agent-rules/main/CLAUDE.md -o ~/.claude/CLAUDE.md

# Codex CLI
curl -fsSL https://raw.githubusercontent.com/cskwork/coding-agent-rules/main/AGENTS.md -o ~/.codex/AGENTS.md

# Gemini CLI
curl -fsSL https://raw.githubusercontent.com/cskwork/coding-agent-rules/main/AGENTS.md -o ~/.gemini/AGENTS.md

# OpenCode
curl -fsSL https://raw.githubusercontent.com/cskwork/coding-agent-rules/main/AGENTS.md -o ~/.config/opencode/AGENTS.md

# Cursor / Windsurf 등 프로젝트 단위
curl -fsSL https://raw.githubusercontent.com/cskwork/coding-agent-rules/main/AGENTS.md -o ./AGENTS.md
```

여러 CLI를 함께 쓴다면 한 번 clone 후 symlink로 단일 소스화 — 영문 섹션 "Single source of truth across CLIs" 참고.

### 10계명 요약

1. **먼저 이해하라.** 코딩 전에 문제, 목표, 영향 범위, 기대 결과를 다시 말하라. 조용히 가정하지 마라.
2. **불확실성을 드러내라.** 요건이 모호하면 물어라. 해석이 여러 개면 모두 제시하라. 위험하면 위험하다고 말하라.
3. **선택지를 제시하라.** 구현 전에 합리적인 접근 세 가지를 제시하고 가장 단순하고 지속 가능한 것을 추천하라.
4. **작은 단계로 계획하라.** 검증 가능한 단계로 쪼개라. 각 단계에는 자체 점검이 포함되어야 한다.
5. **변경은 외과적으로.** 작업이 요구하는 부분만 만져라. 기존 스타일을 따르라. 무관한 코드를 리팩터링/이름 변경/포맷/정리하지 마라.
6. **단순함을 택하라.** 문제를 올바르게 푸는 최소 코드를 써라. 추측성 기능, 일반화 추상화, 불필요한 설정 가능성을 피하라.
7. **근본 원인을 고쳐라.** 에러를 숨기거나, 실패를 침묵시키거나, 가짜 성공 경로를 추가하거나, 증상을 패치하지 마라. 왜 발생했는지 찾고 그것을 고쳐라.
8. **신뢰 전에 테스트.** 버그는 먼저 실패하는 테스트로 재현하라. 기능은 기대 동작을 테스트로 정의하라. 테스트 실패 → 최소 수정 → 테스트 통과 흐름을 지켜라.
9. **완료 전에 검증.** 관련 테스트, 린트, 타입 체크, 빌드, 통합 검사를 실행하라. 무엇을 검증했는지 보고하라. 증거 없이 성공을 주장하지 마라.
10. **시스템을 보호하라.** 사이드 이펙트(데이터, API, 권한, 마이그레이션, 캐시, 동시성, 보안, 하위 호환)를 고려하라. 시크릿을 하드코딩하지 말고 파괴적 삭제 명령을 실행하지 마라.

### 기여

새 규칙은 (a) 한 문장, (b) 실제 실패 사례에 대응, (c) 기존 규칙과 중복하지 않을 것. 20개를 넘으면 시스템 프롬프트가 아니라 위키다.
