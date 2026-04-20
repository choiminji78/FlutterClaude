---
name: add-storage-drift
description: This skill should be used when the user asks to "Drift 저장소 추가", "SQLite 저장소 추가", "로컬 DB 추가", "Drift 테이블 추가", "구조화 저장소 추가", "로컬 데이터베이스 추가", "add-storage-drift", or requests creation or extension of a Drift(SQLite ORM)-based local database storage for a domain.
argument-hint: "[domain]"
---

# Add Drift Storage

Drift(SQLite ORM) 기반 로컬 DB 저장소를 도메인 단위로 생성하거나 기존 도메인에 CRUD 메서드를 추가한다.

---

## 핵심 원칙

1. **단방향 의존** — DataSource → Repository → ViewModel 경로만. ViewModel·UseCase에서 `DriftDatabaseService` 직접 참조 금지.
2. **변환 책임** — `StorageResponse → AppResult` 변환은 Repository 구현체에서만. DataSource는 `StorageResponse<[Domain]TableData>` 그대로 반환.
3. **Mapper 필수** — `[Domain]TableData → [Domain]Entity` 변환은 `[Domain]DriftMapper`가 담당. Repository 직접 변환 금지.
4. **명시적 저장** — Remote First. 로컬 저장은 명시적 Action이 있을 때만.
5. **계획 우선** — 파일 생성·수정 전 계획 제시 후 승인 필수.
6. **추측 금지** — 도메인명·필드명·타입 불명확 시 질문.

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

모두 존재하면 다음으로 이동.

---

## pubspec.yaml 확인

**Read**로 읽어 세 가지 확인:
1. `name:` → 이후 모든 import의 `[pkg]`
2. `drift:` 없으면 추가 후 `flutter pub get`
3. `drift_dev:` 없으면 dev_dependencies에 추가

```yaml
dependencies:
  drift: ^2.22.1
  drift_flutter: ^0.2.3
dev_dependencies:
  drift_dev: ^2.22.1
```

---

## 단계 1: 인수 확인

`$ARGUMENTS`가 없으면 도메인명을 질문한다. 있으면 단계 2로.

---

## 단계 2: 기존 파일 탐색 → 흐름 분기

Glob으로 아래 파일 존재 여부 확인:

```
lib/core/storage/database/drift/drift_database_service.dart
lib/core/storage/database/drift/tables/[domain]_table.dart
lib/data/[domain]/datasource/local/[domain]_local_data_source.dart
lib/data/[domain]/mapper/[domain]_drift_mapper.dart
lib/domain/[domain]/entity/[domain]_entity.dart
lib/domain/[domain]/repository/[domain]_repository.dart
lib/data/[domain]/repository/[domain]_repository_impl.dart
lib/data/common/mapper/storage_exception_mapper.dart
lib/app/di/storage_di.dart
lib/app/di/[domain]_di.dart
```

| DriftDatabaseService | `[Domain]Table` | LocalDataSource | 흐름 |
|---|---|---|---|
| 없음 | — | — | **신규 설정** → 3A |
| 있음 | 없음 | 없음 | **테이블 신규** → 3B |
| 있음 | 있음 | 없음 | **DataSource 신규** → 3B (테이블 생성·migration 생략) |
| 있음 | 있음 | 있음 (Drift) | **메서드 추가** → 3C |
| 있음 | 없음 | 있음 (다른 방식) | **통합 추가** → 3D |

**추가 확인:**
- `[domain]_entity.dart` 없으면 → "Entity 없음. `/add-entity` 먼저." 후 중단.
- `[domain]_repository.dart` 없으면 → "Repository 인터페이스 없음. `/add-repository` 먼저." 후 중단.
- `drift_database_service.dart` 있으면 **Read** → 현재 `schemaVersion`(N)과 `@DriftDatabase(tables:[...])` 목록 파악. ⚠️ 기존 `onUpgrade` 블록도 반드시 파악해 둔다 (단계 5에서 보존 필요).
- `[domain]_repository.dart` 있으면 **Read** → 기존 시그니처 파악.
- `storage_exception_mapper.dart` 없으면 단계 5에서 생성.

---

## 단계 3 공통: 테이블 필드 수집

3C(메서드 추가)는 이 단계 건너뜀.

한 번에 질문:
- **저장할 필드 목록** (이름·Dart 타입·Drift 컬럼 타입·nullable 여부)
- **Primary key**: `autoIncrement int` (기본) 또는 `UUID text`
- **필요한 CRUD 작업**: `get(id)` / `getAll()` / `insert()` / `upsert()` / `delete(id)`
- **테이블 이름**: 기본값 `'[domain]'`

**지원 컬럼 타입:**

| Dart 타입 | Drift 컬럼 |
|---|---|
| `int` | `IntColumn` |
| `String` | `TextColumn` |
| `bool` | `BoolColumn` |
| `double` | `RealColumn` |
| `DateTime` | `DateTimeColumn` |
| `Uint8List` | `BlobColumn` |

nullable: `.nullable()()`. 예: `real().nullable()()`

---

## 단계 3A: 신규 설정

`DriftDatabaseService` 없는 경우.

| # | 파일 | 역할 |
|---|---|---|
| 1 | `pubspec.yaml` | drift / drift_flutter / drift_dev 추가 |
| 2 | `lib/data/common/mapper/storage_exception_mapper.dart` | 없을 때만 생성 |
| 3 | `lib/core/storage/database/drift/tables/[domain]_table.dart` | Table 정의 |
| 4 | `lib/core/storage/database/drift/drift_database_service.dart` | 신규 생성 |
| 5 | `lib/data/[domain]/datasource/local/[domain]_local_data_source.dart` | LocalDataSource |
| 6 | `lib/data/[domain]/mapper/[domain]_drift_mapper.dart` | DriftMapper |
| 7 | `lib/data/[domain]/repository/[domain]_repository_impl.dart` | RepositoryImpl |
| 8 | `lib/app/di/storage_di.dart` | driftDatabaseServiceProvider 추가 |
| 9 | `lib/app/di/di.dart` | storage_di.dart 신규 시 export 추가 |
| 10 | `lib/app/di/[domain]_di.dart` | DataSource·Repository Provider |
| 11 | `lib/app/di/di.dart` | [domain]_di.dart 신규 시 export 추가 |
| 12 | `test/data/[domain]/repository/[domain]_repository_impl_test.dart` | 테스트 |

---

## 단계 3B: 테이블 신규 (+ DataSource 신규 변형 포함)

`DriftDatabaseService` 있음 + 해당 도메인 테이블 없음 (또는 테이블은 있지만 LocalDataSource 없음).

| # | 파일 | 역할 |
|---|---|---|
| 1 | `lib/data/common/mapper/storage_exception_mapper.dart` | 없을 때만 생성 |
| 2 | `lib/core/storage/database/drift/tables/[domain]_table.dart` | Table 정의 신규 (**테이블 이미 있으면 생략**) |
| 3 | `lib/core/storage/database/drift/drift_database_service.dart` | 테이블 추가 + `schemaVersion` +1 + migration (**테이블 이미 있으면 생략**) |
| 4 | `lib/data/[domain]/datasource/local/[domain]_local_data_source.dart` | LocalDataSource 신규 |
| 5 | `lib/data/[domain]/mapper/[domain]_drift_mapper.dart` | DriftMapper 신규 |
| 6 | `lib/data/[domain]/repository/[domain]_repository_impl.dart` | RepositoryImpl (없으면 생성, 있으면 메서드 추가) |
| 7 | `lib/app/di/[domain]_di.dart` | DataSource·Repository Provider |
| 8 | `lib/app/di/di.dart` | [domain]_di.dart 신규 시 export 추가 |
| 9 | `test/data/[domain]/repository/[domain]_repository_impl_test.dart` | 테스트 |

> ⚠️ `drift_database_service.dart` 수정 시: 단계 2에서 파악한 `onUpgrade` 기존 블록을 **반드시 유지**하고 새 migration만 마지막에 추가한다. 기존 블록 삭제·재작성 금지.

---

## 단계 3C: 메서드 추가

스키마 변경 없음.

| # | 파일 | 수정 내용 |
|---|---|---|
| 1 | `lib/data/[domain]/datasource/local/[domain]_local_data_source.dart` | abstract + Impl에 메서드 추가 |
| 2 | `lib/data/[domain]/mapper/[domain]_drift_mapper.dart` | 필요 시 매핑 필드 추가 |
| 3 | `lib/domain/[domain]/repository/[domain]_repository.dart` | 메서드 시그니처 추가 |
| 4 | `lib/data/[domain]/repository/[domain]_repository_impl.dart` | 메서드 구현 추가 |
| 5 | `test/data/[domain]/repository/[domain]_repository_impl_test.dart` | 테스트 케이스 추가 |

**건드리지 않는 파일:** `drift_database_service.dart`, `[domain]_table.dart`, `storage_di.dart`, `[domain]_di.dart`

> 새 컬럼이 필요한 경우: 스키마 변경이 필요하므로 사용자에게 안내하고 3B 흐름으로 전환한다. 기존 테이블을 **Read** 해 현재 필드를 파악하고 추가할 컬럼과 migration 코드를 계획으로 제시한다.

---

## 단계 3D: 통합 추가

`DriftDatabaseService` 있음 + 도메인 테이블 없음 + 다른 방식의 LocalDataSource 있음.

| # | 파일 | 수정 내용 |
|---|---|---|
| 1 | `lib/core/storage/database/drift/tables/[domain]_table.dart` | Table 신규 |
| 2 | `lib/core/storage/database/drift/drift_database_service.dart` | 테이블 추가 + `schemaVersion` +1 + migration |
| 3 | `lib/data/[domain]/datasource/local/[domain]_local_data_source.dart` | `DriftDatabaseService` 주입 추가 + Drift 메서드 추가 |
| 4 | `lib/data/[domain]/mapper/[domain]_drift_mapper.dart` | DriftMapper 신규 |
| 5 | `lib/domain/[domain]/repository/[domain]_repository.dart` | 메서드 시그니처 추가 |
| 6 | `lib/data/[domain]/repository/[domain]_repository_impl.dart` | DriftMapper 주입 + 메서드 추가 |
| 7 | `lib/app/di/[domain]_di.dart` | DataSource Provider에 `driftDatabaseService` 주입 추가 |
| 8 | `test/data/[domain]/repository/[domain]_repository_impl_test.dart` | 테스트 케이스 추가 |

> `[domain]_di.dart` **Read** → 기존 Provider 반환 타입(`Future<>` 여부) 확인 후 유지.
> ⚠️ `drift_database_service.dart` 수정 시: 기존 `onUpgrade` 블록 반드시 유지.

---

## 단계 4: 계획 제시 (승인 필요)

```
**흐름:** [신규 설정 / 테이블 신규 / DataSource 신규 / 메서드 추가 / 통합 추가]
**도메인:** [domain]
**필드:** [field: Type (DriftColumn)] ...
**CRUD:** [선택한 작업]
**schemaVersion:** [N] → [N+1]  (테이블 변경 시)

생성·수정 파일:
1. [경로] — [역할]
...

승인하시면 진행합니다.
```

**승인 후 단계 5로 진행.**

---

## 단계 5: 코드 생성

### StorageExceptionMapper (없을 때만)

`storage_exception.dart`와 `app_exception.dart`를 **Read** 해 `when()` 케이스 파악 후 작성.

```dart
import 'package:[pkg]/core/storage/common/exception/storage_exception.dart';
import 'package:[pkg]/domain/common/exception/app_exception.dart';

class StorageExceptionMapper {
  const StorageExceptionMapper();

  AppException map(StorageException exception) {
    return exception.when(
      notFound: (message) => AppException.notFound(message),
      general: (message) => AppException.unknown(message),
    );
  }
}
```

---

### Drift Table

```dart
import 'package:drift/drift.dart';

@DataClassName('[Domain]TableData')
class [Domain]Table extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  // RealColumn get score => real().nullable()();
  // BoolColumn get isActive => boolean()();
  // DateTimeColumn get createdAt => dateTime()();

  @override
  String get tableName => '[domain]';
}
```

> `@DataClassName('[Domain]TableData')` — `[Domain]Entity`와 충돌 방지.
> DB getter 이름: `[Domain]Table` → `db.[domain]Table` (camelCase 변환). 멀티 워드 도메인 예: `UserProfile` → `db.userProfileTable`.

---

### DriftDatabaseService

**신규 생성:**

```dart
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:[pkg]/core/storage/database/drift/tables/[domain]_table.dart';

part 'drift_database_service.g.dart';

@DriftDatabase(tables: [[Domain]Table])
class DriftDatabaseService extends _$DriftDatabaseService {
  DriftDatabaseService() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async => m.createAll(),
  );

  static QueryExecutor _openConnection() => driftDatabase(name: 'app_database');
}
```

**기존 파일 수정 (테이블 추가):**

단계 2에서 파악한 내용을 기반으로 수정한다.
1. import 추가: `import 'tables/[domain]_table.dart';`
2. `@DriftDatabase(tables: [..., [Domain]Table])`
3. `schemaVersion` → N+1
4. ⚠️ **기존 `onUpgrade` 블록 전체 유지 — 절대 삭제·재작성 금지. 새 블록만 마지막에 추가.**

```dart
onUpgrade: (m, from, to) async {
  // 기존 블록 그대로 유지
  if (from < 2) { await m.createTable(existingTable); }
  // 새 블록은 항상 마지막에 추가
  if (from < [N+1]) {
    await m.createTable([domain]Table);
  }
},
```

---

### LocalDataSource

선택한 CRUD 작업만 구현. 메서드 구조는 모두 동일한 try/catch 패턴이므로 `get`을 기준으로 작성한다.

```dart
import 'package:drift/drift.dart';
import 'package:[pkg]/core/storage/common/dto/storage_response.dart';
import 'package:[pkg]/core/storage/common/exception/storage_exception.dart';
import 'package:[pkg]/core/storage/database/drift/drift_database_service.dart';
import 'package:[pkg]/core/storage/database/drift/tables/[domain]_table.dart';

abstract class [Domain]LocalDataSource {
  Future<StorageResponse<[Domain]TableData>> get[Domain]({required int id});
  Future<StorageResponse<List<[Domain]TableData>>> getAll[Domain]s();
  Future<StorageResponse<void>> insert[Domain]({required [Domain]TableCompanion companion});
  Future<StorageResponse<void>> upsert[Domain]({required [Domain]TableCompanion companion});
  Future<StorageResponse<void>> delete[Domain]({required int id});
}

class [Domain]LocalDataSourceImpl implements [Domain]LocalDataSource {
  const [Domain]LocalDataSourceImpl({required this.db});
  final DriftDatabaseService db;

  @override
  Future<StorageResponse<[Domain]TableData>> get[Domain]({required int id}) async {
    try {
      final row = await (db.select(db.[domain]Table)
            ..where((t) => t.id.equals(id)))
          .getSingleOrNull();
      if (row == null) {
        return StorageResponse.failure(StorageException.notFound('[Domain] not found: $id'));
      }
      return StorageResponse.success(row);
    } catch (e) {
      return StorageResponse.failure(StorageException.general(e.toString()));
    }
  }

  @override
  Future<StorageResponse<List<[Domain]TableData>>> getAll[Domain]s() async {
    try {
      final rows = await db.select(db.[domain]Table).get();
      return StorageResponse.success(rows);
    } catch (e) {
      return StorageResponse.failure(StorageException.general(e.toString()));
    }
  }

  @override
  Future<StorageResponse<void>> insert[Domain]({required [Domain]TableCompanion companion}) async {
    try {
      await db.into(db.[domain]Table).insert(companion);
      return const StorageResponse.success(null);
    } catch (e) {
      return StorageResponse.failure(StorageException.general(e.toString()));
    }
  }

  @override
  Future<StorageResponse<void>> upsert[Domain]({required [Domain]TableCompanion companion}) async {
    try {
      await db.into(db.[domain]Table).insertOnConflictUpdate(companion);
      return const StorageResponse.success(null);
    } catch (e) {
      return StorageResponse.failure(StorageException.general(e.toString()));
    }
  }

  @override
  Future<StorageResponse<void>> delete[Domain]({required int id}) async {
    try {
      await (db.delete(db.[domain]Table)..where((t) => t.id.equals(id))).go();
      return const StorageResponse.success(null);
    } catch (e) {
      return StorageResponse.failure(StorageException.general(e.toString()));
    }
  }
}
```

---

### DriftMapper

`[domain]_entity.dart`를 **Read** 해 필드 파악 후 작성.

```dart
import 'package:drift/drift.dart';
import 'package:[pkg]/core/storage/database/drift/tables/[domain]_table.dart';
import 'package:[pkg]/domain/[domain]/entity/[domain]_entity.dart';

class [Domain]DriftMapper {
  const [Domain]DriftMapper();

  [Domain]Entity toDomain([Domain]TableData data) {
    return [Domain]Entity(
      id: data.id,
      // name: data.name,
    );
  }

  // INSERT용: autoIncrement PK는 Value.absent() (DB 자동 생성)
  [Domain]TableCompanion toInsertCompanion([Domain]Entity entity) {
    return [Domain]TableCompanion(
      // name: Value(entity.name),
    );
  }

  // UPSERT용: PK 반드시 포함 (conflict 기준 키)
  [Domain]TableCompanion toUpsertCompanion([Domain]Entity entity) {
    return [Domain]TableCompanion(
      id: Value(entity.id),
      // name: Value(entity.name),
    );
  }
}
```

---

### Repository 인터페이스 — 메서드 추가

기존 `[domain]_repository.dart`에 선택한 CRUD 시그니처 추가:

```dart
Future<AppResult<[Domain]Entity>> get[Domain]({required int id});
Future<AppResult<List<[Domain]Entity>>> getAll[Domain]s();
Future<AppResult<void>> insert[Domain]([Domain]Entity entity);
Future<AppResult<void>> upsert[Domain]([Domain]Entity entity);
Future<AppResult<void>> delete[Domain]({required int id});
```

---

### RepositoryImpl

```dart
import 'package:[pkg]/domain/common/entity/app_result.dart';
import 'package:[pkg]/domain/[domain]/entity/[domain]_entity.dart';
import 'package:[pkg]/domain/[domain]/repository/[domain]_repository.dart';
import 'package:[pkg]/data/[domain]/datasource/local/[domain]_local_data_source.dart';
import 'package:[pkg]/data/[domain]/mapper/[domain]_drift_mapper.dart';
import 'package:[pkg]/data/common/mapper/storage_exception_mapper.dart';

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
      failure: (e) => AppResult.failure(storageExceptionMapper.map(e)),
    );
  }

  @override
  Future<AppResult<List<[Domain]Entity>>> getAll[Domain]s() async {
    final response = await localDataSource.getAll[Domain]s();
    return response.when(
      success: (rows) => AppResult.success(rows.map(driftMapper.toDomain).toList()),
      failure: (e) => AppResult.failure(storageExceptionMapper.map(e)),
    );
  }

  @override
  Future<AppResult<void>> insert[Domain]([Domain]Entity entity) async {
    final response = await localDataSource.insert[Domain](
      companion: driftMapper.toInsertCompanion(entity),
    );
    return response.when(
      success: (_) => const AppResult.success(null),
      failure: (e) => AppResult.failure(storageExceptionMapper.map(e)),
    );
  }

  @override
  Future<AppResult<void>> upsert[Domain]([Domain]Entity entity) async {
    final response = await localDataSource.upsert[Domain](
      companion: driftMapper.toUpsertCompanion(entity),
    );
    return response.when(
      success: (_) => const AppResult.success(null),
      failure: (e) => AppResult.failure(storageExceptionMapper.map(e)),
    );
  }

  @override
  Future<AppResult<void>> delete[Domain]({required int id}) async {
    final response = await localDataSource.delete[Domain](id: id);
    return response.when(
      success: (_) => const AppResult.success(null),
      failure: (e) => AppResult.failure(storageExceptionMapper.map(e)),
    );
  }
}
```

---

### DI

**storage_di.dart** — `driftDatabaseServiceProvider` 없으면 Read 후 추가:

```dart
@Riverpod(keepAlive: true)
DriftDatabaseService driftDatabaseService(DriftDatabaseServiceRef ref) {
  return DriftDatabaseService();  // sync — Future<> 불필요
}
```

**[domain]_di.dart — Provider 타입 선택 기준:**

| DataSource 생성자에 필요한 의존성 | Provider 타입 |
|---|---|
| `DriftDatabaseService`만 (sync Provider) | sync — `[Domain]LocalDataSource [domain]LocalDataSource(...)` |
| Prefs / SecureStorage 포함 (async Provider) | **async** — `Future<[Domain]LocalDataSource> [domain]LocalDataSource(...) async` |

> 기존 `[domain]_di.dart`가 있으면 **Read** → 현재 반환 타입 확인 후 유지. 타입 변경 시 이를 read하는 Provider도 함께 수정 필요.

**케이스 A — Drift 단독 (sync):**

```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:[pkg]/app/di/storage_di.dart';
import 'package:[pkg]/data/[domain]/datasource/local/[domain]_local_data_source.dart';
import 'package:[pkg]/data/[domain]/mapper/[domain]_drift_mapper.dart';
import 'package:[pkg]/data/[domain]/repository/[domain]_repository_impl.dart';
import 'package:[pkg]/data/common/mapper/storage_exception_mapper.dart';
import 'package:[pkg]/domain/[domain]/repository/[domain]_repository.dart';

part '[domain]_di.g.dart';

@Riverpod(keepAlive: true)
[Domain]LocalDataSource [domain]LocalDataSource([Domain]LocalDataSourceRef ref) {
  return [Domain]LocalDataSourceImpl(
    driftDatabaseService: ref.read(driftDatabaseServiceProvider),
  );
}

@Riverpod(keepAlive: true)
[Domain]Repository [domain]Repository([Domain]RepositoryRef ref) {
  return [Domain]RepositoryImpl(
    localDataSource: ref.read([domain]LocalDataSourceProvider),
    driftMapper: const [Domain]DriftMapper(),
    storageExceptionMapper: const StorageExceptionMapper(),
  );
}
```

> sync Provider → Effect에서 `ref.read([domain]RepositoryProvider)` 직접 사용 (`.future` 불필요).

**케이스 B — Drift + Prefs/SecureStorage 조합 (async):**

Prefs(`preferencesServiceProvider`)·SecureStorage(`secureStorageServiceProvider`)는 `Future<>` Provider이므로,  
DataSource Provider도 `async`로 선언해야 한다.

```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:[pkg]/app/di/storage_di.dart';
import 'package:[pkg]/data/[domain]/datasource/local/[domain]_local_data_source.dart';
import 'package:[pkg]/data/[domain]/mapper/[domain]_drift_mapper.dart';
import 'package:[pkg]/data/[domain]/repository/[domain]_repository_impl.dart';
import 'package:[pkg]/data/common/mapper/storage_exception_mapper.dart';
import 'package:[pkg]/domain/[domain]/repository/[domain]_repository.dart';

part '[domain]_di.g.dart';

@Riverpod(keepAlive: true)
Future<[Domain]LocalDataSource> [domain]LocalDataSource(
    [Domain]LocalDataSourceRef ref) async {
  final prefs = await ref.read(preferencesServiceProvider.future);
  // final secureStorage = ref.read(secureStorageServiceProvider); // 필요 시
  final driftDb = ref.read(driftDatabaseServiceProvider);
  return [Domain]LocalDataSourceImpl(
    preferencesService: prefs,
    driftDatabaseService: driftDb,
  );
}

@Riverpod(keepAlive: true)
Future<[Domain]Repository> [domain]Repository([Domain]RepositoryRef ref) async {
  return [Domain]RepositoryImpl(
    localDataSource: await ref.read([domain]LocalDataSourceProvider.future),
    driftMapper: const [Domain]DriftMapper(),
    storageExceptionMapper: const StorageExceptionMapper(),
  );
}
```

> async Provider → Effect에서 `await ref.read([domain]RepositoryProvider.future)` 사용.  
> UseCase DI도 동일하게 `Future<UseCase>`로 선언하고 `.overrideWith((_) async => fakeUseCase)`로 테스트 오버라이드.

---

### 테스트

`[domain]_entity.dart`와 `[domain]_table.dart`를 **Read** 해 실제 필드 파악 후 작성.

```dart
import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:[pkg]/core/storage/common/dto/storage_response.dart';
import 'package:[pkg]/core/storage/common/exception/storage_exception.dart';
import 'package:[pkg]/core/storage/database/drift/tables/[domain]_table.dart';
import 'package:[pkg]/data/[domain]/datasource/local/[domain]_local_data_source.dart';
import 'package:[pkg]/data/[domain]/mapper/[domain]_drift_mapper.dart';
import 'package:[pkg]/data/[domain]/repository/[domain]_repository_impl.dart';
import 'package:[pkg]/data/common/mapper/storage_exception_mapper.dart';
import 'package:[pkg]/domain/[domain]/entity/[domain]_entity.dart';
import 'package:[pkg]/domain/common/entity/app_result.dart';
import '[domain]_repository_impl_test.mocks.dart';

@GenerateMocks([[Domain]LocalDataSource])
void main() {
  late [Domain]RepositoryImpl repository;
  late Mock[Domain]LocalDataSource mockLocalDataSource;

  setUp(() {
    // Freezed sealed class 반환 타입 — MissingDummyValueError 방지
    provideDummy<StorageResponse<[Domain]TableData>>(
      StorageResponse.success([Domain]TableData(id: 0 /* Read로 파악한 실제 필드 채울 것 */)),
    );
    provideDummy<StorageResponse<List<[Domain]TableData>>>(
      const StorageResponse.success([]),
    );
    provideDummy<StorageResponse<void>>(const StorageResponse.success(null));

    mockLocalDataSource = Mock[Domain]LocalDataSource();
    repository = [Domain]RepositoryImpl(
      localDataSource: mockLocalDataSource,
      driftMapper: const [Domain]DriftMapper(),
      storageExceptionMapper: const StorageExceptionMapper(),
    );
  });

  // 실제 필드로 채울 것
  const testId = 1;
  final testData = [Domain]TableData(id: testId);
  final testEntity = [Domain]Entity(id: testId);

  group('get[Domain]', () {
    test('성공 시 AppSuccess와 Entity 반환', () async {
      when(mockLocalDataSource.get[Domain](id: testId))
          .thenAnswer((_) async => StorageResponse.success(testData));

      final result = await repository.get[Domain](id: testId);

      result.when(
        success: (entity) => expect(entity, testEntity),
        failure: (_) => fail('success 기대'),
      );
    });

    test('항목 없을 때 AppFailure 반환', () async {
      when(mockLocalDataSource.get[Domain](id: testId)).thenAnswer(
        (_) async => StorageResponse.failure(
          StorageException.notFound('[Domain] not found: $testId'),
        ),
      );

      final result = await repository.get[Domain](id: testId);
      expect(result, isA<AppFailure<[Domain]Entity>>());
    });
  });

  // 나머지 CRUD (insert / upsert / delete): 같은 success/failure 패턴으로 작성
  // - 성공: thenAnswer((_) async => const StorageResponse.success(null))
  // - 실패: thenAnswer((_) async => StorageResponse.failure(StorageException.general('...')))
}
```

---

## 단계 6: build_runner

Table 정의 또는 DI 파일 변경 시 실행:

```bash
dart run build_runner build --delete-conflicting-outputs
```

확인: `drift_database_service.g.dart` / `[domain]_di.g.dart` / `[domain]_repository_impl_test.mocks.dart`

---

## 단계 7: 검증

```bash
flutter analyze
flutter test test/data/[domain]/repository/[domain]_repository_impl_test.dart
```

체크리스트:
- `StorageResponse`·`StorageException`이 Repository 외부로 노출되지 않음
- `[Domain]TableData`가 data 레이어 외부로 직접 노출되지 않음
- 모든 `StorageResponse.when()` success/failure 처리
- `maybeWhen()` 미사용
- `keepAlive: true` Provider에서 `ref.read` 사용
- 신규 DI 파일이면 `di.dart`에 export 추가 확인
- `@DriftDatabase(tables:[...])` 에 신규 테이블 포함 확인
- 테이블 변경 시 `schemaVersion` 증가 확인
- 기존 `onUpgrade` 블록 누락 없이 유지됐는지 확인

---

## 완료 보고

```
**흐름:** [신규 설정 / 테이블 신규 / DataSource 신규 / 메서드 추가 / 통합 추가]
**도메인:** [domain]

생성·수정된 파일:
- [경로] — [역할]

다음 단계 (테이블 변경 시):
- schemaVersion [N] → [N+1] 적용됨
- build_runner 실행 후 앱 첫 실행 시 migration 자동 적용
```

---

## 금지 사항

- 사용자 승인 없이 파일 생성·수정 금지
- `DriftDatabaseService`를 ViewModel·UseCase에서 직접 참조하도록 구현 금지
- `[Domain]TableData`를 Repository 외부로 직접 노출 금지 (Mapper로 변환)
- `DataSource`에서 `StorageResponse → AppResult` 변환 금지
- `StorageExceptionMapper` 없이 `StorageException` 직접 변환 금지
- `maybeWhen()` 사용 금지
- `keepAlive: true` Provider에서 `ref.watch` 사용 금지
- 기존 `onUpgrade` 블록 삭제·재작성 금지 (데이터 손실)
- 테이블 신규 컬럼 추가 시 migration 없이 진행 금지
- `upsert`용 Companion에서 PK(`id`) 생략 금지
- `core/storage/database/drift/tables/` 외 위치에 Table 파일 생성 금지
