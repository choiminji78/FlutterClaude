---
name: add-local-datasource
description: This skill should be used when the user asks to "로컬 데이터소스 추가", "local datasource 만들어줘", "로컬 저장소 연동", "캐시 추가", "add-local-datasource", or requests to create local DataSource, PersistenceModel, Mapper, and Repository implementation for a domain.
argument-hint: "[domain 이름 (예: user, product, order)]"
---

# Add Local DataSource

`data/[domain]/`에 Local DataSource, Mapper, Repository 구현체를 생성하고 DI를 등록한다.
저장소 유형에 따라 Drift Table(`core/storage/database/drift/tables/`)을 함께 생성한다.

> 로컬 저장소 선택 기준·DataSource 조합 기준 → `.claude/docs/architecture-detail.md`
> 파일명·클래스명 패턴 → `.claude/docs/naming-detail.md`
> 디렉토리 구조 → `.claude/docs/directory-structure.md`
> 테스트 패턴 → `.claude/docs/testing-detail.md`

---

## 단계 0: 기반 파일 사전 확인

Glob으로 아래 파일의 존재 여부를 확인한다.

```
lib/core/storage/common/dto/storage_response.dart
lib/core/storage/common/exception/storage_exception.dart
lib/domain/common/entity/app_result.dart
lib/domain/common/exception/app_exception.dart
```

| 파일 | 없을 때 대응 |
|---|---|
| `storage_response.dart` / `storage_exception.dart` | "StorageResponse/StorageException이 없습니다. `/init-project`로 프로젝트 기반 구조를 먼저 생성해 주세요." 안내 후 중단 |
| `app_result.dart` / `app_exception.dart` | "AppResult/AppException이 없습니다. `/init-project`로 프로젝트 기반 구조를 먼저 생성해 주세요." 안내 후 중단 |

모두 존재하면 단계 1로 이동.

---

## 단계 1: 도메인·Repository 확인

**`$ARGUMENTS` 있는 경우** — domain 이름으로 해석.
**`$ARGUMENTS` 없는 경우** — 어떤 도메인인지 질문.

Glob으로 아래를 확인한다.

```
lib/domain/[domain]/repository/[domain]_repository.dart              ← 인터페이스 존재 여부
lib/domain/[domain]/entity/*_entity.dart                             ← Entity 파일 존재 여부
lib/data/[domain]/repository/[domain]_repository_impl.dart           ← 구현체 존재 여부 (remote 선행 여부)
lib/data/[domain]/datasource/local/[domain]_local_data_source.dart   ← 중복 여부
lib/data/common/mapper/storage_exception_mapper.dart                 ← 공통 StorageExceptionMapper 존재 여부
```

| 상태 | 대응 |
|---|---|
| Repository 인터페이스 없음 | "Repository 인터페이스가 없습니다. `/add-repository`로 먼저 생성해 주세요." |
| Entity 없음 | "Entity가 없습니다. `/add-entity`로 먼저 생성해 주세요." |
| Entity 존재 | Entity 파일을 **Read** 해 필드를 파악한다 |
| 구현체 이미 존재 (remote 선행) | "Remote Repository 구현체가 있습니다. local DataSource를 추가로 주입하는 방식으로 진행할까요?" 확인 후 `[domain]_repository_impl.dart`와 `[domain]_di.dart`를 **Read** 해 현재 생성자 구조·Provider 목록을 파악한 뒤 진행 |
| 구현체 없음 | local only 구현체를 신규 생성 |
| LocalDataSource 이미 존재 | "동일한 Local DataSource가 있습니다. 덮어쓸까요?" 확인 후 진행 |
| StorageExceptionMapper 없음 | `lib/core/storage/common/exception/storage_exception.dart`와 `lib/domain/common/exception/app_exception.dart`를 **Read** 해 `when()` 케이스를 파악한 뒤 함께 생성 |

> **참고**: 로케일·테마처럼 앱 전체 생명주기를 가지는 설정값은 로컬 DataSource 대신 `AppState` + `AppViewModel`에서 직접 관리하는 게 더 적합할 수 있다. 사용자가 app-level 설정을 요청하면 이 점을 먼저 안내한다.

---

## 단계 2: 저장소 유형 선택

아래 기준을 제시하고 사용자가 선택한다.

| 저장소 | 적합한 경우 | PersistenceModel 필요 |
|---|---|---|
| **Drift** | 구조화된 객체 목록, SQL 쿼리·조인·인덱싱·대용량 데이터 | 필요 (`[Domain]Table`) |
| **SharedPreferences** | 비민감 키-값 설정 (로케일, 테마, 플래그) | 불필요 |
| **SecureStorage** | 민감 정보 (토큰, 인증 정보) | 불필요 |

---

## 단계 3: 저장 데이터 파악 (Drift만)

SharedPreferences / SecureStorage는 이 단계를 건너뛴다.

Drift 선택 시 아래를 한 번에 질문한다.

- **저장할 필드 목록**: 이름·Dart 타입·Drift 컬럼 타입
  - 예: `id: int (IntColumn, autoIncrement)`, `name: String (TextColumn)`, `createdAt: DateTime (DateTimeColumn)`
- **Primary key**: autoIncrement int (기본) 또는 UUID text
- **저장 메서드**: 조회(get)·저장(save/upsert)·삭제(delete)·목록(getAll) 중 필요한 것
- **테이블 이름**: 기본값은 `'[domain]'` — 변경 필요 시 명시

> **Drift 스키마 주의**: 새 테이블을 추가하면 `DriftDatabaseService`의 `schemaVersion`을 올리고 `migration`을 추가해야 한다. 스킬 완료 후 사용자에게 반드시 안내한다.

---

## 단계 4: 파일 목록 제시

생성할 파일 목록을 제시하고 사용자 확인 후 작성한다.

**Drift**
```
lib/data/common/mapper/storage_exception_mapper.dart                              ← 없을 때만 신규 생성
lib/core/storage/database/drift/tables/[domain]_table.dart                        ← Table 정의
lib/data/[domain]/datasource/local/[domain]_local_data_source.dart
lib/data/[domain]/mapper/[domain]_drift_mapper.dart
lib/data/[domain]/repository/[domain]_repository_impl.dart                        ← 신규 또는 업데이트
lib/app/di/[domain]_di.dart                                                       ← 없으면 신규, 있으면 Provider 추가/교체
test/data/[domain]/datasource/local/[domain]_local_data_source_test.dart
test/data/[domain]/repository/[domain]_repository_impl_test.dart
```

> 추가로 사용자가 직접 수정해야 할 파일:
> `lib/core/storage/database/drift/drift_database_service.dart` — `@DriftDatabase(tables: [...])` 에 `[Domain]Table` 추가 + `schemaVersion` 증가 + migration 추가

**SharedPreferences / SecureStorage**
```
lib/data/common/mapper/storage_exception_mapper.dart                 ← 없을 때만 신규 생성
lib/data/[domain]/datasource/local/[domain]_local_data_source.dart
lib/data/[domain]/repository/[domain]_repository_impl.dart           ← 신규 또는 업데이트
lib/app/di/[domain]_di.dart                                          ← 없으면 신규, 있으면 Provider 추가/교체
test/data/[domain]/datasource/local/[domain]_local_data_source_test.dart
test/data/[domain]/repository/[domain]_repository_impl_test.dart
```

---

## 단계 5: 코드 생성

### StorageExceptionMapper (없을 때만 생성)

`lib/core/storage/common/exception/storage_exception.dart`와 `lib/domain/common/exception/app_exception.dart`를 **Read** 해 `when()` 케이스를 확인한 뒤 작성한다.

```dart
import 'package:flutter_claude/core/storage/common/exception/storage_exception.dart';
import 'package:flutter_claude/domain/common/exception/app_exception.dart';

class StorageExceptionMapper {
  const StorageExceptionMapper();

  AppException map(StorageException exception) {
    return exception.when(
      // Read로 파악한 StorageException.when() 케이스를 AppException 케이스로 매핑
      // 예: notFound: (message) => AppException.notFound(message),
      // 예: general: (message) => AppException.unknown(message),
    );
  }
}
```

> 이 파일은 도메인과 무관한 공통 인프라다. 앱 전체에서 한 번만 생성되며 이후 수정할 필요가 없다.

---

### Drift Table (core/storage/database/drift/tables/)

```dart
import 'package:drift/drift.dart';

@DataClassName('[Domain]TableData')
class [Domain]Table extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  // DateTimeColumn get createdAt => dateTime()();

  @override
  String get tableName => '[domain]';
}
```

> `@DataClassName('[Domain]TableData')` 를 붙여 Entity 클래스명과 충돌을 방지한다.
> 이 파일을 생성한 뒤, 사용자가 `drift_database_service.dart`의 `@DriftDatabase(tables: [...])` 에 `[Domain]Table`을 추가하고 `schemaVersion`을 올려야 한다고 안내한다.

---

### Local DataSource — Drift

```dart
import 'package:flutter_claude/core/storage/common/dto/storage_response.dart';
import 'package:flutter_claude/core/storage/common/exception/storage_exception.dart';
import 'package:flutter_claude/core/storage/database/drift/drift_database_service.dart';
import 'package:flutter_claude/core/storage/database/drift/tables/[domain]_table.dart';
import 'package:drift/drift.dart';

abstract class [Domain]LocalDataSource {
  Future<StorageResponse<[Domain]TableData>> get[Domain]({required int id});
  Future<StorageResponse<void>> save[Domain]({required [Domain]TableData data});
  // Future<StorageResponse<void>> delete[Domain]({required int id});
  // Future<StorageResponse<List<[Domain]TableData>>> getAll[Domain]s();
}

class [Domain]LocalDataSourceImpl implements [Domain]LocalDataSource {
  const [Domain]LocalDataSourceImpl({required this.db});

  final DriftDatabaseService db;

  @override
  Future<StorageResponse<[Domain]TableData>> get[Domain]({
    required int id,
  }) async {
    try {
      final row = await (db.select(db.[domain]Table)
            ..where((t) => t.id.equals(id)))
          .getSingleOrNull();
      if (row == null) {
        return StorageResponse.failure(
          StorageException.notFound('[Domain] not found: $id'),
        );
      }
      return StorageResponse.success(row);
    } catch (e) {
      return StorageResponse.failure(StorageException.general(e.toString()));
    }
  }

  @override
  Future<StorageResponse<void>> save[Domain]({
    required [Domain]TableData data,
  }) async {
    try {
      await db.into(db.[domain]Table).insertOnConflictUpdate(
        [Domain]TableCompanion(
          // id: Value(data.id),
          // name: Value(data.name),
        ),
      );
      return const StorageResponse.success(null);
    } catch (e) {
      return StorageResponse.failure(StorageException.general(e.toString()));
    }
  }
}
```

---

### Local DataSource — SharedPreferences

> SharedPreferences `getString()` 등 읽기 메서드는 인스턴스 초기화 후 **동기** 호출 가능.
> 읽기는 `StorageResponse<T>` (Future 없음), 쓰기(`setString` 등)는 `Future<StorageResponse<void>>`.

```dart
import 'package:flutter_claude/core/storage/common/dto/storage_response.dart';
import 'package:flutter_claude/core/storage/common/exception/storage_exception.dart';
import 'package:flutter_claude/core/storage/preferences/preferences_service.dart';

abstract class [Domain]LocalDataSource {
  StorageResponse<String> get[Value]();                          // 동기 읽기
  Future<StorageResponse<void>> save[Value]({required String value}); // 비동기 쓰기
}

class [Domain]LocalDataSourceImpl implements [Domain]LocalDataSource {
  const [Domain]LocalDataSourceImpl({required this.preferencesService});

  final PreferencesService preferencesService;

  static const _key[Value] = '[domain]_[value]';

  @override
  StorageResponse<String> get[Value]() {
    final value = preferencesService.getString(_key[Value]); // 동기
    if (value == null) {
      return StorageResponse.failure(
        StorageException.notFound('[Value] not found'),
      );
    }
    return StorageResponse.success(value);
  }

  @override
  Future<StorageResponse<void>> save[Value]({required String value}) async {
    try {
      await preferencesService.setString(_key[Value], value);
      return const StorageResponse.success(null);
    } catch (e) {
      return StorageResponse.failure(StorageException.general(e.toString()));
    }
  }
}
```

---

### Local DataSource — SecureStorage

```dart
import 'package:flutter_claude/core/storage/common/dto/storage_response.dart';
import 'package:flutter_claude/core/storage/common/exception/storage_exception.dart';
import 'package:flutter_claude/core/storage/secure_storage/secure_storage_service.dart';

abstract class [Domain]LocalDataSource {
  Future<StorageResponse<String>> get[Value]();
  Future<StorageResponse<void>> save[Value]({required String value});
  Future<StorageResponse<void>> delete[Value]();
}

class [Domain]LocalDataSourceImpl implements [Domain]LocalDataSource {
  const [Domain]LocalDataSourceImpl({required this.secureStorageService});

  final SecureStorageService secureStorageService;

  static const _key[Value] = '[domain]_[value]';

  @override
  Future<StorageResponse<String>> get[Value]() async {
    try {
      final value = await secureStorageService.read(key: _key[Value]);
      if (value == null) {
        return StorageResponse.failure(
          StorageException.notFound('[Value] not found'),
        );
      }
      return StorageResponse.success(value);
    } catch (e) {
      return StorageResponse.failure(StorageException.general(e.toString()));
    }
  }

  @override
  Future<StorageResponse<void>> save[Value]({required String value}) async {
    try {
      await secureStorageService.write(key: _key[Value], value: value);
      return const StorageResponse.success(null);
    } catch (e) {
      return StorageResponse.failure(StorageException.general(e.toString()));
    }
  }

  @override
  Future<StorageResponse<void>> delete[Value]() async {
    try {
      await secureStorageService.delete(key: _key[Value]);
      return const StorageResponse.success(null);
    } catch (e) {
      return StorageResponse.failure(StorageException.general(e.toString()));
    }
  }
}
```

---

### Drift Mapper

```dart
import 'package:flutter_claude/core/storage/database/drift/tables/[domain]_table.dart';
import 'package:flutter_claude/domain/[domain]/entity/[domain]_entity.dart';
import 'package:drift/drift.dart';

class [Domain]DriftMapper {
  const [Domain]DriftMapper();

  [Domain]Entity toDomain([Domain]TableData data) {
    return [Domain]Entity(
      id: data.id,
      // name: data.name,
    );
  }

  [Domain]TableCompanion toLocal([Domain]Entity entity) {
    return [Domain]TableCompanion(
      // id: Value(entity.id),
      // name: Value(entity.name),
    );
  }
}
```

> SharedPreferences / SecureStorage는 primitive type 반환이므로 별도 Mapper 불필요.
> Mapper가 필요 없을 경우 Repository 구현체에서 직접 Entity ↔ primitive 변환.

---

### Repository 구현체 — local only (신규)

```dart
import 'package:flutter_claude/domain/common/entity/app_result.dart';
import 'package:flutter_claude/domain/common/exception/app_exception.dart';
import 'package:flutter_claude/domain/[domain]/entity/[domain]_entity.dart';
import 'package:flutter_claude/domain/[domain]/repository/[domain]_repository.dart';
import 'package:flutter_claude/data/[domain]/datasource/local/[domain]_local_data_source.dart';
import 'package:flutter_claude/data/[domain]/mapper/[domain]_drift_mapper.dart';
import 'package:flutter_claude/data/common/mapper/storage_exception_mapper.dart';

class [Domain]RepositoryImpl implements [Domain]Repository {
  const [Domain]RepositoryImpl({
    required this.localDataSource,
    required this.driftMapper,
    required this.storageExceptionMapper,
  });

  final [Domain]LocalDataSource localDataSource;
  final [Domain]DriftMapper driftMapper;
  final StorageExceptionMapper storageExceptionMapper;

  @override
  Future<AppResult<[Domain]Entity>> get[Domain]({required int id}) async {
    final response = await localDataSource.get[Domain](id: id);
    return response.when(
      success: (data) => AppResult.success(driftMapper.toDomain(data)),
      failure: (exception) => AppResult.failure(storageExceptionMapper.map(exception)),
    );
  }
}
```

---

### Repository 구현체 — remote + local (기존 구현체에 local 추가)

remote 구현체가 이미 있을 경우, localDataSource와 driftMapper를 추가 주입하고 해당 메서드에 local 로직을 추가한다.

```dart
class [Domain]RepositoryImpl implements [Domain]Repository {
  const [Domain]RepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,        // ← 추가
    required this.mapper,
    required this.driftMapper,            // ← 추가
    required this.exceptionMapper,
    required this.storageExceptionMapper, // ← 추가
  });

  final [Domain]RemoteDataSource remoteDataSource;
  final [Domain]LocalDataSource localDataSource;        // ← 추가
  final [Domain]Mapper mapper;
  final [Domain]DriftMapper driftMapper;                // ← 추가
  final ExceptionMapper exceptionMapper;
  final StorageExceptionMapper storageExceptionMapper;  // ← 추가

  // save[Domain]: 명시적 캐시 저장 액션
  @override
  Future<AppResult<void>> save[Domain]({required [Domain]Entity entity}) async {
    final companion = driftMapper.toLocal(entity);
    final response = await localDataSource.save[Domain](data: companion as [Domain]TableData);
    return response.when(
      success: (_) => const AppResult.success(null),
      failure: (exception) => AppResult.failure(storageExceptionMapper.map(exception)),
    );
  }
}
```

> local 저장은 명시적 Action이 있을 때만. 자동 캐시(remote 응답 → local 저장) 금지.

---

### DI 등록

신규 `[domain]_di.dart`면 `lib/app/di/di.dart`에 아래 한 줄을 추가한다.

```dart
export '[domain]_di.dart';
```

> **기존 파일 수정 전 필수**: `[domain]_di.dart`가 이미 존재하면 반드시 **Read** 해 현재 Provider 목록을 파악한다. remote-only `[domain]Repository` Provider를 삭제하고 combined 버전으로 교체한다. 기존 Provider를 남겨두면 중복 등록이 된다.

```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_claude/core/storage/database/drift/drift_database_service.dart';
import 'package:flutter_claude/data/[domain]/datasource/local/[domain]_local_data_source.dart';
import 'package:flutter_claude/data/[domain]/mapper/[domain]_drift_mapper.dart';
import 'package:flutter_claude/data/[domain]/repository/[domain]_repository_impl.dart';
import 'package:flutter_claude/data/common/mapper/storage_exception_mapper.dart';
import 'package:flutter_claude/domain/[domain]/repository/[domain]_repository.dart';

part '[domain]_di.g.dart';
```

```dart
// 순서 1: Local DataSource (Drift)
@Riverpod(keepAlive: true)
[Domain]LocalDataSource [domain]LocalDataSource([Domain]LocalDataSourceRef ref) {
  return [Domain]LocalDataSourceImpl(
    db: ref.read(driftDatabaseServiceProvider),
  );
}

// 순서 2: Repository (local only)
@Riverpod(keepAlive: true)
[Domain]Repository [domain]Repository([Domain]RepositoryRef ref) {
  return [Domain]RepositoryImpl(
    localDataSource: ref.read([domain]LocalDataSourceProvider),
    driftMapper: const [Domain]DriftMapper(),
    storageExceptionMapper: const StorageExceptionMapper(),
  );
}

// remote + local: remoteDataSource + localDataSource + mapper + driftMapper + exceptionMapper + storageExceptionMapper 주입
```

**SharedPreferences — `preferencesServiceProvider`가 `Future<PreferencesService>` 타입인 경우:**

DataSource Provider도 async로 선언해야 한다. 이를 의존하는 Repository Provider도 `.future`로 await한다.

```dart
// 순서 1: Local DataSource (SharedPreferences — async provider)
@Riverpod(keepAlive: true)
Future<[Domain]LocalDataSource> [domain]LocalDataSource([Domain]LocalDataSourceRef ref) async {
  final prefs = await ref.read(preferencesServiceProvider.future);
  return [Domain]LocalDataSourceImpl(preferencesService: prefs);
}

// 순서 2: Repository
@Riverpod(keepAlive: true)
Future<[Domain]Repository> [domain]Repository([Domain]RepositoryRef ref) async {
  final localDataSource = await ref.read([domain]LocalDataSourceProvider.future);
  return [Domain]RepositoryImpl(
    localDataSource: localDataSource,
    storageExceptionMapper: const StorageExceptionMapper(),
  );
}
```

> Effect에서 async Provider를 사용할 때: `await _ref.read([domain]RepositoryProvider.future)`

**SecureStorage:**
```dart
// 순서 1: Local DataSource (SecureStorage — 동기 provider)
@Riverpod(keepAlive: true)
[Domain]LocalDataSource [domain]LocalDataSource([Domain]LocalDataSourceRef ref) {
  return [Domain]LocalDataSourceImpl(
    secureStorageService: ref.read(secureStorageServiceProvider),
  );
}
```

---

### 테스트

> `.claude/docs/testing-detail.md` **DataSource 테스트** / **Repository 테스트** 섹션 참조.

- DataSource 테스트: 저장소 서비스(PreferencesService·SecureStorageService·Drift DB)를 mock 또는 in-memory로 교체해 각 메서드 success/failure 검증
- Repository 테스트: LocalDataSource를 mock해 AppResult 변환 검증 + `provideDummy` 필수

---

## 단계 6: build_runner

```bash
dart run build_runner build --delete-conflicting-outputs
```

변경 파일에 아래가 포함됐는지 확인한다.

- `drift_database_service.g.dart` (Drift만 — 테이블 추가 시 재생성)
- `[domain]_di.g.dart`
- `[domain]_repository_impl_test.mocks.dart`

---

## 단계 7: 검증

```bash
flutter analyze
flutter test test/data/[domain]/repository/[domain]_repository_impl_test.dart
```

- Local DataSource import: `core/storage/` + `core/storage/database/drift/` 만 허용
- Mapper import: `core/storage/database/drift/tables/` + `domain/[domain]/entity/` 만 허용
- Repository 구현체 외부로 `StorageResponse` / `StorageException` 노출 없음
- 모든 `StorageResponse.when()` 케이스 처리 (success / failure)
- Drift: `drift_database_service.dart`에 `[Domain]Table` 추가·`schemaVersion` 증가·migration 추가 완료 여부 확인

---

## 금지

- Drift Table을 `data/` 레이어에 위치시키는 것 — 반드시 `core/storage/database/drift/tables/`
- remote 응답을 자동으로 local에 캐시 — 명시적 Action이 있을 때만 저장
- `StorageResponse` / `StorageException`을 Repository 구현체 외부로 전달
- `ref.watch`를 `keepAlive: true` DI Provider에서 사용
- 사용자 확인 없이 기존 파일 수정
