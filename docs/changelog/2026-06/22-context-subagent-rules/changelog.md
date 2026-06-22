# 2026-06-22 — 계명에 context 절약 + subagent-driven-dev 통합

## 목적 (왜)

긴 세션에서의 컨텍스트 저하는 코딩 에이전트의 주요 실패 모드인데, 기존 규칙은 이를
Repository Rules 한 줄로만 다뤘다. obra/superpowers의 subagent-driven-development 중
**컨텍스트 절약 메커니즘**(독립 작업을 새 컨텍스트 서브에이전트에 위임 + 산출물을 파일로
핸드오프 + 진행을 내구성 파일에 기록)을 본문에 심어, 에이전트가 매 세션 로드하는 규칙
자체가 "컨텍스트를 아껴 써라"를 지시하게 했다.

## 결정 사항

1. **계명 4 재단조.** `Explore, then plan in small steps.` → `Explore, plan, then delegate.`
   본문에 "독립 단계는 새 컨텍스트 서브에이전트에 위임하고 결과는 파일로 받는다(컨텍스트
   덤프 금지)"를 추가. 기존 "read first / verifiable steps / own check"는 보존.
2. **Repository Rules 위임 줄 강화.** 파일 핸드오프(작업 지시·결과를 파일로, 메인 컨텍스트
   덤프 금지)를 명시.
3. **진행기록 위치 명시 + changelog 통일.** 기존 `docs/changelog/changelog-YYYY-MM-DD.md`
   (플랫 파일) 규칙을 `docs/changelog/<YYYY-MM>/<DD-topic>/`(날짜/토픽 디렉터리)로 바꾸고,
   결정 근거와 다단계 진행을 같은 곳에 기록하도록 통합. 이 디렉터리 구조는 supergoal 스킬이
   산출물을 담는 위치와 동일 — 규칙과 워크플로가 같은 경로에서 맞물린다.

## 적용 범위

- 정본: `AGENTS.md`, `CLAUDE.md` (글자 단위 동일 유지 — 설계 원칙)
- 문서: `README.md`, `README.ko.md` (계명 4 + Repository Rules), `docs/index.html` (RULE 04 한·영)
- 다운스트림(promptbox / ten-rules-skill / claude-code-config): `scripts/sync-downstreams.sh` +
  CI가 push 시 자동 전파 — 직접 수정하지 않음.
- 이 changelog 자체가 새 디렉터리 형식의 첫 적용 사례.

## 기각한 대안

- **리뷰 게이트 / 모델 선택 / 리뷰어 사전판단 금지 룰 추가:** 분량 대비 가치가 낮고
  운영 디테일이라 본문 정체성(도구 비종속·한 문장)을 해친다. 사용자 결정으로 제외.
- **진행기록을 별도 줄로 신설:** 같은 `docs/changelog/` 아래 두 형식(결정용 플랫 파일 +
  진행용 디렉터리)이 공존해 오히려 비일관. 한 줄로 통합하는 쪽이 일관적이고 분량도 절약.
- **본문에 "supergoal" 명시:** 이 규칙셋은 배포되는 드롭인 프롬프트라 도구/스킬명 금지
  (휴대성). 경로 컨벤션만 차용하고 이름은 넣지 않음.
- **기존 플랫 `changelog-*.md` 형식 유지:** 진행기록을 supergoal 위치에 맞추면서 결정기록만
  옛 형식으로 두면 비일관 → 규칙을 디렉터리 형식으로 통일. 기존 플랫 파일들은 그대로 둔다
  (surgical, 규칙 5).

## 제약 준수

계명 수 10개 유지 / 200줄 한도 한참 아래 / 도구명 본문 없음 / 이모지 없음 / 명령형 단문.

## 범위 밖 (미해결)

`README.md`·`README.ko.md`·`index.html`의 "junior engineer"/"주니어 엔지니어"가 정본의
"non-developers"와 불일치 — 직전 커밋 14d6d39의 후속 누락분이라 별개 이슈로 남김.
