import 'dart:async';

import 'package:flutter_claude/app/di/contact_di.dart';
import 'package:flutter_claude/domain/common/entity/app_result.dart';
import 'package:flutter_claude/domain/common/exception/app_exception.dart';
import 'package:flutter_claude/domain/contact/entity/contact_entity.dart';
import 'package:flutter_claude/domain/contact/usecase/load_contact_from_prefs_usecase.dart';
import 'package:flutter_claude/domain/contact/usecase/save_contact_to_prefs_usecase.dart';
import 'package:flutter_claude/feature/contact_input/action/contact_input_action.dart';
import 'package:flutter_claude/feature/contact_input/effect/contact_input_effect.dart';
import 'package:flutter_claude/feature/contact_input/state/contact_input_state.dart';
import 'package:flutter_claude/feature/contact_input/viewmodel/contact_input_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

// ── guard flag 테스트용: ProviderContainer에서 Ref를 꺼내기 위한 전용 Provider ──
// Provider (not AutoDispose) 이므로 container 소멸 전까지 ref가 유효하다.
final _testRefProvider = Provider<Ref>((ref) => ref);

// ── Fake UseCase ──────────────────────────────────────────────────────────────

class _FakeSaveToPrefsUseCase extends Fake implements SaveContactToPrefsUseCase {
  final AppResult<void> _result;
  int callCount = 0;

  _FakeSaveToPrefsUseCase(this._result);

  @override
  Future<AppResult<void>> call(ContactEntity entity) async {
    callCount++;
    return _result;
  }
}

/// guard flag 검증용: Completer가 완료될 때까지 블로킹된다.
class _BlockingSaveToPrefsUseCase extends Fake
    implements SaveContactToPrefsUseCase {
  final Completer<AppResult<void>> _completer;
  int callCount = 0;

  _BlockingSaveToPrefsUseCase(this._completer);

  @override
  Future<AppResult<void>> call(ContactEntity entity) {
    callCount++;
    return _completer.future;
  }
}

class _FakeLoadFromPrefsUseCase extends Fake
    implements LoadContactFromPrefsUseCase {
  final AppResult<ContactEntity?> _result;
  int callCount = 0;

  _FakeLoadFromPrefsUseCase(this._result);

  @override
  Future<AppResult<ContactEntity?>> call() async {
    callCount++;
    return _result;
  }
}

// ── 공통 픽스처 ───────────────────────────────────────────────────────────────

const _testContact = ContactEntity(id: 1, name: '홍길동', phone: '010-1234-5678');
const _testError = AppException.unknown('저장 오류');

ProviderContainer _makeContainer({
  required SaveContactToPrefsUseCase savePrefsUseCase,
  required LoadContactFromPrefsUseCase loadPrefsUseCase,
}) {
  return ProviderContainer(
    overrides: [
      saveContactToPrefsUseCaseProvider.overrideWith(
        (_) async => savePrefsUseCase,
      ),
      loadContactFromPrefsUseCaseProvider.overrideWith(
        (_) async => loadPrefsUseCase,
      ),
    ],
  );
}

void main() {
  // ── ContactInputViewModel 통합 테스트 ─────────────────────────────────────
  // ProviderContainer에 UseCase 프로바이더를 오버라이드하여
  // dispatch → reduce → effect → reduce 전체 흐름을 검증한다.
  group('ContactInputViewModel', () {
    // ── saveToPrefs ───────────────────────────────────────────────────────
    group('saveToPrefs', () {
      test('성공 — isLoading이 true → false로 전환되고 error가 없다', () async {
        final saveUseCase =
            _FakeSaveToPrefsUseCase(const AppResult.success(null));
        final loadUseCase =
            _FakeLoadFromPrefsUseCase(const AppResult.success(null));
        final container = _makeContainer(
          savePrefsUseCase: saveUseCase,
          loadPrefsUseCase: loadUseCase,
        );
        addTearDown(container.dispose);

        final states = <ContactInputState>[];
        container.listen(
          contactInputViewModelProvider,
          (_, state) => states.add(state),
          fireImmediately: true,
        );

        container
            .read(contactInputViewModelProvider.notifier)
            .dispatch(
              const ContactInputAction.saveToPrefsStarted(_testContact),
            );

        await pumpEventQueue();

        // [0] 초기, [1] isLoading=true(Started), [2] isLoading=false(Succeeded)
        expect(states, hasLength(3));
        expect(states[1].isLoading, true);
        expect(states[2].isLoading, false);
        expect(states[2].error, isNull);
      });

      test('실패 — isLoading이 false로 전환되고 error가 설정된다', () async {
        final saveUseCase = _FakeSaveToPrefsUseCase(
          AppResult<void>.failure(_testError),
        );
        final loadUseCase =
            _FakeLoadFromPrefsUseCase(const AppResult.success(null));
        final container = _makeContainer(
          savePrefsUseCase: saveUseCase,
          loadPrefsUseCase: loadUseCase,
        );
        addTearDown(container.dispose);

        final states = <ContactInputState>[];
        container.listen(
          contactInputViewModelProvider,
          (_, state) => states.add(state),
          fireImmediately: true,
        );

        container
            .read(contactInputViewModelProvider.notifier)
            .dispatch(
              const ContactInputAction.saveToPrefsStarted(_testContact),
            );

        await pumpEventQueue();

        // [0] 초기, [1] isLoading=true(Started), [2] isLoading=false+error(Failed)
        expect(states, hasLength(3));
        expect(states[1].isLoading, true);
        expect(states[2].isLoading, false);
        expect(states[2].error, _testError);
      });
    });

    // ── loadFromPrefs ─────────────────────────────────────────────────────
    group('loadFromPrefs', () {
      test('성공 — prefsLoadedContact에 엔티티가 설정된다', () async {
        final saveUseCase =
            _FakeSaveToPrefsUseCase(const AppResult.success(null));
        final loadUseCase = _FakeLoadFromPrefsUseCase(
          const AppResult<ContactEntity?>.success(_testContact),
        );
        final container = _makeContainer(
          savePrefsUseCase: saveUseCase,
          loadPrefsUseCase: loadUseCase,
        );
        addTearDown(container.dispose);

        final states = <ContactInputState>[];
        container.listen(
          contactInputViewModelProvider,
          (_, state) => states.add(state),
          fireImmediately: true,
        );

        container
            .read(contactInputViewModelProvider.notifier)
            .dispatch(const ContactInputAction.loadFromPrefsStarted());

        await pumpEventQueue();

        // [0] 초기, [1] isLoading=true(Started), [2] isLoading=false+contact(Succeeded)
        expect(states, hasLength(3));
        expect(states[1].isLoading, true);
        expect(states[2].isLoading, false);
        expect(states[2].prefsLoadedContact, _testContact);
        expect(states[2].error, isNull);
      });

      test('실패 — isLoading이 false로 전환되고 error가 설정된다', () async {
        final saveUseCase =
            _FakeSaveToPrefsUseCase(const AppResult.success(null));
        final loadUseCase = _FakeLoadFromPrefsUseCase(
          AppResult<ContactEntity?>.failure(_testError),
        );
        final container = _makeContainer(
          savePrefsUseCase: saveUseCase,
          loadPrefsUseCase: loadUseCase,
        );
        addTearDown(container.dispose);

        final states = <ContactInputState>[];
        container.listen(
          contactInputViewModelProvider,
          (_, state) => states.add(state),
          fireImmediately: true,
        );

        container
            .read(contactInputViewModelProvider.notifier)
            .dispatch(const ContactInputAction.loadFromPrefsStarted());

        await pumpEventQueue();

        // [0] 초기, [1] isLoading=true(Started), [2] isLoading=false+error(Failed)
        expect(states, hasLength(3));
        expect(states[1].isLoading, true);
        expect(states[2].isLoading, false);
        expect(states[2].error, _testError);
        expect(states[2].prefsLoadedContact, isNull);
      });
    });
  });

  // ── ContactInputEffect guard flag 테스트 ──────────────────────────────────
  // BaseViewModel 큐는 Effect를 순차 처리(await)하므로 큐를 통한 중복 실행은
  // 발생하지 않는다. guard flag의 실제 역할(동시 진입 차단)을 검증하려면
  // Effect를 직접 생성해 handleEffect를 await 없이 연속 호출해야 한다.
  group('ContactInputEffect guard flag', () {
    test('saveToPrefs 실행 중 동일 action 재진입 시 UseCase 호출이 차단된다', () async {
      final completer = Completer<AppResult<void>>();
      final blockingUseCase = _BlockingSaveToPrefsUseCase(completer);

      // 블로킹 UseCase만 오버라이드한다 — 다른 프로바이더는 이 테스트에서 접근하지 않는다.
      final container = ProviderContainer(
        overrides: [
          saveContactToPrefsUseCaseProvider.overrideWith(
            (_) async => blockingUseCase,
          ),
        ],
      );
      addTearDown(container.dispose);

      // _testRefProvider를 통해 container의 Ref를 획득한다.
      // 이 ref로 read하면 container의 오버라이드가 적용된다.
      final effectRef = container.read(_testRefProvider);
      final dispatched = <ContactInputAction>[];
      final effect = ContactInputEffect(effectRef, dispatched.add);

      const action = ContactInputAction.saveToPrefsStarted(_testContact);

      // await 없이 연속 호출 → f1이 첫 번째 await에서 yield되는 사이
      // f2가 guard를 만나 즉시 반환된다.
      final f1 = effect.handleEffect(action);
      final f2 = effect.handleEffect(action);

      // completer 완료 → f1의 UseCase 호출 결과가 resolve된다.
      completer.complete(const AppResult.success(null));
      await Future.wait([f1, f2]);

      expect(blockingUseCase.callCount, 1, reason: '_isSavingToPrefs guard로 두 번째 호출 차단');
      expect(dispatched, hasLength(1));
      expect(dispatched.first, isA<SaveToPrefsSucceeded>());
    });

    test('loadFromPrefs 실행 중 동일 action 재진입 시 UseCase 호출이 차단된다', () async {
      final completer = Completer<AppResult<ContactEntity?>>();
      int callCount = 0;

      final container = ProviderContainer(
        overrides: [
          loadContactFromPrefsUseCaseProvider.overrideWith((_) async {
            return _BlockingLoadFromPrefsUseCase(completer, () => callCount++);
          }),
        ],
      );
      addTearDown(container.dispose);

      final effectRef = container.read(_testRefProvider);
      final dispatched = <ContactInputAction>[];
      final effect = ContactInputEffect(effectRef, dispatched.add);

      const action = ContactInputAction.loadFromPrefsStarted();

      final f1 = effect.handleEffect(action);
      final f2 = effect.handleEffect(action);

      completer.complete(const AppResult.success(null));
      await Future.wait([f1, f2]);

      expect(callCount, 1, reason: '_isLoadingFromPrefs guard로 두 번째 호출 차단');
      expect(dispatched, hasLength(1));
      expect(dispatched.first, isA<LoadFromPrefsSucceeded>());
    });
  });
}

/// loadFromPrefs guard flag 테스트 전용 블로킹 UseCase.
class _BlockingLoadFromPrefsUseCase extends Fake
    implements LoadContactFromPrefsUseCase {
  final Completer<AppResult<ContactEntity?>> _completer;
  final void Function() _onCall;

  _BlockingLoadFromPrefsUseCase(this._completer, this._onCall);

  @override
  Future<AppResult<ContactEntity?>> call() {
    _onCall();
    return _completer.future;
  }
}
