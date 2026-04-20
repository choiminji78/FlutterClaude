---
name: add-repository
description: This skill should be used when the user asks to "리포지토리 추가", "repository 만들어줘", "리포지토리 인터페이스 생성", "add-repository", or requests to create a new Repository interface in the domain layer.
argument-hint: "[domain 이름 (예: user, product, order)]"
---

# Add Repository

`domain/[domain]/repository/`에 Repository 추상 인터페이스를 생성한다.

---

## 흐름 유형

`$ARGUMENTS`와 기존 파일 상태에 따라 두 가지 흐름 중 하나를 선택한다.

| 흐름 | 조건 | 진행 |
|---|---|---|
| **흐름 A: 신규 Repository 생성** | 해당 Repository 파일이 존재하지 않음 | 단계 0 → 1 → 2 → 3 → 4 → 5 |
| **흐름 B: 기존 Repository 메서드 추가** | 해당 Repository 파일이 이미 존재함 | 단계 0 → 1 → 2(기존 파일 Read) → 3-B → 5 |

흐름 B는 단계 2에서 파일이 이미 존재한다는 것을 확인한 시점에 분기한다.

---

## 단계 0: domain/common 사전 확인

`.claude/docs/domain-common-bootstrap.md` 를 Read한 뒤 지침대로 수행한다.

---

## 단계 1: 파일명·도메인 결정

패턴: `[domain]_repository.dart` → 클래스 `[Domain]Repository`, 위치 `domain/[domain]/repository/`

**`$ARGUMENTS` 있는 경우** — domain 이름으로 해석.

**`$ARGUMENTS` 없는 경우** — 어떤 도메인의 Repository인지 질문.

---

## 단계 2: 기존 구조 확인

Glob으로 아래 두 경로를 확인한다.

```
lib/domain/[domain]/entity/*_entity.dart             ← Entity 파일 존재 여부
lib/domain/[domain]/repository/[domain]_repository.dart  ← 중복 여부
```

| 상태 | 대응 |
|---|---|
| Entity 없음 | "Entity가 없습니다. `/add-entity`로 먼저 생성해 주세요." |
| Entity 1개 | 해당 Entity 파일을 **Read** 해 필드를 파악한 뒤 반환 타입 후보로 제시 |
| Entity 2개 이상 | 각 Entity 파일을 **Read** 해 필드를 파악한 뒤, 목록 보여주고 "메서드별 반환 Entity를 선택해 주세요." |
| Repository 이미 존재 | "동일한 Repository가 있습니다. 메서드를 추가할까요, 덮어쓸까요?" 확인 후 분기 — 메서드 추가면 **흐름 B**로, 덮어쓰기면 **흐름 A**로 |
| 모두 정상 | 다음 단계로 |

---

## 단계 3: 메서드 파악

아래를 한 번에 질문한다.

- **메서드 목록**: 이름·파라미터·반환 Entity 타입
  - 예: `getUser(id: String) → AppResult<UserEntity>`
  - 예: `getUsers() → AppResult<List<UserEntity>>`
  - 예: `createUser(name: String, email: String) → AppResult<UserEntity>`
  - 예: `updateUser(entity: UserEntity) → AppResult<void>`
  - 예: `deleteUser(id: String) → AppResult<void>`

> 파라미터는 primitive type 또는 Entity만 허용. DTO 파라미터 절대 금지.
> 반환 타입: 비동기 작업(API 호출, SecureStorage, Drift 등)은 `Future<AppResult<T>>`. SharedPreferences 읽기처럼 인스턴스 초기화 후 동기 호출이 가능한 경우는 `AppResult<T>` 허용. (AppResult는 domain/common/entity에서 import)

---

## 단계 3-B: 기존 Repository 메서드 추가 (흐름 B)

> 이 단계는 흐름 B에서만 실행한다.

### 3-B-1: 기존 파일 Read

```
lib/domain/[domain]/repository/[domain]_repository.dart
```

기존 메서드 시그니처 전체를 파악한다.

### 3-B-2: 추가 메서드 파악

단계 3의 "메서드 파악" 질문 항목과 동일하게 추가할 메서드 목록·파라미터·반환 타입을 한 번에 질문한다.

### 3-B-3: 수정 계획 제시

수정할 내용을 먼저 제시하고 사용자 확인 후 진행한다.

```
수정 파일:
  lib/domain/[domain]/repository/[domain]_repository.dart — [추가 메서드 목록]

구현체 업데이트 필요 안내:
  Repository 인터페이스에 메서드가 추가되면 모든 구현체에서 해당 메서드를 구현해야 합니다.
  Glob으로 구현체 목록을 먼저 확인한다:
    lib/data/[domain]/repository/*_impl.dart
  발견된 모든 구현체에 메서드를 추가해야 합니다:
    → (Glob 결과 목록 전체 열거)
  구현체를 업데이트하지 않으면 즉시 컴파일 오류가 발생합니다.
  Claude가 함께 처리할까요, 직접 처리하시겠습니까?
```

### 3-B-4: 파일 수정

기존 `abstract class [Domain]Repository { ... }` 블록 끝에 새 메서드 시그니처를 추가한다.

흐름 B 완료 후 단계 5(검증)로 이동한다.

---

## 단계 4: 코드 생성

> **흐름 B에서는 이 단계를 건너뛴다.** 파일 수정은 단계 3-B-4에서 완료된다.

생성 파일 목록을 제시하고 사용자 확인 후 작성한다.

```
[흐름 A — 신규 생성]
lib/domain/[domain]/repository/[domain]_repository.dart

[흐름 B — 기존 수정]
lib/domain/[domain]/repository/[domain]_repository.dart  ← 메서드 추가 (수정)
```

### Repository 인터페이스

```dart
import 'package:flutter_claude/domain/common/entity/app_result.dart';
import 'package:flutter_claude/domain/[domain]/entity/[domain]_entity.dart';
// 반환 타입이 다른 Entity면 추가 import

abstract class [Domain]Repository {
  Future<AppResult<[Domain]Entity>> get[Domain]({required String id});
  Future<AppResult<List<[Domain]Entity>>> get[Domain]s();
  Future<AppResult<[Domain]Entity>> create[Domain]({
    required String [param1],
    required String [param2],
  });
  Future<AppResult<void>> update[Domain]({required [Domain]Entity entity});
  Future<AppResult<void>> delete[Domain]({required String id});
}
```

> `Future<AppResult<void>>`는 write 작업(create/update/delete)의 성공·실패만 전달할 때 사용.
> 메서드가 1개라도 `abstract class`로 선언 — Repository는 항상 인터페이스.

---

> Repository 인터페이스만 생성됩니다. 구현체와 DI 등록은 다음 스킬을 사용하세요.
> - API 연동이 필요하면: `/add-remote-datasource`
> - 로컬 저장소가 필요하면: `/add-local-datasource`

---

## 단계 5: 검증

```bash
flutter analyze
```

- `domain/common/entity/app_result.dart` + `domain/[domain]/entity/` 만 import 허용
- `data` / `feature` / `app` / Riverpod import 없음
- `@freezed` / `fromJson` / `toJson` 없음 — 순수 abstract class

---

## 금지

- Repository 인터페이스에 Riverpod(`ref`, `Provider`) 참조
- Repository 인터페이스에 DTO 파라미터
- `ApiResponse` / `StorageResponse` / `NetworkException` import
- 메서드 구현체 작성 — 인터페이스 선언만
- 사용자 확인 없이 기존 파일 수정
- 흐름 B에서 인터페이스 메서드 추가 후 구현체 업데이트 필요 여부를 사용자에게 안내하지 않고 종료
- 흐름 B에서 기존 메서드를 Read하지 않고 덮어쓰기
