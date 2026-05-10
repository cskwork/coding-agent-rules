# 2026-05-10 변경 기록

## 기본 문서/주석 언어를 영어로 변경

- 목적: 이 레포는 영어/한국어 사용자 모두를 위한 글로벌 drop-in이다. 기본값을 영어로 통일해 영어권 사용자에게 합리적인 디폴트를 제공한다.
- 결정: `AGENTS.md`, `CLAUDE.md`, `README.md`, `README.ko.md`의 Repository Rules 항목을 "concise Korean" → "concise English" 로 뒤집었다. 한국어 프로젝트는 기존 "unless the repository convention says otherwise" 절로 그대로 opt-in 가능하다.
- 영향: 10계명 본문은 변경 없음. Repository Rules 한 줄만 수정. 변경 이력 기록 자체가 한국어인 것은 새 규칙의 "repository convention says otherwise" 동작을 시연하는 사례다.

## 언어 룰 자체를 제거 (위 결정 후속 정정)

- 목적: 코딩 에이전트(LLM)는 사용자 입력 언어를 자동으로 미러링한다. "concise English/Korean" 같은 기본 언어 룰은 행동에 영향을 주지 않으면서 줄 수만 늘리는 사족(bloat)이다.
- 결정: 4개 파일(`AGENTS.md`, `CLAUDE.md`, `README.md`, `README.ko.md`)의 Repository Rules에서 언어 디폴트 항목을 완전히 제거했다. 위 "영어로 변경" 결정을 되돌리는 것이 아니라, 룰 자체를 폐기한다.
- 영향: 10계명 본문 변경 없음. 다른 Repository Rules(이모지 금지, 최신 문서 참조, 도메인 검증, changelog 기록)는 모두 유지. 이 룰들은 LLM이 자동으로 따라가지 않는 항목들이라 명시적 지시가 필요하다.
