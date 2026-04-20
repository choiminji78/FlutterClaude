---
name: code-self-review
description: This skill should be used when the user asks to "셀프 리뷰", "내 코드 검토해줘", "PR 올리기 전에 리뷰", "코드 자가 검토", "code-self-review", or requests a self-review of their own code changes before submitting a pull request.
argument-hint: "[파일경로 또는 레이어명(core|data|domain|feature|app)]"
---

# Code Self-Review

PR 올리기 전, 10년차 시니어 관점으로 본인의 변경 코드를 검토한다.
"이 코드가 프로덕션에 나가도 안전한가?"를 기준으로 심각도별로 분류하여 출력한다.

---

## 핵심 원칙

1. **프로덕션 기준** — "동작하는가"가 아니라 "프로덕션에 나가도 안전한가"를 기준으로 검토.
2. **근거 필수** — 문제를 지적할 때 이유와 수정 방향을 함께 제시.
3. **심각도 우선순위** — Critical부터 검토. Critical이 발견되면 Major·Minor 검토를 계속하되 종합 의견에서 명확히 차단.
4. **범위 제한** — 변경된 파일만 검토. 변경되지 않은 코드 임의 평가 금지.
5. **추측 금지** — 의도가 불분명한 코드는 추측으로 판단하지 않고 의문 사항으로 분리.

---

## 검토 범위 결정

`$ARGUMENTS` 값에 따라 검토 범위를 결정한다.

| `$ARGUMENTS` | 검토 범위 |
|---|---|
| 없음 | staged 변경 전체. staged 없으면 직전 커밋(`HEAD~1..HEAD`) |
| 파일 경로 (예: `lib/feature/home/viewmodel/home_view_model.dart`) | 해당 파일만 |
| 레이어명 (예: `feature`) | 변경 파일 중 해당 레이어 파일만 |

---

## 실행 프로세스

### 1단계: 변경 범위 파악

```bash
# staged 변경 확인
git diff --staged --stat
git diff --staged

# staged 없는 경우 직전 커밋 기준
git diff HEAD~1..HEAD --stat
git diff HEAD~1..HEAD
```

`$ARGUMENTS`로 범위가 지정된 경우 해당 파일·레이어로 필터링한다.

**파일 수에 따른 처리:**

| 변경 파일 수 | 처리 |
|---|---|
| 0개 | 사용자에게 알리고 중단 |
| 1~15개 | 정상 진행 |
| 16개 이상 | 범위가 크다고 알리고, 특정 파일·레이어만 검토할지 확인 |

### 2단계: 파일 분류

변경 파일마다 아래 두 가지를 파악한다.

**레이어 감지 (경로 패턴):**

| 경로 패턴 | 레이어 |
|---|---|
| `lib/core/**` | `core` |
| `lib/data/**` | `data` |
| `lib/domain/**` | `domain` |
| `lib/feature/**` | `feature` |
| `lib/app/di/**` | `app/di` |
| `lib/app/router/**` | `app/router` |
| `lib/app/viewmodel/**` | `app/viewmodel` |
| `lib/app/**` | `app` |
| `test/**` | `test` |
| `*.g.dart` / `*.freezed.dart` | 자동생성 — 검토 제외 |

**변경 성격:**

| 성격 | 정의 | 주요 포커스 |
|---|---|---|
| 신규 추가 | 파일이 새로 생성됨 | 필수 구성 요소 누락, 연관 파일(테스트, DI) 함께 생성됐는가 |
| 수정 | 기존 파일 변경 | 변경 부분이 올바른가, 변경으로 인한 파급 효과 |
| 삭제 | 파일 제거 | 다른 파일의 dangling import·참조가 없는가 |

### 3단계: 파일별 검토

각 파일을 `Read` 도구로 읽은 후, 아래 순서로 검토한다.

```
각 파일에 대해:
  1. 레이어 확인 (2단계 결과)
  2. 변경 성격 확인 (2단계 결과)
  3. Critical 체크 — 해당 레이어의 Critical 항목 적용
  4. Major 체크  — 해당 레이어의 Major 항목 적용
  5. Minor 체크  — 해당 레이어의 Minor 항목 적용
  6. 의도 불분명한 코드 → 의문 사항으로 별도 기록
```

상세 체크 항목: `references/self-review-checklist.md` 참조

**신규 파일 추가 시 추가 확인:**

| 신규 파일 유형 | 함께 확인할 것 |
|---|---|
| `feature` ViewModel | Reducer 테스트 파일 생성 여부 |
| `domain` UseCase | UseCase 테스트 파일 생성 여부 |
| `data` Repository 구현체 | `app/di/[domain]_di.dart` Provider 등록 여부 |
| `domain` Repository 인터페이스 | 구현체(`*_impl.dart`)가 함께 생성됐는가 |
| `app/di/[domain]_di.dart` | `di.dart`에 export 추가 여부 |

**파일 삭제 시 추가 확인:**

삭제된 파일을 참조하는 import가 남아있는지 `Grep` 도구로 확인한다.

```
Grep 도구 사용: pattern="삭제된_파일명", path="lib/", 이후 path="test/"
```

### 4단계: 레이어 간 교차 검토

개별 파일 검토 후, 변경 파일 전체를 대상으로 아래를 교차 확인한다.

- **의존 방향 일관성** — 변경된 파일들 사이의 import 방향이 모두 허용 방향인가?
- **래퍼 모델 흐름** — `ApiResponse → AppResult → State` 변환 경계가 올바른가?
- **에러 전파 경로** — 에러가 `NetworkException → AppException → AppFailure → State` 경로를 따르는가?
- **테스트 커버리지** — 변경된 Reducer·UseCase의 테스트가 존재하는가?

### 5단계: 결과 출력

해당 심각도가 없으면 섹션을 생략한다.

```
## 셀프 리뷰 결과

**검토 파일:** N개 | **Critical:** N | **Major:** N | **Minor:** N

---

### 🔴 Critical — 즉시 수정 필요 (배포 차단 수준)

- [`파일경로:줄번호`](파일경로#L줄번호) **[문제 유형]** 문제 설명
  → 수정 방향

### 🟡 Major — 수정 강권 (리뷰어가 지적할 가능성 높음)

- [`파일경로:줄번호`](파일경로#L줄번호) **[문제 유형]** 문제 설명
  → 수정 방향

### 🟢 Minor — 수정 권장 (컨벤션·가독성 개선)

- [`파일경로:줄번호`](파일경로#L줄번호) **[문제 유형]** 문제 설명
  → 수정 방향

### ❓ 의문 사항 — 의도 확인 필요

- [`파일경로:줄번호`](파일경로#L줄번호) [구체적인 부분]의 의도가 불명확합니다.
  [의도A]라면 정상이지만, [의도B]라면 [문제]가 발생할 수 있습니다.

### ✅ 통과

- 주요 통과 항목 요약 (전부 나열하지 않고 핵심만)

---

**종합 의견**
[1~3줄 — "이 상태로 PR을 올려도 되는가"에 대한 시니어의 판단]
```

**종합 의견 결론 기준:**

| 상태 | 결론 |
|---|---|
| Critical 1개 이상 | "PR 올리기 전에 수정 필요" |
| Major만 있음 | "수정 후 PR 권장. Major 항목 리뷰어가 지적할 가능성 높음" |
| Minor만 있음 또는 없음 | "PR 올려도 됩니다" |

---

## 금지 사항

- 변경되지 않은 코드에 대해 임의로 문제 지적 금지
- 의도가 불분명한 코드를 추측으로 Critical 분류 금지
- Minor 항목 과다 나열로 리뷰 결과 희석 금지
- 수정 방향 없이 문제만 나열 금지
- 리뷰 결과만 출력. 요청하지 않은 수정 수행 금지

---
