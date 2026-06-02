# 2026-06-02 변경 기록

## 사람이 읽기 쉬운 리팩터링 기준 복원

- 목적: 룰 3의 작은 단위 기준이 줄 수와 분할 방식만 강조하면 에이전트가 기계적인 규칙 준수로 코드를 더 읽기 어렵게 쪼갤 수 있다.
- 결정: AGENTS.md, CLAUDE.md, README, 랜딩 페이지에 사람이 읽기 쉬운 흐름과 의미 있는 기능/도메인 경계를 보존하라는 문장을 추가했다.
- 영향: 리팩터링 판단은 숫자 기준을 통과하는 것보다 자연스러운 읽기 흐름과 실제 개념을 분명히 하는지를 우선한다.

## 다운스트림 자동 동기화 추가

- 목적: coding-agent-rules를 바꿀 때마다 promptbox, ten-rules-skill, claude-code-config에 수동으로 같은 변경을 커밋/푸시해야 했다.
- 결정: `scripts/sync-downstreams.sh`와 GitHub Actions workflow를 추가해 main push 후 다운스트림 공유본을 자동 동기화하게 했다.
- 영향: 앞으로 원본 규칙만 수정하고 push하면 변경이 있는 다운스트림 저장소에만 자동 커밋이 생성된다. workflow는 `DOWNSTREAM_SYNC_TOKEN` secret이 필요하다.
