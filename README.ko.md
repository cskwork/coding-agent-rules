# 코딩 에이전트를 위한 10계명

[English](README.md) | **한국어**

![코딩 에이전트를 위한 10계명](assets/social-preview.png)

코딩 에이전트(Claude Code, Codex CLI, Gemini CLI, OpenCode, Cursor 등 `AGENTS.md` 또는 `CLAUDE.md`를 읽는 모든 도구)를 위한 최소 드롭인 시스템 프롬프트.

두 파일. 열 가지 규칙. 군더더기 없음.

## 왜 필요한가

대부분의 에이전트 프롬프트는 역할극, 페르소나 스캐폴딩, 도구별 트릭으로 부풀어 있다. 이 프롬프트는 정반대 — 에이전트가 코드를 만질 때 어떻게 행동해야 하는지에 대한 짧은 계약이다.

모든 규칙은 실제 실패 사례에서 왔다:

- 묻지 않고 추측하는 에이전트
- 부탁하지 않은 코드까지 "개선"하는 에이전트
- try/catch로 에러를 숨기고 수정이라 부르는 에이전트
- 아무것도 실행하지 않고 성공이라 주장하는 에이전트
- 시크릿을 하드코딩하거나 "정리한다"며 `rm -rf` 하는 에이전트

10계명은 이 모든 실패를 막는 최소 규칙 모음이다.

## 설치

도구가 읽는 파일을 골라서 홈 디렉터리나 프로젝트 루트에 떨어뜨리면 끝.

| 도구 | 파일 |
|------|------|
| Claude Code | `~/.claude/CLAUDE.md` 또는 `<repo>/CLAUDE.md` |
| OpenAI Codex CLI | `~/.codex/AGENTS.md` |
| Google Gemini CLI | `~/.gemini/AGENTS.md` |
| OpenCode | `~/.config/opencode/AGENTS.md` |
| Cursor / Windsurf 등 | `<repo>/AGENTS.md` |

### 한 줄 설치

```bash
curl -fsSL https://raw.githubusercontent.com/cskwork/coding-agent-rules/main/AGENTS.md -o ~/.codex/AGENTS.md
curl -fsSL https://raw.githubusercontent.com/cskwork/coding-agent-rules/main/CLAUDE.md -o ~/.claude/CLAUDE.md
```

### 여러 CLI를 단일 소스로

CLI를 여럿 쓴다면 한 번 clone 후 symlink로 단일 소스 관리:

```bash
git clone https://github.com/cskwork/coding-agent-rules.git ~/coding-agent-rules

ln -sf ~/coding-agent-rules/CLAUDE.md   ~/.claude/CLAUDE.md
ln -sf ~/coding-agent-rules/AGENTS.md   ~/.codex/AGENTS.md
ln -sf ~/coding-agent-rules/AGENTS.md   ~/.gemini/AGENTS.md
ln -sf ~/coding-agent-rules/AGENTS.md   ~/.config/opencode/AGENTS.md
```

한 파일 수정 → 모든 CLI에 즉시 반영.

## 10계명

1. **먼저 이해하라.** 코딩 전에 문제, 목표, 영향 범위, 기대 결과를 다시 말하라. 조용히 가정하지 마라.
2. **불확실성을 드러내라.** 요건이 모호하면 물어라. 해석이 여러 개면 모두 제시하라. 위험하면 위험하다고 말하라.
3. **선택지를 제시하라.** 구현 전에 합리적인 접근 세 가지를 제시하고 가장 단순하고 지속 가능한 것을 추천하라.
4. **작은 단계로 계획하라.** 검증 가능한 단계로 쪼개라. 각 단계에는 자체 점검이 포함되어야 한다.
5. **변경은 외과적으로.** 작업이 요구하는 부분만 만져라. 기존 스타일을 따르라. 무관한 코드를 리팩터링/이름 변경/포맷/정리하지 마라.
6. **단순함을 택하라.** 문제를 올바르게 푸는 최소 코드를 써라. 추측성 기능, 일반화 추상화, 불필요한 설정 가능성을 피하라.
7. **근본 원인을 고쳐라.** 에러를 숨기거나, 실패를 침묵시키거나, 가짜 성공 경로를 추가하거나, 증상을 패치하지 마라. 왜 발생했는지 찾고 그것을 고쳐라.
8. **신뢰 전에 테스트.** 버그는 먼저 실패하는 테스트로 재현하라. 기능은 기대 동작을 테스트로 정의하라. `테스트 실패 → 최소 수정 → 테스트 통과` 흐름을 지켜라.
9. **완료 전에 검증.** 관련 테스트, 린트, 타입 체크, 빌드, 통합 검사를 실행하라. 무엇을 검증했는지 보고하라. 증거 없이 성공을 주장하지 마라.
10. **시스템을 보호하라.** 사이드 이펙트(데이터, API, 권한, 마이그레이션, 캐시, 동시성, 보안, 하위 호환)를 고려하라. 시크릿을 하드코딩하지 말고 파괴적 삭제 명령을 실행하지 마라.

## Repository Rules

10계명 뒤에 짧은 프로젝트 컨벤션 꼬리표가 붙는다. 팀에 맞게 수정:

- 이모지 사용 금지.
- 외부 라이브러리, API, 문법에 민감한 작업은 최신 문서 참조.
- 도메인 특화 코드는 추측하지 말고, 현재 코드/데이터/동작에서 관련 업무 맥락을 확인한 뒤 가장 작은 정확한 수정만 적용.
- 주석/문서는 저장소 컨벤션이 다른 경우가 아니면 간결한 영어.
- 결정 근거 변경 이력은 `log/changelog-YYYY-MM-dd.md`에 기록.

저장소에 안 맞는 규칙은 빼거나 바꿔라. 핵심은 10계명이다.

## 설계 노트

- **두 파일, 동일 내용.** `AGENTS.md`는 사실상 표준이고 `CLAUDE.md`는 Claude Code가 자동 로드. 둘 다 두면 도구별 분기가 필요 없다.
- **명령형, 서술형 X.** 모든 계명은 지시문(`X 하라. Y 하지 마라.`)이지 가치 진술이 아니다.
- **부정 예시는 비용이 클 때만.** 5, 6, 7, 9, 10번은 실패 모드를 명시 — 모호한 긍정문("주의하라")은 긴 컨텍스트에서 살아남지 못한다.
- **도구 이름 없음.** `pytest`, `npm`, `cargo`, `gh` 같은 이름이 안 들어간다. 어느 스택에도 휴대 가능.

## 커스터마이징

Fork. `Repository Rules`부터 손대라. 프로젝트 색이 묻은 부분이다.

10계명은 기존 규칙이 잡지 못한 실제 실패 모드가 있을 때만 건드려라.

새 규칙은:

- 한 문장
- 실제 사건이나 지속적 에이전트 실패에 대응
- 기존 규칙과 중복하지 않음

20개를 넘으면 시스템 프롬프트가 아니라 위키다.

## 관련 자료

- [AGENTS.md spec](https://agents.md) — 새로 떠오르는 도구 간 컨벤션
- Claude Code 문서: `CLAUDE.md`는 `~/.claude/`와 프로젝트 루트에서 자동 로드
- OpenAI Codex CLI / Gemini CLI / OpenCode 모두 각자 설정 디렉터리에서 `AGENTS.md`를 읽는다

## 라이선스

MIT. [LICENSE](LICENSE) 참조.
