---
name: add-usecase
description: This skill should be used when the user asks to "유스케이스 추가", "usecase 만들어줘", "유스케이스 생성", "add-usecase", or requests to create a new UseCase in the domain layer.
argument-hint: "[verb_domain 형태 파일명 (예: get_user, validate_password)]"
---

# Add UseCase

`domain/[domain]/usecase/`에 UseCase를 생성하고 DI 등록과 테스트 파일까지 구성한다.

> 레이어 의존 규칙·경로 A/B 판단 기준·DI 스코프 → `.claude/docs/architecture-detail.md`
> 파일명·클래스명 패턴 전체 → `.claude/docs/naming-detail.md`
> 테스트 패턴 → `.claude/docs/testing-detail.md`

---

## 단계 0: domain/common 사전 확인

`.claude/docs/domain-common-bootstrap.md` 를 Read한 뒤 지침대로 수행한다.

---

## 단계 1: 파일명·도메인 결정

패턴: `[verb]_[domain]_usecase.dart` → 클래스 `[Verb][Domain]UseCase`, 위치 `domain/[domain]/usecase/`

**`$ARGUMENTS` 있는 경우** — `[verb]_[domain]` 형태로 해석. 도메인 디렉토리가 불명확하면 확인.

**`$ARGUMENTS` 없는 경우** — 수행 동작·대상 Entity를 질문 → 후보 1~3개 추천 후 확정.

동사 후보: `get`/`fetch`(조회) | `create`/`add`(생성) | `update`(수정) | `delete`/`remove`(삭제) | `validate`/`verify`(검증) | `calculate`/`compute`(계산) | `convert`(변환)

---

## 단계 2: UseCase 유형 분류

불명확하면 사용자에게 질문한다.

**유형 A — Repository 주입형:** Repository에서 데이터를 읽거나 쓸 때. 주입할 Repository 이름과 반환 Entity 타입을 파악한다.

> UseCase를 만드는 기준과 경로 B 허용 조건은 `architecture-detail.md` `Effect 경로` 섹션 참조.
> Repository 1개 + 비즈니스 로직 없음 → 경로 B(Effect 직접 호출)가 더 적합할 수 있다. 사용자에게 확인한다.

**유형 B — 순수 비즈니스 로직형:** Repository 없이 검증·변환·계산만 수행할 때. 동기 함수가 일반적.

---

## 단계 2-A: 기존 구조 확인 (유형 A만)

유형 A인 경우, Glob으로 아래 파일 존재 여부를 확인한다.

```
lib/domain/[domain]/entity/*.dart                          ← Entity 존재 여부 (복수 가능)
lib/domain/[domain]/repository/[domain]_repository.dart
lib/domain/[domain]/usecase/[verb]_[domain]_usecase.dart  ← 중복 여부
```

| 상태 | 대응 |
|---|---|
| Entity 없음 또는 Repository 없음 | "먼저 생성이 필요합니다. 지금 만들까요, 아니면 경로를 알려주세요." |
| Entity가 1개 | 해당 Entity를 반환 타입으로 사용 |
| Entity가 2개 이상 | 목록을 보여주고 "UseCase가 반환할 Entity를 선택해 주세요." |
| UseCase 이미 존재 | "동일한 UseCase가 있습니다. 덮어쓸까요?" 확인 후 진행 |
| 모두 존재 | 다음 단계로 |

유형 B는 이 단계를 건너뛴다.

---

## 단계 3: 코드 생성

생성 파일 목록을 먼저 제시하고 사용자 확인 후 작성한다.

```
lib/domain/[domain]/usecase/[verb]_[domain]_usecase.dart      ← UseCase 본체
lib/app/di/[domain]_di.dart                                    ← Provider 추가 (없으면 신규 + di.dart export)
test/domain/[domain]/usecase/[verb]_[domain]_usecase_test.dart ← 테스트
```

### UseCase — 유형 A

```dart
import 'package:flutter_claude/domain/common/entity/app_result.dart';
import 'package:flutter_claude/domain/[domain]/entity/[domain]_entity.dart';
import 'package:flutter_claude/domain/[domain]/repository/[domain]_repository.dart';
// Repository 복수면 추가 import

class [Verb][Domain]UseCase {
  const [Verb][Domain]UseCase(this._repository);
  // Repository 복수면: const [Verb][Domain]UseCase(this._[domain1]Repository, this._[domain2]Repository);

  final [Domain]Repository _repository;

  // 파라미터 없는 경우: call() {} 로 작성
  Future<AppResult<[Domain]Entity>> call({required [Type] [param]}) async {
    // Repository 1개
    return _repository.[method]([param]);
    // Repository 복수 조합:
    // final r = await _[domain1]Repository.[method1]([param]);
    // return r.when(
    //   success: (data) async => await _[domain2]Repository.[method2](data),
    //   failure: (f) async => AppResult.failure(f),
    // );
  }
}
```

### UseCase — 유형 B

```dart
import 'package:flutter_claude/domain/common/entity/app_result.dart';
import 'package:flutter_claude/domain/common/exception/app_exception.dart';

class [Verb][Domain]UseCase {
  const [Verb][Domain]UseCase();

  AppResult<[ReturnType]> call({required [Params] params}) {
    if ([실패 조건]) {
      return AppResult.failure(AppException.[type]('[메시지]'));
    }
    return AppResult.success([결과]);
  }
}
```

### DI Provider

> **기존 파일 수정 전 필수**: `[domain]_di.dart`가 이미 존재하면 반드시 **Read** 해 현재 Provider 목록(DataSource·Repository 등)을 파악한 뒤 UseCase Provider를 추가한다. 기존 Provider를 덮어쓰지 않도록 주의한다.

`@Riverpod(keepAlive: true)`. 등록 순서: DataSource → Repository → UseCase.

```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_claude/domain/[domain]/usecase/[verb]_[domain]_usecase.dart';
// 유형 A만: Repository import
import 'package:flutter_claude/domain/[domain]/repository/[domain]_repository.dart';

part '[domain]_di.g.dart';
```

**Repository Provider가 동기(`[Domain]Repository`)인 경우:**

```dart
@Riverpod(keepAlive: true)
[Verb][Domain]UseCase [verb][Domain]UseCase([Verb][Domain]UseCaseRef ref) {
  return [Verb][Domain]UseCase(
    ref.read([domain]RepositoryProvider), // 유형 B는 인자 없이 const
  );
}
```

**Repository Provider가 비동기(`Future<[Domain]Repository>`)인 경우** — SharedPreferences처럼 async init이 체인에 있을 때:

```dart
@Riverpod(keepAlive: true)
Future<[Verb][Domain]UseCase> [verb][Domain]UseCase([Verb][Domain]UseCaseRef ref) async {
  final repo = await ref.read([domain]RepositoryProvider.future);
  return [Verb][Domain]UseCase(repo); // 유형 B는 const [Verb][Domain]UseCase()
}
```

> Repository Provider의 반환 타입을 **반드시 확인**한다. `[domain]_di.dart`를 **Read** 해 `Future<[Domain]Repository>`이면 async Provider로, `[Domain]Repository`이면 sync Provider로 작성한다. 타입 불일치는 컴파일 에러를 유발한다.

### 테스트

> `.claude/docs/testing-detail.md` **UseCase 테스트** 섹션 참조.

- 유형 A: `Mock[Domain]Repository` 생성 → 성공/실패 케이스
- 유형 B: `const [Verb][Domain]UseCase()` → 유효/무효 입력 케이스

---

## 단계 4: build_runner

```bash
dart run build_runner build --delete-conflicting-outputs
```

`[domain]_di.g.dart`(DI)와 `[verb]_[domain]_usecase_test.mocks.dart`(테스트 mock)가 변경 파일에 포함됐는지 확인한다.

---

## 단계 5: 검증

```bash
flutter analyze
flutter test test/domain/[domain]/usecase/[verb]_[domain]_usecase_test.dart
```

- UseCase import에 `data` / `feature` / `app` 없음
- UseCase 본체에 Riverpod 참조 없음
- 신규 `[domain]_di.dart`면 `di.dart` export 추가 여부

---

## 금지

- UseCase 본체에 `ref` / `Provider` 참조
- `StorageResponse` / `ApiResponse` / `NetworkException` 직접 import
- 사용자 확인 없이 기존 파일 수정
