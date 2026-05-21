# 2026-05-18 (REVISION 2) — 룰 3 파일 줄수 임계값 제거

## 정정 사유

REVISION 1에서 파일 줄수 임계값을 "200-400" 으로 박았는데, 사용자 재검 + 리서치 재대조 결과 *industry best practice 와 정합하지 않음*:

- Google Java/Python/TS style guide: 파일 줄수 cap **부재**
- PEP 8: 파일 줄수 cap **부재**
- Linux kernel: 파일 줄수 cap **부재**
- ESLint `max-lines`: 디폴트 300, opt-in disabled
- Pylint `max-module-lines`: 디폴트 1000, opt-in
- 본 리포 `rules/common/coding-style.md`: 200-400/800 — 출처 불분명, 보수적 strict

200-400은 ESLint 디폴트보다 낮고 어떤 공식 가이드와도 1:1 매칭 안 됨 → "best practice 근거" 가 약함.

## 이번 변경

룰 3에서 파일 줄수 절 제거. 함수 50줄/중첩 4는 유지 (ESLint+Linux kernel+Clean Code 컨센서스).

변경 전:
> 3. **Keep units small and cohesive.** One file = one purpose; one function = one job. Aim for ~200–400 lines per file, <50 lines per function, nesting ≤4. Exceeding a threshold is a refactor signal, not a violation — cohesion beats line count. Split by feature/domain, not by type.

변경 후:
> 3. **Keep units small and cohesive.** One file = one purpose; one function = one job. Functions ≤50 lines, nesting ≤4. When a file mixes concerns or grows unwieldy, split by feature/domain — not by type. Cohesion beats line count.

## 결정 이유 (Reasoning)

### 왜 파일 줄수 숫자 자체를 빼나

- 사용자가 본 실패 모드(거대 파일)는 cohesion 실패의 *증상*. 줄 수는 proxy. proxy를 룰로 박으면 cargo cult — 290줄로 만들고 통과시키는 회피 동작 가능.
- "One file = one purpose / Split by feature/domain / Cohesion beats line count" 만으로 의도가 더 정확히 전달됨.
- 다른 정당한 긴 파일(스키마, 생성 코드, 테스트, 라우터)을 룰이 부당하게 위협하지 않음.
- 룰 내부 모순 해소: "200-400 지향" + "cohesion이 우선" 은 약하게 충돌. 숫자 제거로 정합.

### 왜 함수 50줄 / 중첩 4는 유지하나

- 함수 길이: ESLint `max-lines-per-function=50` 디폴트 + Linux kernel "1-2 screenfuls" + Google Python "~40 lines" 모두 정합. "best practice" 주장 견고.
- 중첩 깊이: ESLint `max-depth=4` 디폴트 + Linux kernel "more than 3 — fix your program" 정합.
- AI 에이전트 adherence를 위한 측정 가능 임계값은 *최소한 어딘가에* 남아 있어야 함 — 함수 레벨이 더 신뢰성 있는 선택.

### 왜 README narrative ("2,000-line file" 예시) 는 유지하나

- 숫자가 *룰 본문*에 있는 것과 *narrative 예시*에 있는 것은 의미가 다름.
- 본문 숫자 = 강제 임계값 → cargo cult 위험
- narrative 예시 = 실패 모드의 구체 앵커 → 의도 전달
- 2,000줄 같은 *극단치* 만 narrative에 남겨 의도 전달, 일상 임계값은 빼는 게 깔끔.

## 미해결 / 후속

- `rules/common/coding-style.md` 의 "200-400 typical, 800 max" 는 글로벌(~/.claude/rules/...) 이라 이 commit으로 손대지 않음. 사용자 확인 후 별도 정리 예정.

---

# 2026-05-18 (REVISION 1) — 10계명 룰 2+3 병합, 신규 룰 "Keep units small" 승격

## 결정 요약

- 룰 2 (`Surface uncertainty`) + 룰 3 (`Offer options`) → 하나로 병합. 둘은 사실상 같은 행동(불확실성에 직면했을 때의 응답)을 다뤄서 겹쳤음.
- 비워진 슬롯에 신규 룰 3 `Keep units small` 승격. 파일/함수 크기를 first-class commandment로.
- 계명 수 10 유지.

## 변경 파일

- `AGENTS.md`, `CLAUDE.md`, `README.md`, `README.ko.md` 본문 10계명 블록 동기 패치.
- `README.md` / `README.ko.md` narrative 실패 모드 한 줄 추가 ("한 파일 2,000줄에 욱여넣는 에이전트").
- `README.md` / `README.ko.md` Design Notes의 "Negative examples" 룰 번호 갱신: `5, 6, 7, 9, 10` → `3, 5, 6, 7, 9, 10`.

## 결정 이유 (Reasoning)

### 왜 파일 크기 룰이 별도 슬롯이 필요한가

- 사용자 실측 실패 모드 = 에이전트가 단일 파일에 너무 많은 줄을 쌓음.
- `rules/common/coding-style.md`에 이미 "200-400 lines typical, 800 max" 가 존재 → 그런데도 무시됨. 10계명에 없는 룰은 우선순위가 낮게 인식되는 구조적 이슈.
- 기존 룰에 한 줄 덧붙이는 패치(룰 5/6 꼬리)로는 신호가 부족. 룰 비대화만 초래.
- *first-class commandment* 로 승격해야 행동 변화가 일어남.

### 왜 룰 2와 룰 3을 병합 대상으로 골랐나

- 기존 룰 2 (`Surface uncertainty`) 와 룰 3 (`Offer options`) 은 같은 트리거(요구사항 모호) 에 대한 두 가지 후속 행동. 자연스러운 흐름이라 한 룰로 묶이는 게 더 logical.
- 다른 후보(룰 4 process / 룰 5 scope / 룰 6 simplicity)는 각각 독립된 실패 모드를 다뤄서 병합 손실이 큼.
- 병합 결과 길이도 한 줄 늘어나는 정도라 분량 통제 OK.

### 왜 룰 3 본문에 숫자 임계값을 박았나 — 단, *signal* 로

- "Keep files small" 같은 추상문은 long context에서 안 살아남음 (2026 가이드의 advisory ~70% 원칙).
- 200-400/50/4 같은 수치 임계값은 에이전트가 *측정 가능한 룰* 로 인식 → adherence ↑.
- `rules/common/coding-style.md`(파일 200-400/800)와 ballpark 정합.

### 왜 "800 hard cap" 표현은 뺐나 (사용자 push back + 리서치 후 완화)

- 사용자 의문 → 업계 best-practice 리서치 수행:
  - Google Java/Python/TS style guides: 파일/함수 줄수 hard cap **없음**.
  - PEP 8 / Pylint: 파일 cap 없음 (Pylint 디폴트 `max-module-lines=1000`, opt-in).
  - Linux kernel: "한두 화면" (~24-48줄) + "중첩 3단계 넘으면 다시 짜라" — prose, hard rule 아님.
  - ESLint: `max-lines=300 / max-lines-per-function=50 / max-depth=4`. 셋 다 **opt-in default disabled**.
  - Robert C. Martin (Clean Code) 의 dogmatic 캡은 2024-25년에 광범위하게 비판됨 (qntm.org/clean, Ousterhout *A Philosophy of Software Design*).
- 결론: 수치 자체는 ballpark OK인데 "800 hard cap" 같은 *강제* 표현은 컨센서스 초과.
- 완화 패치: "hard cap" 제거 + "Exceeding a threshold is a refactor signal, not a violation — cohesion beats line count" 추가.
- 결과: ESLint `warn` 시맨틱과 정합 + AI 에이전트용 측정 가능 임계값 유지.

### 왜 응집(cohesion) 을 first principle 로 명시했나

- *A Philosophy of Software Design* (Ousterhout) 2024-26년 컨센서스: 줄 수보다 응집이 본질.
- 줄 수만으로 쪼개면 fragmentation → comprehension 저하 (Clean Code dogma 비판의 핵심).
- 룰에 "cohesion beats line count" 한 절 추가로 숫자가 *과적용* 되는 실패 모드 차단.

### 왜 "Split by feature/domain, not by type" 절을 포함했나

- 파일 쪼개기에서 가장 흔한 실패 = 타입 단위 분리 (controllers/, services/, models/...) 로 cohesion 망가뜨림.
- 한 줄 비용으로 잘못된 분할 방식 차단.

### 왜 11번째 계명을 추가하지 않았나

- 자기 규칙: "20개를 넘으면 시스템 프롬프트가 아니라 위키다."
- `2026-05-17` 의 동일 원칙 — *추가* 가 아니라 *재단조* 로 흡수해야 메타-신뢰성 유지.
- 사용자가 명시적으로 "keeping as 10 rules" 요청.

## 적용하지 않은 것 (의도적 배제)

- 룰 5 (`Keep changes surgical`) 꼬리에 file-size 한 줄 — 옵션 A. 약함, 거부.
- 룰 6 (`Choose simplicity`) 꼬리에 file-size 한 줄 — 옵션 B. 약함, 거부.
- 룰 4 (`Plan in small steps`) 재작성 — 옵션 D. process와 structure가 섞임, 거부.

## 분량 검증

| 파일 | 변경 전 | 변경 후 | 룰 본문 총 줄 |
|---|---|---|---|
| AGENTS.md | 41 | 41 | 동일 (룰 2 +1줄, 신규 룰 3 +1줄, 구 룰 3 −2줄 상쇄) |
| CLAUDE.md | 104 | 104 | 동일 |

200줄 한도 대비 여유 60% — 안전.

## 참고

- `rules/common/coding-style.md` — 파일 크기 임계값 출처 (200-400/800).
- 2026-05-17 changelog — 본 변경의 메타-원칙(`재단조 흡수`, `11번째 계명 회피`) 일관성 참조.
