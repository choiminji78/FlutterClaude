# Naming Detail

## 파일 네이밍 전체 표

모든 파일은 `snake_case`, 파일명은 `[대상]_[역할].dart` 형태.

| 역할 | 패턴 | 예시 |
|---|---|---|
| DTO (요청) | `[domain]_request_dto.dart` | `create_[domain]_request_dto.dart` |
| DTO (응답) | `[domain]_response_dto.dart` | `[domain]_response_dto.dart` |
| Entity | `[domain]_entity.dart` | `[domain]_entity.dart` |
| Enum | `[name].dart` | `user_status.dart` |
| Mapper | `[domain]_mapper.dart` | `[domain]_mapper.dart` |
| Drift 통합 Mapper | `[domain]_drift_mapper.dart` | `[domain]_drift_mapper.dart` |
| ExceptionMapper | `exception_mapper.dart` | `exception_mapper.dart` |
| StorageExceptionMapper | `storage_exception_mapper.dart` | `storage_exception_mapper.dart` |
| Repository 인터페이스 | `[domain]_repository.dart` | `[domain]_repository.dart` |
| Repository 구현체 | `[domain]_repository_impl.dart` | `[domain]_repository_impl.dart` |
| UseCase | `[verb]_[domain]_usecase.dart` | `get_[domain]_usecase.dart` |
| Remote DataSource | `[domain]_remote_data_source.dart` | `[domain]_remote_data_source.dart` |
| Local DataSource | `[domain]_local_data_source.dart` | `[domain]_local_data_source.dart` |
| State | `[feature]_state.dart` | `[feature]_state.dart` |
| Action | `[feature]_action.dart` | `[feature]_action.dart` |
| Reducer | `[feature]_reducer.dart` | `[feature]_reducer.dart` |
| Effect | `[feature]_effect.dart` | `[feature]_effect.dart` |
| ViewModel | `[feature]_view_model.dart` | `[feature]_view_model.dart` |
| Page/Screen | `[feature]_page.dart` | `[feature]_page.dart` |
| DI | `[domain]_di.dart` | `[domain]_di.dart` |
| Drift Table | `[domain]_table.dart` | `[domain]_table.dart` |
| 공유 위젯 | `[name]_widget.dart` | `loading_widget.dart` |
| 테스트 파일 | `[원본파일명]_test.dart` | `[feature]_reducer_test.dart` |

---

## 클래스 네이밍 전체 표

모든 클래스는 `PascalCase`.

| 역할 | 패턴 | 예시 |
|---|---|---|
| DTO (요청) | `[Domain]RequestDto` | `Create[Domain]RequestDto` |
| DTO (응답) | `[Domain]ResponseDto` | `[Domain]ResponseDto` |
| Entity | `[Domain]Entity` | `[Domain]Entity` |
| Enum | `[Name]` (PascalCase) | `UserStatus` |
| Mapper | `[Domain]Mapper` | `[Domain]Mapper` |
| Drift 통합 Mapper | `[Domain]DriftMapper` | `[Domain]DriftMapper` |
| Repository 인터페이스 | `[Domain]Repository` | `[Domain]Repository` |
| Repository 구현체 | `[Domain]RepositoryImpl` | `[Domain]RepositoryImpl` |
| UseCase | `[Verb][Domain]UseCase` | `Get[Domain]UseCase` |
| Remote DataSource | `[Domain]RemoteDataSource` | `[Domain]RemoteDataSource` |
| Local DataSource | `[Domain]LocalDataSource` | `[Domain]LocalDataSource` |
| State | `[Feature]State` | `[Feature]State` |
| Action | `[Feature]Action` | `[Feature]Action` |
| Reducer | `[feature]Reducer` (함수) | `[feature]Reducer` |
| Effect | `[Feature]Effect` | `[Feature]Effect` |
| ViewModel | `[Feature]ViewModel` | `[Feature]ViewModel` |

---

## Provider 네이밍

Riverpod Generator가 자동 생성하는 Provider는 클래스명을 기반으로 한다.

| 대상 | 클래스명 | 생성되는 Provider명 |
|---|---|---|
| ViewModel | `[Feature]ViewModel` | `[feature]ViewModelProvider` |
| AppViewModel | `AppViewModel` | `appViewModelProvider` |
| Repository | `[Domain]Repository` | `[domain]RepositoryProvider` |
| UseCase | `Get[Domain]UseCase` | `get[Domain]UseCaseProvider` |
| DataSource | `[Domain]RemoteDataSource` | `[domain]RemoteDataSourceProvider` |
| GoRouter | -- | `appRouterProvider` |

---

## DI 파일 네이밍

- 도메인 파일명: `[domain]_di.dart`
- 스토리지 인프라: `storage_di.dart`
- 네트워크 인프라: `network_di.dart`
- 진입점: `di.dart` (모든 DI 파일을 export)

---

## 디렉토리 네이밍

모든 디렉토리는 `snake_case`.

| 레이어 | 디렉토리 구성 기준 | 예시 |
|---|---|---|
| `core` | 기술 역할 기반 | `network/`, `storage/`, `logging/`, `navigation/`, `viewmodel/` |
| `data` | 도메인 기반 + 공통 | `[domain]/`, `common/` |
| `domain` | 도메인 기반 + 공통 | `[domain]/`, `common/` — enum은 `[domain]/enum/`, 공유 enum은 `common/enum/` |
| `feature` | 화면(UI) 기반 | `[feature]/` |
| `app` | 역할 기반 | `di/`, `router/`, `viewmodel/` |
