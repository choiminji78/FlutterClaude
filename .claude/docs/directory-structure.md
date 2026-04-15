# Directory Structure

## 디렉토리 구조

```
[app]
├── di/
│   ├── storage_di.dart
│   ├── storage_di.g.dart
│   ├── network_di.dart
│   ├── network_di.g.dart
│   ├── [domain]_di.dart
│   ├── [domain]_di.g.dart
│   └── di.dart
├── view/
│   └── app.dart
├── router/
│   ├── app_router.dart
│   ├── app_routes.dart
│   └── go_router_navigation_service.dart
├── viewmodel/
│   ├── app_view_model.dart
│   └── app_view_model.g.dart
├── state/
│   ├── app_state.dart
│   └── app_state.freezed.dart
├── action/
│   ├── app_action.dart
│   └── app_action.freezed.dart
├── reducer/
│   └── app_reducer.dart
└── effect/
    ├── app_locale_effect.dart
    └── app_navigation_effect.dart

[core]
├── network/
│   ├── client/
│   │   ├── base_client.dart
│   │   └── api_client.dart
│   ├── dto/
│   │   ├── api_response.dart
│   │   └── api_response.freezed.dart
│   ├── service/
│   │   └── api_service.dart
│   ├── interceptor/
│   │   ├── logging_interceptor.dart
│   │   ├── error_interceptor.dart
│   │   └── retry_interceptor.dart
│   ├── exception/
│   │   └── network_exception.dart
│   └── utils/
│       └── network_constants.dart
├── storage/
│   ├── common/
│   │   ├── dto/
│   │   │   └── storage_response.dart
│   │   └── exception/
│   │       └── storage_exception.dart
│   ├── preferences/
│   │   └── preferences_service.dart
│   ├── secure_storage/
│   │   └── secure_storage_service.dart
│   └── database/
│       ├── hive/
│       │   ├── models/
│       │   │   ├── [domain]_hive_model.dart
│       │   │   └── [domain]_hive_model.g.dart
│       │   └── hive_database_service.dart
│       └── drift/
│           ├── tables/
│           │   └── [domain]_table.dart
│           ├── drift_database_service.dart
│           └── drift_database_service.g.dart
├── navigation/
│   └── navigation_service.dart
├── viewmodel/
│   ├── base_view_model.dart
│   └── base_keep_alive_view_model.dart
└── logging/
    └── app_logger.dart

[data]
├── common/
│   └── mapper/
│       ├── exception_mapper.dart
│       └── storage_exception_mapper.dart
└── [domain]/
    ├── dto/
    │   ├── request/
    │   │   └── [domain]_request_dto.dart
    │   └── response/
    │       └── [domain]_response_dto.dart
    ├── mapper/
    │   ├── [domain]_mapper.dart
    │   ├── [domain]_hive_mapper.dart   (Hive 사용 시)
    │   └── [domain]_drift_mapper.dart  (Drift 사용 시)
    ├── datasource/
    │   ├── remote/
    │   │   └── [domain]_remote_data_source.dart
    │   └── local/
    │       └── [domain]_local_data_source.dart
    └── repository/
        └── [domain]_repository_impl.dart

[domain]
├── common/
│   ├── exception/
│   │   └── app_exception.dart
│   └── entity/
│       ├── app_result.dart
│       └── app_result.freezed.dart
└── [domain]/
    ├── entity/
    │   └── [domain]_entity.dart
    ├── repository/
    │   └── [domain]_repository.dart
    └── usecase/
        └── [verb]_[domain]_usecase.dart

[feature]
└── [feature]/
    ├── view/
    │   └── [feature]_page.dart
    ├── viewmodel/
    │   ├── [feature]_view_model.dart
    │   └── [feature]_view_model.g.dart
    ├── state/
    │   ├── [feature]_state.dart
    │   └── [feature]_state.freezed.dart
    ├── action/
    │   ├── [feature]_action.dart
    │   └── [feature]_action.freezed.dart
    ├── reducer/
    │   └── [feature]_reducer.dart
    └── effect/
        └── [feature]_effect.dart
```

## 테스트 디렉토리 구조

```
test/
├── app/
│   └── reducer/
│       └── app_reducer_test.dart
├── data/
│   └── [domain]/
│       ├── mapper/
│       │   └── [domain]_mapper_test.dart
│       └── repository/
│           └── [domain]_repository_impl_test.dart
├── domain/
│   └── [domain]/
│       └── usecase/
│           └── [verb]_[domain]_usecase_test.dart
└── feature/
    └── [feature]/
        ├── reducer/
        │   └── [feature]_reducer_test.dart
        └── viewmodel/
            └── [feature]_view_model_test.dart
```
