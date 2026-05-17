# 2026-05-17 (REVISED) — 인라인 *Why* 철회, "Response & Documentation Style" 섹션 신설

## 정정 사유

직전 커밋(`440b2d9`)에서 10계명 본문에 `*(Why: ...)*` 절을 인라인으로 박았는데, 이는 사용자가 요청한 의도(에이전트 응답/문서/주석에서 reasoning을 명확히 + succint하게 표현하는 *룰* 추가)와 **카테고리가 다른** 변경이었음.

올바른 해석:
- 사용자 요청 = *에이전트의 커뮤니케이션 스타일*에 대한 룰.
- 잘못 적용 = *10계명의 표기 형식*에 대한 메타 변경.

## 이번 커밋 변경

- 10계명 본문에서 `*(Why: ...)*` 절 전부 제거 (AGENTS.md, CLAUDE.md, README.md, README.ko.md).
- 신규 섹션 `## Response & Documentation Style` 신설 — 5개 룰, ~10줄.
- `proposed/` 도 동기화.

신설 섹션 자리: 10계명 *바로 아래*, Repository Rules *위*. 이유: 10계명은 *코딩 행동*, 응답 스타일은 *커뮤니케이션 행동*, Repository Rules는 *프로젝트 컨벤션* — 추상도가 높은 순서.

신설 룰 내용:
1. 결정/답부터, 그다음 *이유*를 한 절.
2. 군더더기 절단; 핵심 키워드 우선.
3. *무엇(what)* = 코드. *왜(why)* = 응답/커밋/주석.
4. 주석은 *이유*가 자명하지 않을 때만, 보통 한 줄.
5. 주니어 엔지니어가 따라올 수 있는 단어; 전문 용어는 첫 등장 때 한 줄로 풀이.

## 유지된 직전 변경 (사용자가 명시적으로 거부하지 않은 항목)

- #4: "Plan" → "Explore, then plan" (코드 안 읽고 계획 짜는 실패 차단).
- #6: "Reuse before reinventing" (재발명 차단).
- #10: 파괴적 삭제 "절대 금지" → "명시적 사용자 확인 게이트".
- Repository Rules: context-clear 룰 1줄 추가.

## 분량 검증

| 파일 | 변경 전 | 직전 커밋 후 | 정정 후 |
|---|---|---|---|
| AGENTS.md | 30 | 31 | 41 (+10, 응답 스타일 섹션) |
| CLAUDE.md | 28 | 29 | 39 (+10) |

200줄 한도 대비 여유 80% — 안전.

---

# 2026-05-17 (원본) — 10계명 인라인 *Why* 도입 + 누락 영역 흡수

## 결정 요약

10계명의 정체성(명령형, 30줄 내외, 도구 비종속)을 유지하면서 다음 세 가지를 본문에 반영한다.

1. 각 계명 끝에 한 절짜리 `*(Why: …)*` 추가 — 의도/배경을 인라인으로 회수.
2. 누락 영역 3개를 *재단조*로 흡수: Explore→Plan (#4), Reuse before reinventing (#6), Context-clear (Repository Rules).
3. #10의 "파괴적 삭제 절대 금지"를 "명시적 사용자 확인 없이는 금지"로 완화.

계명 수는 10개를 유지한다.

## 변경 파일

- `AGENTS.md` 30 → 31줄
- `CLAUDE.md` 28 → 29줄
- `README.md` 10계명 블록 + Repository Rules sync
- `README.ko.md` 10계명 블록 + Repository Rules sync
- `analysis/IMPROVEMENT_PROPOSAL.ko.md` 신규 — 진단·옵션 3개·결정 근거 보존
- `proposed/AGENTS.md`, `proposed/CLAUDE.md` 신규 — 적용 전 비교용 스냅샷

## 결정 이유 (Reasoning)

### 왜 *Why* 인라인인가
- README의 "Why" 섹션은 *사람 독자*용 narrative다. 에이전트가 매 세션 로드하는 건 `AGENTS.md` / `CLAUDE.md` 본문.
- 본문에 의도가 없으면 모호한 상황에서 에이전트가 원칙을 *추론*하지 못한다. 룰의 *말* 만 따르고 *뜻*은 잃는다.
- 한 절짜리 clause는 분량을 +1줄 정도만 늘리면서 의도를 본문에 회수한다. 200줄 한도(2026 가이드) 대비 무비용.

### 왜 11번째 계명을 추가하지 않았나
- 자기 규칙: "20개를 넘으면 시스템 프롬프트가 아니라 위키다."
- 누락 영역(Explore, Reuse, Context-clear)은 *추가* 가 아니라 *재단조* 로 흡수 가능했다.
- 메타-신뢰성: 본인 룰을 본인이 어기면 fork하는 사람도 자유롭게 어긴다.

### 왜 #10 파괴적 삭제 룰을 완화했나
- 현실의 코딩 에이전트는 정당한 삭제가 자주 필요하다 (예: `rm -rf node_modules` 후 재설치, 캐시 정리, 임시 디렉토리 정리).
- "Never" 는 과적합이라 결국 무시된다 — 룰이 비현실적일수록 adherence가 낮아진다 (Anthropic 가이드의 "advisory ~70%" 원칙).
- "explicit user confirmation" 게이트는 *되돌릴 수 없는 행동*에만 비용을 부과한다. 같은 의도를 더 정확히 표현.

### 왜 #4를 "Explore, then plan"으로 바꿨나
- 현재 #4 "Plan in small steps" 는 *어떻게* 만 다룬다. *언제* 가 빠짐.
- Anthropic 2026 best-practices: Explore → Plan → Implement → Commit 4단계 — 첫 단계가 *Explore*.
- 실패 모드 누적: 에이전트가 코드 안 읽고 계획부터 짠다 → 픽션을 최적화한다.

### 왜 #6에 "Reuse before reinventing" 절을 추가했나
- 현재 #6 "Choose simplicity" 는 *덜 쓰라* 만 말한다. *기존 것을 찾으라* 는 없다.
- 결과적 실패: 동일 함수 재발명, 유틸리티 두고 중복 구현.
- Cursor/Anthropic 공통 권고와 정합.

### 왜 Repository Rules에 context-clear 룰을 추가했나
- 2026년 코딩 에이전트 #1 실패 모드 = 누적 컨텍스트로 인한 성능 저하.
- 사용자가 알아서 `/clear` 하길 기대하는 건 비현실적 — 에이전트 자신이 "관계없는 작업 사이엔 비워라" 라는 메타 룰을 가져야 한다.

## 적용하지 않은 것 (의도적 배제)

- 이모지 — 저장소 룰.
- 도구명(Claude/Codex/pytest 등) 본문 삽입 — 휴대성 보존.
- Hooks/Skills 설명 — 별도 문서로.
- README "Why" 섹션 제거 — 본문 *Why*는 에이전트용 단문, README "Why"는 사람용 narrative. 청중이 다르다.

## 참고

- Anthropic, *Best practices for Claude Code* (verification, plan mode, context, CLAUDE.md 분량 가이드).
- *Designing CLAUDE.md right (2026 architecture)* — 200줄 한도, advisory ~70% adherence, WHAT/WHY/HOW.
- Cursor, *Best practices for coding with agents* — reference existing patterns, "rules only when agent repeatedly makes the same mistake".
- arXiv 2510.22254v2, *Ten Simple Rules for AI-Assisted Coding in Science*.
