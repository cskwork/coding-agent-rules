# 10계명 개선 제안 (2026-05 기준)

## TL;DR

| 항목 | 현재 | 제안 |
|---|---|---|
| 분량 | AGENTS 30줄 / CLAUDE 28줄 | 35줄 내외 유지 (200줄 한도 한참 아래) |
| 정체성 | 명령형 contract | 유지 |
| 약점 | "왜"가 README에만 있음, verification이 후순위 | 각 계명에 1줄 *Why* 인라인, verification first 톤업 |
| 누락 | Explore→Plan→Code 분리, Context budget, 기존 패턴 참조 | 5/6/9번을 재단조해서 흡수 (계명 수는 10 유지) |

핵심 결론: **계명 수는 늘리지 않는다.** 자기 규칙("20개 넘으면 위키")을 지킨다.
대신 ① 표현을 강화하고 ② 각 계명 끝에 *Why* 한 줄을 붙여 의도/배경을 인라인으로 남긴다.

---

## 현재 강점 (유지할 것)

1. **명령형 단문.** "Do X. Do not do Y." → 긴 컨텍스트에서도 살아남음 (Anthropic 권장과 일치).
2. **실패 모드 기반.** 모든 규칙이 실제 incident에서 옴 → "Compound engineering" 원칙 (모든 사고가 다음 규칙이 됨).
3. **도구 비종속.** `npm`/`pytest` 등 도구명 없음 → 모든 스택에 휴대 가능.
4. **두 파일 동일 내용.** AGENTS.md ↔ CLAUDE.md 동기화 → 도구별 분기 비용 0.
5. **200줄 룰 한참 아래 (30줄).** 컨텍스트 예산 효율적.

## 약점 (개선 대상)

### W1. "왜"가 본문에 없다
- README의 "Why" 섹션은 사람이 읽는 용도. **에이전트가 매 세션 로드하는 건 AGENTS.md/CLAUDE.md 본문**.
- 본문에는 명령만 있어서, 모호한 상황에서 에이전트가 *원칙을 추론*하기 어려움.
- 예: "Keep changes surgical"만 보면 *왜* 그래야 하는지 모름 → 큰 작업에서 룰을 무시.

### W2. Verification이 후순위 (8, 9번)
- Anthropic 공식: *"verification = the single highest-leverage thing"*.
- 현재는 10계명의 끝부분에 배치 → 우선순위 신호가 약함.
- "성공이라고 주장 전 증거" 마인드셋을 더 일찍 심어야 함.

### W3. Explore → Plan → Code 분리 누락
- Anthropic 2026 best-practices의 권장 4단계 워크플로: **Explore → Plan → Implement → Commit**.
- 현재 4번 "작은 단계로 계획"이 비슷하지만 *탐색(read 먼저)* 단계가 빠짐 → 에이전트가 코드 안 보고 계획부터 짬.

### W4. 기존 패턴 참조 룰 없음
- Cursor/Anthropic 공통 권고: *"Reference existing patterns. Point Claude to patterns in your codebase."*
- "외과적 변경"(5번)과 "단순함"(6번)으로 간접 유도되지만 **명시되어 있지 않음**.
- 결과: 에이전트가 기존 유틸 두고 동일한 함수를 재발명함.

### W5. 컨텍스트 예산 규칙 없음
- 긴 세션에서 성능 저하 = 현대 코딩 에이전트의 #1 실패 모드.
- "관계없는 작업 사이엔 `/clear`" 같은 메타 룰이 없음 → 사용자가 알아서 관리해야 함.

---

## 개선안 — 3가지 옵션 (사용자 룰 #3 준수)

### Option A. 인라인 *Why* + 표현 강화 (추천)
**변경 폭: 작음.** 계명 10개와 순서 유지. 각 계명 끝에 `(Why: …)` 한 줄 추가. 8/9번을 앞쪽으로 끌어올림.

- 장점: 정체성 보존, 분량 +15줄 이내, 의도/배경이 본문에 살아 있음.
- 단점: 줄당 길이 +50자 정도 늘어남.
- **이 옵션을 추천하는 이유**: 사용자 요청 "succinct + reasoning 명확"의 정확한 균형. 사람이 *왜* 라고 묻기 전에 답을 본문에 둠.

### Option B. 5단계 그룹 재편
계명을 [이해 / 계획 / 실행 / 검증 / 보호] 5개 헤더로 묶고 각 헤더 아래 2개씩.

- 장점: 워크플로 단계가 시각적으로 명확.
- 단점: 구조 변경 = 기존 fork/symlink 사용자에게 호환성 부담. 분량 늘어남.

### Option C. 계명 1개 교체 + 11번 추가는 금지
"Surface uncertainty"(2)와 "Offer options"(3)를 하나로 합치고, 빈 자리에 **"Explore before planning"** 신설.

- 장점: 누락 영역 W3 해결.
- 단점: 2번과 3번은 *다른 실패 모드*를 가리킴 — 합치면 어느 한쪽이 약해짐.

---

## Option A 상세 변경 사항 (제안)

### 본문 변경 (AGENTS.md / CLAUDE.md)

각 계명 패턴:
```
N. **Title.** Imperative directive. (Why: one-clause rationale.)
```

특히 강화할 항목:

| # | 변경 |
|---|---|
| 1 | `(Why: 잘못된 문제를 빠르게 푸는 것보다 옳은 문제를 늦게 푸는 게 항상 싸다.)` |
| 4 | "Plan in small steps" → "Explore, then plan in small steps." + Read 명시 |
| 5 | `(Why: 무관한 변경은 리뷰 비용을 폭증시키고 회귀를 숨긴다.)` |
| 6 | "Reuse before reinventing" 한 문장 삽입 (W4 흡수) |
| 8 | 위치는 유지하되 "성공이라 주장 전 증거" 강조 강화 |
| 9 | `(Why: 검증 없는 완료 보고는 사용자에게 부채를 떠넘긴다.)` |
| 10 | `(Why: 되돌릴 수 없는 행동은 신중함의 비용보다 항상 비싸다.)` |

### Repository Rules 추가 (선택)

```
- 관계없는 작업 사이엔 컨텍스트를 비워라. 누적된 실패 시도는 다음 시도를 망친다.
- 새 코드 짜기 전 기존 유틸/패턴을 먼저 찾아라. 검색 비용 < 재발명 비용.
```

---

## 분량 검증

| 파일 | 현재 | Option A 후 (추정) |
|---|---|---|
| AGENTS.md | 30줄 | ~45줄 |
| CLAUDE.md | 28줄 | ~43줄 |

200줄 한도까지 여유 75% 이상 → 안전.

---

## 적용 순서 (작은 단계로)

1. `proposed/AGENTS.md` 초안 작성 (Option A 적용본).
2. README의 "Why" 섹션을 *짧게 줄임* — 본문에 Why가 들어갔으므로 중복 제거.
3. `docs/changelog/changelog-2026-05-17.md`에 결정 근거 기록 (저장소 룰 준수).
4. Issue/Discussion으로 커뮤니티 의견 수집 후 main 반영.

## 적용하지 않는 것 (의도적 배제)

- **이모지 추가 금지** (저장소 룰).
- **도구명 (Claude/Codex/pytest) 본문 삽입 금지** (휴대성 깨짐).
- **11번째 계명 추가 금지** (자기 룰 "20개 넘으면 위키" 정신 위반).
- **`Hooks` 같은 도구별 메커니즘 본문 진입 금지** — 그건 별도 문서로.

---

## 참고 (2026-05)

- Anthropic, *Best practices for Claude Code* — verification, plan mode, context management, CLAUDE.md 분량 가이드.
- *Designing CLAUDE.md right (2026 architecture)* — 200줄 한도, advisory ~70% adherence, WHAT/WHY/HOW.
- Cursor, *Best practices for coding with agents* — reference existing patterns, "rules only when agent repeatedly makes the same mistake".
- arXiv 2510.22254v2, *Ten Simple Rules for AI-Assisted Coding in Science* — context strategy, TDD with AI, restart heuristic.
