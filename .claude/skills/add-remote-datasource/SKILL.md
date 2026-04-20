---
name: add-remote-datasource
description: This skill should be used when the user asks to "원격 데이터소스 추가", "remote datasource 만들어줘", "API 연동", "서버 연동", "add-remote-datasource", or requests to create remote DataSource, DTO, Mapper, and Repository implementation for a domain.
argument-hint: "[domain 이름 (예: user, product, order)]"
---

# Add Remote DataSource

`data/[domain]/`에 DTO, Remote DataSource, Mapper, Repository 구현체를 생성하고 DI를 등록한다.

---

## 흐름 유형

`$ARGUMENTS`와 기존 파일 상태에 따라 두 가지 흐름 중 하나를 선택한다.

| 흐름 | 조건 | 진행 |
|---|---|---|
| **흐름 A: 신규 DataSource 설정** | 해당 DataSource 파일이 존재하지 않음 | 단계 0 → 1 → 2 → 3 → 4 → 5 → 6 |
| **흐름 B: 기존 DataSource 메서드 추가** | 해당 DataSource 파일이 이미 존재함 | 단계 0 → 1 → 2(API 명세 파악) → 3-B → 5 → 6 |

흐름 B는 단계 1에서 DataSource 파일이 이미 존재한다는 것을 확인한 시점에 분기한다.

---

## 단계 0: 기반 파일 사전 확인

Glob으로 아래 파일의 존재 여부를 확인한다.

```
lib/core/network/http/dto/api_response.dart
lib/core/network/exception/network_exception.dart
lib/domain/common/entity/app_result.dart
lib/domain/common/exception/app_exception.dart
```

| 파일 | 없을 때 대응 |
|---|---|
| `api_response.dart` / `network_exception.dart` | "ApiResponse/NetworkException이 없습니다. `/init-project`로 프로젝트 기반 구조를 먼저 생성해 주세요." 안내 후 중단 |
| `app_result.dart` / `app_exception.dart` | "AppResult/AppException이 없습니다. `/init-project`로 프로젝트 기반 구조를 먼저 생성해 주세요." 안내 후 중단 |

모두 존재하면 단계 1로 이동.

---

## 단계 1: 도메인·Repository 확인

**`$ARGUMENTS` 있는 경우** — domain 이름으로 해석.
**`$ARGUMENTS` 없는 경우** — 어떤 도메인인지 질문.

Glob으로 아래를 확인한다.

```
lib/domain/[domain]/repository/[domain]_repository.dart                        ← 인터페이스 존재 여부
lib/domain/[domain]/entity/*_entity.dart                                       ← Entity 파일 존재 여부
lib/data/[domain]/datasource/remote/[domain]_remote_data_source.dart           ← DataSource 중복 여부
lib/data/[domain]/repository/[domain]_repository_impl.dart                     ← 구현체 중복 여부
lib/data/common/mapper/exception_mapper.dart                                   ← 공통 ExceptionMapper 존재 여부
```

| 상태 | 대응 |
|---|---|
| Repository 인터페이스 없음 | "Repository 인터페이스가 없습니다. `/add-repository`로 먼저 생성해 주세요." |
| Entity 없음 | "Entity가 없습니다. `/add-entity`로 먼저 생성해 주세요." |
| **DataSource 이미 존재** | "DataSource가 이미 있습니다. API 메서드를 추가할까요, 덮어쓸까요?" 확인 후 분기 — 메서드 추가면 **흐름 B**로, 덮어쓰기면 **흐름 A**로 |
| 구현체 이미 존재 (DataSource 없음) | 흐름 A에서만 해당. "Repository 구현체가 이미 있습니다. 덮어쓸까요?" 확인 후 진행 |
| ExceptionMapper 없음 | `lib/core/network/exception/network_exception.dart`와 `lib/domain/common/exception/app_exception.dart`를 **Read** 해 `when()` 케이스를 파악한 뒤 함께 생성 |
| 모두 정상 | 인터페이스 파일과 Entity 파일을 **Read** 해 메서드 목록·Entity 필드를 파악한 뒤 다음 단계로 |

---

## 단계 2: API 명세 파악

Repository 인터페이스의 메서드별로 아래를 한 번에 질문한다.

- **엔드포인트**: HTTP method + URL (예: `GET /users/{id}`, `POST /users`, `GET /users?page=1&size=10`)
- **응답 필드**: 서버가 반환하는 JSON 필드명·타입 (예: `id: String`, `created_at: String`)
- **요청 body 필드** (POST/PUT/PATCH만): JSON 필드명·타입
- **쿼리 파라미터** (목록 조회 등): 파라미터 이름·타입 (예: `page: int`, `size: int`, `keyword: String?`)
- **JSON 필드명이 snake_case인지**: `@JsonKey(name: '...')` 필요 여부

> GET/DELETE는 Request DTO 불필요. POST/PUT/PATCH만 생성.
> 쿼리 파라미터는 DataSource 메서드 시그니처에 직접 추가하고, RequestDTO로 감싸지 않는다.

---

## 단계 3: 파일 목록 제시

생성할 파일 목록을 제시하고 사용자 확인 후 작성한다.

```
lib/data/common/mapper/exception_mapper.dart                  ← 없을 때만 신규 생성
lib/data/[domain]/dto/response/[domain]_response_dto.dart
lib/data/[domain]/dto/request/[domain]_request_dto.dart       ← write 작업 있을 때만
lib/data/[domain]/datasource/remote/[domain]_remote_data_source.dart
lib/data/[domain]/mapper/[domain]_mapper.dart
lib/data/[domain]/repository/[domain]_repository_impl.dart
lib/app/di/[domain]_di.dart                                   ← 없으면 신규, 있으면 Provider 추가
test/data/[domain]/repository/[domain]_repository_impl_test.dart
```

---

## 단계 3-B: 기존 DataSource 메서드 추가 (흐름 B)

> 이 단계는 흐름 B에서만 실행한다.

### 3-B-1: 기존 파일 Read

아래 파일을 모두 Read해 현재 상태를 파악한다.

```
lib/data/[domain]/datasource/remote/[domain]_remote_data_source.dart  ← 기존 메서드 시그니처
lib/data/[domain]/mapper/[domain]_mapper.dart                         ← 기존 매핑 필드
lib/data/[domain]/repository/[domain]_repository_impl.dart            ← 기존 구현 구조
lib/domain/[domain]/repository/[domain]_repository.dart               ← 인터페이스에 메서드 선언 여부 확인
```

### 3-B-2: 추가 API 명세 파악

단계 2와 동일한 항목을 추가할 메서드 기준으로 질문한다.

- **엔드포인트**: HTTP method + URL
- **응답 필드**: 서버 JSON 필드명·타입
- **요청 body 필드** (POST/PUT/PATCH만)
- **쿼리 파라미터** (목록 조회 등)
- **JSON 필드명이 snake_case인지**

### 3-B-3: 수정 계획 제시

수정할 내용을 먼저 제시하고 사용자 확인 후 진행한다.

```
수정 파일:
  lib/data/[domain]/datasource/remote/[domain]_remote_data_source.dart — [추가 메서드 목록]
  lib/data/[domain]/repository/[domain]_repository_impl.dart           — [추가 메서드 목록]

신규 생성 파일 (해당 시):
  lib/data/[domain]/dto/request/[domain]_request_dto.dart              — 신규 RequestDTO (write 작업 시)
  lib/data/[domain]/mapper/[domain]_mapper.dart                        — 새 매핑 메서드 (필요 시)

확인 필요:
  Repository 인터페이스에 해당 메서드가 없다면 먼저 추가해야 합니다.
    → lib/domain/[domain]/repository/[domain]_repository.dart 확인
  없으면 `/add-repository` 흐름 B로 메서드를 추가한 뒤 이 단계로 돌아오세요.
```

### 3-B-4: 파일 수정

- DataSource abstract에 메서드 시그니처 추가
- DataSource impl에 메서드 구현 추가
- 필요 시 RequestDTO 신규 생성
- 필요 시 Mapper에 변환 메서드 추가
- Repository impl에 메서드 구현 추가

흐름 B 완료 후 단계 5(build_runner)로 이동한다.

---

## 단계 4: 코드 생성

> **흐름 B에서는 이 단계를 건너뛴다.** 파일 수정은 단계 3-B-4에서 완료된다.

### ExceptionMapper (없을 때만 생성)

`lib/core/network/exception/network_exception.dart`와 `lib/domain/common/exception/app_exception.dart`를 **Read** 해 `when()` 케이스를 확인한 뒤 작성한다.

```dart
import 'package:flutter_claude/core/network/exception/network_exception.dart';
import 'package:flutter_claude/domain/common/exception/app_exception.dart';

class ExceptionMapper {
  const ExceptionMapper();

  AppException map(NetworkException exception) {
    return exception.when(
      // Read로 파악한 NetworkException.when() 케이스를 AppException 케이스로 매핑
      // 예: network: (message) => AppException.network(message),
      // 예: server: (statusCode, message) => AppException.server(statusCode, message),
      // 예: unauthorized: (message) => AppException.unauthorized(message),
      // 예: unknown: (message) => AppException.unknown(message),
    );
  }
}
```

> 이 파일은 도메인과 무관한 공통 인프라다. 앱 전체에서 한 번만 생성되며 이후 수정할 필요가 없다.

### Response DTO

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part '[domain]_response_dto.freezed.dart';
part '[domain]_response_dto.g.dart';

@freezed
class [Domain]ResponseDto with _$[Domain]ResponseDto {
  const factory [Domain]ResponseDto({
    required String id,
    // @JsonKey(name: 'created_at') required String createdAt, ← snake_case 필드
    // @Default([]) List<String> tags,
    // String? nullableField,
  }) = _[Domain]ResponseDto;

  factory [Domain]ResponseDto.fromJson(Map<String, dynamic> json) =>
      _$[Domain]ResponseDtoFromJson(json);
}
```

### Request DTO (write 작업 있을 때만)

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part '[domain]_request_dto.freezed.dart';
part '[domain]_request_dto.g.dart';

@freezed
class [Domain]RequestDto with _$[Domain]RequestDto {
  const factory [Domain]RequestDto({
    required String [param],
    // @Default(false) bool [flag],
  }) = _[Domain]RequestDto;

  factory [Domain]RequestDto.fromJson(Map<String, dynamic> json) =>
      _$[Domain]RequestDtoFromJson(json);
}
```

### Remote DataSource

```dart
import 'package:flutter_claude/core/network/http/dto/api_response.dart';
import 'package:flutter_claude/data/[domain]/dto/response/[domain]_response_dto.dart';
// import 'package:flutter_claude/data/[domain]/dto/request/[domain]_request_dto.dart';

abstract class [Domain]RemoteDataSource {
  Future<ApiResponse<[Domain]ResponseDto>> get[Domain]({required String id});
  Future<ApiResponse<[Domain]ResponseDto>> create[Domain]({required [Domain]RequestDto request}); // write 작업 있을 때만
  // Future<ApiResponse<void>> delete[Domain]({required String id});
}

class [Domain]RemoteDataSourceImpl implements [Domain]RemoteDataSource {
  const [Domain]RemoteDataSourceImpl({required this.apiService});

  final ApiService apiService;

  @override
  Future<ApiResponse<[Domain]ResponseDto>> get[Domain]({required String id}) {
    return apiService.get<[Domain]ResponseDto>(
      '/[domain]s/$id',
      (json) => [Domain]ResponseDto.fromJson(json),
    );
  }

  @override
  Future<ApiResponse<[Domain]ResponseDto>> create[Domain]({required [Domain]RequestDto request}) {
    return apiService.post(
      '/[domain]s',
      [Domain]ResponseDto.fromJson,
      body: request.toJson(),
    );
  }
}

// DataSource는 RequestDTO를 파라미터로 받는다.
// Repository 공개 인터페이스는 primitive만 허용 — RequestDTO 생성은 Repository 구현체 내부에서.
```

### Mapper

```dart
import 'package:flutter_claude/domain/[domain]/entity/[domain]_entity.dart';
import 'package:flutter_claude/data/[domain]/dto/response/[domain]_response_dto.dart';
// import 'package:flutter_claude/data/[domain]/dto/request/[domain]_request_dto.dart';

class [Domain]Mapper {
  const [Domain]Mapper();

  [Domain]Entity toDomain([Domain]ResponseDto dto) {
    return [Domain]Entity(
      id: dto.id,
      // name: dto.name,
    );
  }

  // update 메서드가 있을 때만 — Entity → RequestDTO 변환
  // [Domain]RequestDto toUpdateRequest([Domain]Entity entity) {
  //   return [Domain]RequestDto(
  //     param: entity.param,
  //   );
  // }

  // create는 Mapper 불필요 — Repository 구현체에서 primitives → DTO 직접 생성
}
```

### Repository 구현체

```dart
import 'package:flutter_claude/domain/common/entity/app_result.dart';
import 'package:flutter_claude/domain/common/exception/app_exception.dart';
import 'package:flutter_claude/domain/[domain]/entity/[domain]_entity.dart';
import 'package:flutter_claude/domain/[domain]/repository/[domain]_repository.dart';
import 'package:flutter_claude/data/[domain]/datasource/remote/[domain]_remote_data_source.dart';
import 'package:flutter_claude/data/[domain]/mapper/[domain]_mapper.dart';
import 'package:flutter_claude/data/common/mapper/exception_mapper.dart';

class [Domain]RepositoryImpl implements [Domain]Repository {
  const [Domain]RepositoryImpl({
    required this.remoteDataSource,
    required this.mapper,
    required this.exceptionMapper,
  });

  final [Domain]RemoteDataSource remoteDataSource;
  final [Domain]Mapper mapper;
  final ExceptionMapper exceptionMapper;

  @override
  Future<AppResult<[Domain]Entity>> get[Domain]({required String id}) async {
    final response = await remoteDataSource.get[Domain](id: id);
    return response.when(
      success: (dto) => AppResult.success(mapper.toDomain(dto)),
      failure: (exception) => AppResult.failure(exceptionMapper.map(exception)),
    );
  }

  // create: primitive 파라미터 → 내부에서 RequestDto 생성 → get과 동일 패턴으로 AppResult 변환
  // delete: AppResult<void>는 `success: (_) => const AppResult.success(null)` 패턴
}
```

> `void` 반환 메서드: `AppResult.success(null)` 로 작성.
> 응답 DTO가 없는 경우 (204 No Content 등): `ApiResponse<void>` 사용.
> create 메서드: Repository 파라미터는 primitive만 허용 — RequestDTO 생성은 Repository 구현체 내부에서 직접.

### DI 등록

> **기존 파일 수정 전 필수**: `[domain]_di.dart`가 이미 존재하면 반드시 **Read** 해 현재 Provider 목록을 파악한 뒤 DataSource·Repository Provider를 추가한다. 기존 UseCase Provider를 덮어쓰지 않도록 주의한다.

신규 `[domain]_di.dart`면 `lib/app/di/di.dart`에 아래 한 줄을 추가한다.

```dart
export '[domain]_di.dart';
```

```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_claude/app/di/network_di.dart';
import 'package:flutter_claude/data/[domain]/datasource/remote/[domain]_remote_data_source.dart';
import 'package:flutter_claude/data/[domain]/mapper/[domain]_mapper.dart';
import 'package:flutter_claude/data/[domain]/repository/[domain]_repository_impl.dart';
import 'package:flutter_claude/data/common/mapper/exception_mapper.dart';
import 'package:flutter_claude/domain/[domain]/repository/[domain]_repository.dart';

part '[domain]_di.g.dart';

// 순서 1: DataSource
@Riverpod(keepAlive: true)
[Domain]RemoteDataSource [domain]RemoteDataSource([Domain]RemoteDataSourceRef ref) {
  return [Domain]RemoteDataSourceImpl(
    apiService: ref.read([server]ApiServiceProvider), // add-network에서 생성된 서버별 Provider명 사용
  );
}

// 순서 2: Repository
@Riverpod(keepAlive: true)
[Domain]Repository [domain]Repository([Domain]RepositoryRef ref) {
  return [Domain]RepositoryImpl(
    remoteDataSource: ref.read([domain]RemoteDataSourceProvider),
    mapper: const [Domain]Mapper(),
    exceptionMapper: const ExceptionMapper(),
  );
}
```

> `keepAlive: true` Provider에서 의존성 주입은 `ref.read`. `ref.watch` 사용 금지.
> `ExceptionMapper`, `[Domain]Mapper`는 상태가 없으므로 `const` 생성.

### 테스트

> `.claude/docs/testing-detail.md` **Repository 테스트** 섹션 참조.

- RemoteDataSource를 mock해 `ApiResponse.success/failure` stub → AppResult 변환 검증

---

## 단계 5: build_runner

```bash
dart run build_runner build --delete-conflicting-outputs
```

변경 파일에 아래가 포함됐는지 확인한다.

- `[domain]_response_dto.freezed.dart` / `[domain]_response_dto.g.dart`
- `[domain]_request_dto.freezed.dart` / `[domain]_request_dto.g.dart` (있을 때만)
- `[domain]_di.g.dart`
- `[domain]_repository_impl_test.mocks.dart`

---

## 단계 6: 검증

```bash
flutter analyze
flutter test test/data/[domain]/repository/[domain]_repository_impl_test.dart
```

- Repository 구현체 import: `domain/` + `data/` + `core/network/` 만 허용
- `feature` / `app` import 없음
- `ApiResponse` / `StorageResponse`가 Repository 구현체 외부로 노출되지 않음
- 모든 `ApiResponse.when()` 케이스 처리 (success / failure)
- 신규 `[domain]_di.dart`면 `di.dart`에 export 추가됐는지 확인

---

## 금지

- Repository 구현체에서 `ApiResponse` / `NetworkException`을 UseCase / ViewModel로 전달
- Mapper를 UseCase / ViewModel에서 직접 호출
- DataSource 없이 Repository 구현체에서 HTTP 직접 호출
- `ref.watch`를 `keepAlive: true` DI Provider에서 사용
- 사용자 확인 없이 기존 파일 수정
- 흐름 B에서 기존 DataSource를 Read하지 않고 메서드 추가
- 흐름 B에서 Repository 인터페이스 확인 없이 DataSource 메서드만 추가하고 종료
