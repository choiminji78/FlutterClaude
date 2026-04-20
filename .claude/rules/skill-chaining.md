# Skill Chaining

구현 전 **전체 체이닝 계획 제시 → 승인 → 실행**. 스킬 전환마다 사용자 승인 필수. 스킬당 하나의 도메인.

## 실행 방식

1. 요청 분석 후 전체 스킬 체인 제시.
2. 승인 후 첫 스킬 실행.
3. 스킬 완료 → 검증 → 다음 스킬 제안 → 승인 → 진행.
4. 이탈 조건: analyze 오류 또는 예상치 못한 상황 → 실행 중단 후 보고.

## 일반적인 흐름 (참고용, 강제 아님)

- 기본: `init-project → add-entity → add-repository → [add-network|add-remote-datasource] → [add-usecase] → add-feature → code-self-review → code-commit`
- 로컬 저장소: `add-storage-* → add-local-datasource` (독립적으로 추가 가능)
- Remote+Local 조합: `add-network → add-local-datasource → add-remote-datasource` (Repository에서 둘 다 주입)

## 스킬 간 검증

> `*.freezed.dart`·`*.g.dart` 변경이 있는 스킬 이후에만 build_runner 실행. 없으면 analyze만.

```bash
dart run build_runner build --delete-conflicting-outputs
flutter analyze
```

| 조건 | 처리 |
|---|---|
| analyze 오류 없음 | 다음 스킬 진행 |
| 오류 있음 | 수정 후 진행. 오류 남긴 채 다음 스킬 시작 금지 |

## 스킬 선택 기준

| 상황 | 스킬 |
|---|---|
| 네트워크 인프라 미설정 | `add-network` |
| 인프라 설정됨 + 새 도메인 | `add-remote-datasource` |
| Repository 2개 이상 조합 / 비즈니스 로직 / 여러 Feature 재사용 | `add-usecase` 필수 |
| 단일 Repository + 비즈니스 로직 없음 | `add-usecase` 생략 |

## AppState/AppAction 변경

| 필요 여부 | 처리 |
|---|---|
| 기존 Action으로 충분 | `add-feature`에서 `appViewModelProvider` 직접 호출 |
| 새 글로벌 상태/액션 필요 | `add-feature` 전에 먼저 수정 |

**수정 절차** (전역 영향 — 수정 전 기존 파일 전체 Read 필수):
1. `app_state.dart`, `app_action.dart` Read → 추가할 필드/Action 결정 후 사용자 확인
2. 파일 수정 → `build_runner build`
3. `app_reducer.dart` Read → 새 Action 케이스 추가
4. `app_effect.dart` Read → 비동기 Action의 Effect 처리 추가
5. `flutter analyze` 검증. 모든 케이스 `when()` 누락 없이 처리.

## 스킬-아키텍처 동기화

아키텍처 변경 시 함께 검토할 스킬:

| 변경 대상 | 영향받는 스킬 |
|---|---|
| 래퍼 모델 (ApiResponse, AppResult, StorageResponse) | `add-network`, `add-remote-datasource`, `add-local-datasource` |
| 에러 전파 경로 | `add-network`, `add-remote-datasource`, `add-local-datasource` |
| TCA 패턴 | `add-feature` |
| Repository 인터페이스 규칙 | `add-repository`, `add-remote-datasource`, `add-local-datasource` |
| Entity 규칙 | `add-entity` |
| UseCase 기준 | `add-usecase`, `add-feature` |
| DI 규칙 | `add-usecase`, `add-remote-datasource`, `add-local-datasource`, `add-network` |
| AppState/AppAction 구조 | `add-feature`, skill-chaining |
| 저장소 선택 기준 | `add-storage-*`, `add-local-datasource` |
