---
name: code-refactoring
description: This skill should be used when the user asks to "리팩토링", "리팩토링해줘", "refactor", "코드 정리", "코드 개선", "구조 개선해줘", "중복 코드 제거", "코드 품질 개선", "코드 다듬어줘", "레이어 위반 정리", or requests cleanup, structural improvement, or quality enhancement of existing code without changing behavior.
argument-hint: "[파일경로 또는 레이어명(core|data|domain|feature|app)]"
---

# Code Refactoring

기능 변경 없이 코드 품질·구조·가독성을 개선한다.

## 원칙

1. **동작 보존** — 리팩토링과 기능 변경 혼용 금지.
2. **근거 필수** — 모든 변경에 가독성 / 유지보수성 / 성능 중 하나의 근거 제시.
3. **blast radius 평가** — 범위가 크면 사전 확인 요청.
4. **작은 단위** — 한 번에 하나의 리팩토링 유형에 집중.
5. **추측 금지** — 동작이 불분명한 코드는 사용자에게 질문.

## 범위 결정

| `$ARGUMENTS` | 대상 |
|---|---|
| 없음 | 사용자에게 대상을 질문 |
| 파일 경로 | 해당 파일 |
| 레이어명 | 해당 레이어 전체 |

## 프로세스

### 1. 분석

대상 파일을 Read → 문제 식별(유형 + 근거 + 우선순위) → 영향 범위 파악.

식별 유형: 코드 레벨(중첩 조건문, 매직 넘버, 중복, 긴 메서드) / 구조(레이어 위반, 잘못된 위치) / 타입·인터페이스 / 일관성 / 아키텍처·TCA 위반 / 테스트.

프로젝트 체크리스트(`references/architecture-checklist.md`)를 기준으로 식별한다.

### 2. 우선순위

| 우선순위 | 대상 |
|---|---|
| High | 아키텍처 위반, 레이어 의존성 오류, 타입 안전성, TCA 패턴 위반 |
| Medium | 중복 코드, 복잡도 과다, 네이밍·에러 처리 불일치 |
| Low | 스타일, 마이너 가독성, 주석 |

### 3. 계획 제시

변경 파일 목록 → 각 변경의 이유 → 예상 영향 범위 → 동작 보존 확인.

**반드시 사용자 승인 후 실행한다.** 자동 실행 금지.

### 4. 실행

한 파일씩 순차 적용. 동작 변경 발생 시 즉시 중단·보고.

### 5. 검증

1. import 경로 → 레이어 의존 방향 위반 여부
2. `flutter analyze` → error, warning 확인
3. 동작 보존 → public API(시그니처, 반환 타입) 동일 여부
4. `flutter test` → 기존 테스트 통과 여부

**검증 실패 시 대응:**

| 실패 유형 | 대응 |
|---|---|
| import 위반 / analyze error / test 실패 | 리팩토링 원인이면 되돌린다. 기존 문제면 무시하고 보고 |
| analyze warning | 리팩토링 원인인 warning만 수정. 기존은 무시 |
| public API 변경 | 의도적이면 사용자 보고 후 승인. 아니면 되돌린다 |

검증 기준도 `references/architecture-checklist.md` 참조.

## 금지

- 요청 범위를 벗어난 파일 임의 변경 금지
- 요청하지 않은 리팩토링은 "추가 고려사항"으로만 제안
