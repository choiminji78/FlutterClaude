---
name: add-entity
description: This skill should be used when the user asks to "엔티티 추가", "entity 만들어줘", "엔티티 생성", "add-entity", or requests to create a new Entity in the domain layer.
argument-hint: "[entity 이름 (예: user, user_profile, order_item)]"
---

# Add Entity

`domain/[domain]/entity/`에 Freezed data class Entity를 생성하고 build_runner로 코드를 생성한다.

---

## 흐름 유형

`$ARGUMENTS`와 기존 파일 상태에 따라 두 가지 흐름 중 하나를 선택한다.

| 흐름 | 조건 | 진행 |
|---|---|---|
| **흐름 A: 신규 Entity 생성** | 해당 Entity 파일이 존재하지 않음 | 단계 0 → 1 → 2 → 3 → [3-A: enum 있을 때만] → 4 → 5 → 6 |
| **흐름 B: 기존 Entity 필드 추가** | 해당 Entity 파일이 이미 존재함 | 단계 0 → 1 → 2(기존 파일 Read) → 3-B → 5 → 6 |

흐름 B는 단계 2에서 파일이 이미 존재한다는 것을 확인한 시점에 분기한다.

---

## 단계 0: 기반 파일 사전 확인

Glob으로 아래 파일의 존재 여부를 확인한다.

```
lib/domain/common/entity/app_result.dart
lib/domain/common/exception/app_exception.dart
```

| 파일 | 없을 때 대응 |
|---|---|
| `app_result.dart` / `app_exception.dart` | "AppResult/AppException이 없습니다. `/init-project`로 프로젝트 기반 구조를 먼저 생성해 주세요." 안내 후 중단 |

모두 존재하면 단계 1로 이동.

---

## 단계 1: 파일명·도메인 결정

패턴: `[name]_entity.dart` → 클래스 `[Name]Entity`, 위치 `domain/[domain]/entity/`

**`$ARGUMENTS` 있는 경우** — 아래 규칙으로 해석한다.

| 입력 예시 | Entity명 | 도메인 디렉토리 후보 |
|---|---|---|
| `user` | `UserEntity` | `user/` |
| `user_profile` | `UserProfileEntity` | `user/` 또는 `profile/` — 사용자에게 확인 |
| `order_item` | `OrderItemEntity` | `order/` 또는 `item/` — 사용자에게 확인 |

단어가 2개 이상이면 Glob으로 `lib/domain/*/` 기존 도메인 목록을 확인한 뒤 가장 가능성 높은 후보를 제시하고 사용자가 확정.

> **공유 Entity 판단**: `Money`, `Address`, `DateRange`처럼 2개 이상의 도메인에서 동시에 사용될 것이 명확한 경우 → `domain/common/entity/`에 위치시킨다. 불명확하면 사용자에게 확인.

**`$ARGUMENTS` 없는 경우** — Entity가 표현하는 개념과 속할 도메인을 질문 후 확정.

---

## 단계 2: 기존 구조 확인

Glob으로 중복 여부를 확인한다.

```
lib/domain/[domain]/entity/[name]_entity.dart
```

| 상태 | 대응 |
|---|---|
| 이미 존재 | "동일한 Entity가 있습니다. 필드를 추가할까요, 덮어쓸까요?" 확인 후 분기 — 필드 추가면 **흐름 B**로, 덮어쓰기면 **흐름 A**로 |
| 없음 (도메인 디렉토리 있음) | 다음 단계로 |
| 없음 (도메인 디렉토리 없음) | "새 도메인 디렉토리 `domain/[domain]/`를 생성합니다." 안내 후 진행 |

---

## 단계 3: 필드 파악

아래를 한 번에 질문한다.

- **필드 목록**: 이름·타입·required 여부 (예: `id: String`, `status: UserStatus`, `tags: List<String> 기본값 []`, `avatarUrl: String?`)
- **enum 필드가 있으면**: 이름·값 목록, 이 도메인 전용인지 공유(2개 이상 도메인) 여부
- **커스텀 메서드**: `copyWith` 외 getter나 메서드 필요 여부

> `fromJson`/`toJson`은 Entity에 포함하지 않는다 — DTO+Mapper 담당.
> 다른 도메인 Entity를 필드로 참조할 경우 `domain/common/entity/` 이동을 먼저 검토한다.

---

## 단계 3-B: 기존 Entity 필드 추가 (흐름 B)

> 이 단계는 흐름 B에서만 실행한다.

### 3-B-1: 기존 파일 Read

```
lib/domain/[domain]/entity/[name]_entity.dart
```

기존 필드 목록·커스텀 메서드 유무·enum 참조 여부를 파악한다.

### 3-B-2: 추가 필드 파악

아래를 한 번에 질문한다.

- **추가할 필드 목록**: 이름·타입·required 여부
- **enum 필드가 있으면**: 신규 enum인지, 기존 enum 재사용인지
- **커스텀 메서드 변경**: 추가·수정·삭제 여부

### 3-B-3: 수정 계획 제시

> 추가할 필드에 신규 enum이 필요한 경우, 3-B-4 수정 전에 **단계 3-A**의 enum 파일 생성을 먼저 완료한다.

수정할 내용을 먼저 제시하고 사용자 확인 후 진행한다.

```
수정 파일:
  lib/domain/[domain]/entity/[name]_entity.dart — [추가 필드 목록]

신규 생성 파일 (해당 시):
  lib/domain/[domain]/enum/[name].dart — 새 enum

영향받는 파일 안내:
  Repository 구현체가 있다면 Mapper 수정이 필요할 수 있습니다.
    → lib/data/[domain]/mapper/[domain]_mapper.dart 확인 권장
  DTO가 있다면 서버 응답 필드와 매핑을 확인해 주세요.
    → lib/data/[domain]/dto/response/[domain]_response_dto.dart 확인 권장
  서버 응답에 새 필드가 추가되어 DTO도 변경이 필요하다면, 이후 `/add-remote-datasource`로 DTO·Mapper를 업데이트하세요.
```

### 3-B-4: 파일 수정

기존 `const factory [Name]Entity({...})` 블록에 새 필드를 추가한다.

- `required` 필드 추가 시: 기존 `[Name]Entity(...)` 호출부 전체에 컴파일 오류 발생 — 사용자에게 미리 안내한다.
- `@Default(...)` 또는 nullable(`?`) 필드 추가 시: 기존 호출부 변경 불필요.

커스텀 메서드를 새로 추가하는 경우 `const [Name]Entity._()` private 생성자 유무를 확인하고 없으면 추가한다.

흐름 B 완료 후 단계 5(build_runner)로 이동한다.

---

## 단계 3-A: enum 처리 (enum 필드가 있는 경우만)

Glob으로 중복 여부를 먼저 확인한다.

```
lib/domain/[domain]/enum/[name].dart      ← 도메인 전용
lib/domain/common/enum/[name].dart        ← 공유
```

| 상태 | 대응 |
|---|---|
| 이미 존재 | "동일한 enum이 있습니다. 덮어쓸까요?" 확인 후 진행 |
| 없음 | 새로 생성 |

| 사용 범위 | 위치 |
|---|---|
| 이 도메인 전용 | `domain/[domain]/enum/[name].dart` |
| 2개 이상 도메인에서 공유 | `domain/common/enum/[name].dart` |

```dart
// [name].dart — Freezed 불필요, part 선언 없음
enum [Name] {
  [value1],
  [value2],
}
```

---

## 단계 4: 코드 생성

> **흐름 B에서는 이 단계를 건너뛴다.** 파일 수정은 단계 3-B-4에서 완료된다.

생성 파일 목록을 제시하고 사용자 확인 후 작성한다.

```
[흐름 A — 신규 생성]
lib/domain/[domain]/enum/[name].dart                   ← enum (enum 필드가 있을 때만)
lib/domain/[domain]/entity/[name]_entity.dart          ← Entity 본체
test/domain/[domain]/entity/[name]_entity_test.dart    ← 테스트 (커스텀 메서드가 있을 때만)

[흐름 B — 기존 수정]
lib/domain/[domain]/entity/[name]_entity.dart          ← 필드 추가 (수정)
lib/domain/[domain]/enum/[name].dart                   ← 새 enum (해당 시 신규 생성)
test/domain/[domain]/entity/[name]_entity_test.dart    ← 테스트 (커스텀 메서드 추가 시만)
```

### Entity — 기본형

```dart
import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:flutter_claude/domain/[domain]/enum/[name].dart'; ← enum 필드가 있으면

part '[name]_entity.freezed.dart';

@freezed
class [Name]Entity with _$[Name]Entity {
  const factory [Name]Entity({
    required String id,
    // @Default([]) List<String> tags,  ← 기본값 있는 컬렉션
    // String? nullableField,           ← nullable
  }) = _[Name]Entity;
}
```

### Entity — 커스텀 메서드 포함형

`const [Name]Entity._()` 없으면 Freezed 클래스에 메서드를 추가할 수 없다.

```dart
import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:flutter_claude/domain/[domain]/enum/[name].dart'; ← enum 필드가 있으면

part '[name]_entity.freezed.dart';

@freezed
class [Name]Entity with _$[Name]Entity {
  const [Name]Entity._();

  const factory [Name]Entity({
    required String id,
  }) = _[Name]Entity;

  bool get isValid => id.isNotEmpty;
}
```

> 중첩 Entity 필드가 있거나 non-const 기본값이 있으면 `const factory` 앞의 `const`를 제거한다.

### 테스트 (커스텀 메서드가 있을 때만)

`copyWith` / `==` / `hashCode`는 Freezed 보장 범위 — 테스트 대상 아님.

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_claude/domain/[domain]/entity/[name]_entity.dart';

void main() {
  group('[Name]Entity', () {
    test('[성공 케이스 설명]', () {
      final entity = const [Name]Entity(id: 'test-id');
      expect(entity.[method], [expected]);
    });

    test('[실패 케이스 설명]', () {
      final entity = const [Name]Entity(id: '');
      expect(entity.[method], [expected]);
    });
  });
}
```

---

## 단계 5: build_runner

```bash
dart run build_runner build --delete-conflicting-outputs
```

`[name]_entity.freezed.dart`가 변경 파일에 포함됐는지 확인한다.

---

## 단계 6: 검증

```bash
flutter analyze
flutter test test/domain/[domain]/entity/[name]_entity_test.dart  ← 테스트 파일이 있을 때만
```

- Entity import: `freezed_annotation` + domain enum만 허용. `data` / `feature` / `app` / Riverpod 없음.
- `fromJson` / `toJson` 미포함
- 커스텀 메서드 없이 private 생성자가 추가되지 않았는지 확인

---

## 금지

- Entity에 `fromJson` / `toJson` 직접 추가
- Entity에 Riverpod(`ref`, `Provider`) 참조
- Entity에 `ApiResponse` / `StorageResponse` / `NetworkException` / `AppResult` import
- 커스텀 메서드 없이 `const [Name]Entity._()` 추가
- `copyWith` / `==` / `hashCode` 테스트 작성
- 사용자 확인 없이 기존 파일 수정
- 흐름 B에서 `required` 필드 추가 시 기존 호출부 파급 효과를 사용자에게 안내하지 않고 수정
- 흐름 B에서 Mapper·DTO 영향 확인 없이 Entity 필드만 수정하고 종료
