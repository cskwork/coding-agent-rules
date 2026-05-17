# 2026-05-17 — 10계명 인라인 *Why* 도입 + 누락 영역 흡수

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
