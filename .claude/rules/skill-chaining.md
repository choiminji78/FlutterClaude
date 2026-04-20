# Skill Chaining

> Claude는 구현 시작 전 **전체 체이닝 계획을 한 번 제시**하고 승인을 받는다.
> 이후 각 스킬 완료 시마다 다음 스킬을 제안하고 **스킬 전환마다 사용자 승인**을 받는다.
> 각 스킬은 개별 호출 — 한 스킬에 여러 도메인을 한 번에 처리하지 않는다.
> 스킬 간 전환 시 반드시 **검증 단계**를 거친다.

---

## 실행 방식

1. **계획 제시**: 요청을 분석해 필요한 스킬 체인을 추론하고 전체 순서를 한 번에 제시한다.
2. **승인 후 첫 스킬 실행**.
3. **스킬 완료 → 검증 → 다음 스킬 제안 → 사용자 승인 → 진행** — 스킬 전환마다 사용자 확인을 받는다.
4. **이탈 조건**: 검증 실패(analyze 오류) 또는 예상치 못한 상황 발생 시 실행을 멈추고 사용자에게 보고한다.

> 체인 내 다음 스킬은 Claude가 맥락을 보고 자율 추론한다. 단, 실행 전 항상 승인을 받는다.

---

## 일반적인 실행 흐름 (참고용)

> 아래는 강제 순서가 아닌 대표적인 흐름이다. Claude는 요청 맥락을 분석해 필요한 스킬을 추론하며, 불필요한 스킬은 생략한다.

```
init-project
  ↓
add-entity → add-repository
                  ↓
     [네트워크 필요 시]          [UseCase 필요 시]
     add-network (인프라 미설정)  add-usecase
     또는
     add-remote-datasource (인프라 설정됨)
                  ↓
             add-feature
                  ↓
        code-self-review → code-commit
```

로컬 저장소가 필요한 경우 (순서 무관, 독립적으로 추가 가능):

```
add-storage-preferences
add-storage-secure-storage
add-storage-drift
  ↓ (각 저장소별 DataSource 추가)
add-local-datasource
```

Remote + Local을 같은 Repository에서 조합할 때:

```
add-network (또는 add-remote-datasource)
  ↓
add-local-datasource (캐시용 저장소 DataSource 추가)
  ↓
add-remote-datasource — Repository 구현체에서 Remote + Local DataSource 모두 주입
```

---

## 스킬 간 전환 원칙

스킬 완료 후 다음 스킬로 넘어가기 전, 아래 검증이 모두 통과해야 한다.

> `*.freezed.dart`·`*.g.dart` 생성 파일을 추가·변경한 스킬 이후에만 build_runner를 실행한다. 생성 파일 변경이 없다면 build_runner를 생략하고 `flutter analyze`만 실행한다.

```bash
dart run build_runner build --delete-conflicting-outputs
flutter analyze
```

| 조건 | 처리 |
|---|---|
| `flutter analyze` 오류 없음 | 다음 스킬로 진행 |
| 오류 있음 | 오류를 수정한 뒤 다음 스킬로 진행. 오류를 남긴 채로 다음 스킬을 시작하지 않는다 |

> 생성 파일(`.freezed.dart`, `.g.dart`)이 없는 상태에서 analyze를 실행하면 오탐이 발생한다.
> build_runner를 먼저 실행한 뒤 analyze를 수행한다.

> `code-self-review` 결과로 Freezed·Riverpod 대상 파일을 수정했다면, `build_runner`를 다시 실행한 뒤 `code-commit`으로 진행한다.

---

## 스킬 선택 판단 기준

| 상황 | 사용 스킬 |
|---|---|
| 네트워크 인프라 미설정 | `add-network` (도메인 인수 없이 인프라만) |
| 네트워크 인프라 설정됨 + 새 도메인 추가 | `add-remote-datasource` |
| Repository 2개 이상 조합 / 비즈니스 로직 / 여러 Feature 재사용 | `add-usecase` 필수 |
| 단일 Repository + 비즈니스 로직 없음 | `add-usecase` 생략 (Effect → Repository 직접) |

---

## AppState/AppAction 변경 시나리오

feature가 글로벌 상태(토스트·네트워크 상태·인증 상태 등)를 필요로 할 때 AppState/AppAction을 먼저 수정한다.

### 판단 기준

| 필요한 동작 | 처리 방법 |
|---|---|
| 기존 AppAction(예: `showToast`, `themeModeChanged`)으로 충분 | AppState/AppAction 수정 없이 `add-feature`에서 `appViewModelProvider` 호출 |
| 새로운 글로벌 상태/액션 필요 (예: 네트워크 연결 상태, 인증 만료 플래그) | `add-feature` 전에 AppState·AppAction 먼저 수정 |

### AppState/AppAction 수정이 필요할 때 체이닝 순서

```
... → add-remote-datasource or add-usecase
          ↓
  [AppState/AppAction 수정] ← 글로벌 상태 추가 시만
          ↓
      add-feature
          ↓
  code-self-review → code-commit
```

### AppState/AppAction 수정 절차

1. `lib/app/state/app_state.dart` Read — 현재 필드 목록 파악
2. `lib/app/action/app_action.dart` Read — 현재 Action 목록 파악
3. 추가할 필드/Action 결정 후 사용자 확인
4. `lib/app/state/app_state.dart` / `lib/app/action/app_action.dart` 수정
5. `build_runner build` — Freezed 생성 파일 갱신 (AppAction sealed class 변경 시 필수)
6. `lib/app/reducer/app_reducer.dart` Read 후 새 Action 케이스 추가
7. `lib/app/effect/app_effect.dart` Read 후 새 Action의 Effect 처리 추가 (비동기 시)
8. `flutter analyze` 검증

> AppState/AppAction은 앱 전역에 영향을 미친다. 수정 전 반드시 기존 파일 전체를 Read한 뒤 누락 케이스 없이 `when()` 처리한다.

---

## 적용 예시 (참고용)

> 강제 순서가 아닌 대표적인 시나리오 예시다. Claude는 요청 맥락에 따라 불필요한 스킬을 생략하거나 순서를 조정한다.

**새 도메인 + 네트워크 연동 추가 시:**

- `/add-entity` — PostEntity
- `/add-repository` — PostRepository 인터페이스
- `/add-network` (인프라 미설정) 또는 `/add-remote-datasource` (인프라 설정됨)
- `/add-usecase` — 필요 시
- `/add-feature` — PostCreatePage 등
- `/code-self-review` — 레이어 위반·누락 케이스 점검
- `/code-commit` — 커밋

---

## 스킬-아키텍처 동기화 힌트

아키텍처(`.claude/docs/architecture-detail.md`, `.claude/rules/architecture.md`)가 변경될 때 함께 검토해야 하는 스킬 목록.

| 변경 대상 | 영향받는 스킬 |
|---|---|
| 래퍼 모델 (ApiResponse, AppResult, StorageResponse) | `add-network`, `add-remote-datasource`, `add-local-datasource` |
| 에러 전파 경로 (NetworkException → AppException) | `add-network`, `add-remote-datasource`, `add-local-datasource` |
| TCA 패턴 (State/Action/Reducer/Effect/ViewModel) | `add-feature` |
| Repository 인터페이스 규칙 | `add-repository`, `add-remote-datasource`, `add-local-datasource` |
| Entity 규칙 (Freezed, fromJson 금지 등) | `add-entity` |
| UseCase 기준 (경로 A/B) | `add-usecase`, `add-feature` |
| DI 규칙 (keepAlive, ref.read vs ref.watch) | `add-usecase`, `add-remote-datasource`, `add-local-datasource`, `add-network` |
| AppState/AppAction 구조 | `add-feature`, 이 파일의 "AppState/AppAction 변경 시나리오" 섹션 |
| 저장소 선택 기준 | `add-storage-preferences`, `add-storage-secure-storage`, `add-storage-drift`, `add-local-datasource` |

> 아키텍처 문서를 수정한 경우, 위 표를 기준으로 영향받는 스킬의 코드 템플릿·검증 항목·금지 사항을 일치시킨다.
