import 'package:flutter_claude/domain/common/exception/app_exception.dart';
import 'package:flutter_claude/domain/contact/entity/contact_entity.dart';
import 'package:flutter_claude/feature/contact_input/action/contact_input_action.dart';
import 'package:flutter_claude/feature/contact_input/reducer/contact_input_reducer.dart';
import 'package:flutter_claude/feature/contact_input/state/contact_input_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('contactInputReducer', () {
    const initialState = ContactInputState();
    const testContact = ContactEntity(id: 0, name: '홍길동', phone: '010-1234-5678');

    // ── 입력 변경 ──────────────────────────────────────────────
    test('nameInputChanged — nameInput을 업데이트한다', () {
      const action = ContactInputAction.nameInputChanged('홍길동');
      final result = contactInputReducer(initialState, action);
      expect(result.nameInput, '홍길동');
      expect(result.phoneInput, '');
    });

    test('phoneInputChanged — phoneInput을 업데이트한다', () {
      const action = ContactInputAction.phoneInputChanged('010-1234-5678');
      final result = contactInputReducer(initialState, action);
      expect(result.phoneInput, '010-1234-5678');
      expect(result.nameInput, '');
    });

    // ── SharedPreferences 저장 ─────────────────────────────────
    test('saveToPrefsStarted — isLoading true, error null로 설정한다', () {
      final stateWithError =
          initialState.copyWith(error: const AppException.unknown('이전 오류'));
      const action = ContactInputAction.saveToPrefsStarted(testContact);

      final result = contactInputReducer(stateWithError, action);

      expect(result.isLoading, true);
      expect(result.error, isNull);
    });

    test('saveToPrefsSucceeded — isLoading을 false로 설정한다', () {
      final loadingState = initialState.copyWith(isLoading: true);
      const action = ContactInputAction.saveToPrefsSucceeded();

      final result = contactInputReducer(loadingState, action);

      expect(result.isLoading, false);
    });

    test('saveToPrefsFailed — isLoading false, error를 설정한다', () {
      final loadingState = initialState.copyWith(isLoading: true);
      const error = AppException.unknown('Prefs 저장 실패');
      const action = ContactInputAction.saveToPrefsFailed(error);

      final result = contactInputReducer(loadingState, action);

      expect(result.isLoading, false);
      expect(result.error, error);
    });

    // ── SharedPreferences 불러오기 ────────────────────────────
    test('loadFromPrefsStarted — isLoading true, error null로 설정한다', () {
      final stateWithError =
          initialState.copyWith(error: const AppException.unknown('이전'));
      const action = ContactInputAction.loadFromPrefsStarted();

      final result = contactInputReducer(stateWithError, action);

      expect(result.isLoading, true);
      expect(result.error, isNull);
    });

    test('loadFromPrefsSucceeded — prefsLoadedContact를 업데이트한다', () {
      final loadingState = initialState.copyWith(isLoading: true);
      const action = ContactInputAction.loadFromPrefsSucceeded(testContact);

      final result = contactInputReducer(loadingState, action);

      expect(result.isLoading, false);
      expect(result.prefsLoadedContact?.name, '홍길동');
      expect(result.prefsLoadedContact?.phone, '010-1234-5678');
    });

    test('loadFromPrefsSucceeded — null 값도 정상 처리된다', () {
      const action = ContactInputAction.loadFromPrefsSucceeded(null);
      final result = contactInputReducer(initialState, action);
      expect(result.prefsLoadedContact, isNull);
    });

    test('loadFromPrefsFailed — isLoading false, error를 설정한다', () {
      final loadingState = initialState.copyWith(isLoading: true);
      const error = AppException.unknown('Prefs 로드 실패');
      const action = ContactInputAction.loadFromPrefsFailed(error);

      final result = contactInputReducer(loadingState, action);

      expect(result.isLoading, false);
      expect(result.error, error);
    });

    // ── SecureStorage 저장 ────────────────────────────────────
    test('saveToSecureStarted — isLoading true, error null로 설정한다', () {
      final stateWithError =
          initialState.copyWith(error: const AppException.unknown('이전 오류'));
      const action = ContactInputAction.saveToSecureStarted(testContact);

      final result = contactInputReducer(stateWithError, action);

      expect(result.isLoading, true);
      expect(result.error, isNull);
    });

    test('saveToSecureSucceeded — isLoading을 false로 설정한다', () {
      final loadingState = initialState.copyWith(isLoading: true);
      const action = ContactInputAction.saveToSecureSucceeded();

      final result = contactInputReducer(loadingState, action);

      expect(result.isLoading, false);
    });

    test('saveToSecureFailed — isLoading false, error를 설정한다', () {
      final loadingState = initialState.copyWith(isLoading: true);
      const error = AppException.unknown('Secure 저장 실패');
      const action = ContactInputAction.saveToSecureFailed(error);

      final result = contactInputReducer(loadingState, action);

      expect(result.isLoading, false);
      expect(result.error, error);
    });

    // ── SecureStorage 불러오기 ────────────────────────────────
    test('loadFromSecureStarted — isLoading true, error null로 설정한다', () {
      final stateWithError =
          initialState.copyWith(error: const AppException.unknown('이전'));
      const action = ContactInputAction.loadFromSecureStarted();

      final result = contactInputReducer(stateWithError, action);

      expect(result.isLoading, true);
      expect(result.error, isNull);
    });

    test('loadFromSecureSucceeded — secureLoadedContact를 업데이트한다', () {
      final loadingState = initialState.copyWith(isLoading: true);
      const action = ContactInputAction.loadFromSecureSucceeded(testContact);

      final result = contactInputReducer(loadingState, action);

      expect(result.isLoading, false);
      expect(result.secureLoadedContact?.name, '홍길동');
      expect(result.secureLoadedContact?.phone, '010-1234-5678');
    });

    test('loadFromSecureSucceeded — null 값도 정상 처리된다', () {
      const action = ContactInputAction.loadFromSecureSucceeded(null);
      final result = contactInputReducer(initialState, action);
      expect(result.secureLoadedContact, isNull);
    });

    test('loadFromSecureFailed — isLoading false, error를 설정한다', () {
      final loadingState = initialState.copyWith(isLoading: true);
      const error = AppException.unknown('Secure 로드 실패');
      const action = ContactInputAction.loadFromSecureFailed(error);

      final result = contactInputReducer(loadingState, action);

      expect(result.isLoading, false);
      expect(result.error, error);
    });

    // ── Drift 저장 ────────────────────────────────────────────
    test('saveToDriftStarted — isLoading true, error null로 설정한다', () {
      final stateWithError =
          initialState.copyWith(error: const AppException.unknown('이전 오류'));
      const action = ContactInputAction.saveToDriftStarted(testContact);

      final result = contactInputReducer(stateWithError, action);

      expect(result.isLoading, true);
      expect(result.error, isNull);
    });

    test('saveToDriftSucceeded — isLoading을 false로 설정한다', () {
      final loadingState = initialState.copyWith(isLoading: true);
      const action = ContactInputAction.saveToDriftSucceeded();

      final result = contactInputReducer(loadingState, action);

      expect(result.isLoading, false);
    });

    test('saveToDriftFailed — isLoading false, error를 설정한다', () {
      final loadingState = initialState.copyWith(isLoading: true);
      const error = AppException.unknown('Drift 저장 실패');
      const action = ContactInputAction.saveToDriftFailed(error);

      final result = contactInputReducer(loadingState, action);

      expect(result.isLoading, false);
      expect(result.error, error);
    });

    // ── Drift 불러오기 ─────────────────────────────────────────
    test('loadFromDriftStarted — isLoading true, error null로 설정한다', () {
      final stateWithError =
          initialState.copyWith(error: const AppException.unknown('이전'));
      const action = ContactInputAction.loadFromDriftStarted();

      final result = contactInputReducer(stateWithError, action);

      expect(result.isLoading, true);
      expect(result.error, isNull);
    });

    test('loadFromDriftSucceeded — driftLoadedContacts를 업데이트한다', () {
      final loadingState = initialState.copyWith(isLoading: true);
      const contacts = [
        ContactEntity(id: 1, name: '홍길동', phone: '010-1234-5678'),
        ContactEntity(id: 2, name: '김철수', phone: '010-9876-5432'),
      ];
      const action = ContactInputAction.loadFromDriftSucceeded(contacts);

      final result = contactInputReducer(loadingState, action);

      expect(result.isLoading, false);
      expect(result.driftLoadedContacts.length, 2);
      expect(result.driftLoadedContacts.first.name, '홍길동');
    });

    test('loadFromDriftSucceeded — 빈 목록도 정상 처리된다', () {
      const action = ContactInputAction.loadFromDriftSucceeded([]);
      final result = contactInputReducer(initialState, action);
      expect(result.driftLoadedContacts, isEmpty);
    });

    test('loadFromDriftFailed — isLoading false, error를 설정한다', () {
      final loadingState = initialState.copyWith(isLoading: true);
      const error = AppException.unknown('Drift 로드 실패');
      const action = ContactInputAction.loadFromDriftFailed(error);

      final result = contactInputReducer(loadingState, action);

      expect(result.isLoading, false);
      expect(result.error, error);
    });

    // ── 저장소 독립성 검증 ─────────────────────────────────────
    test('Prefs 불러오기가 Secure 값에 영향을 주지 않는다', () {
      const secureContact = ContactEntity(id: 0, name: 'Secure이름', phone: 'Secure번호');
      final stateWithSecure = initialState.copyWith(
        secureLoadedContact: secureContact,
      );
      const prefsContact = ContactEntity(id: 0, name: 'Prefs이름', phone: 'Prefs번호');
      const action = ContactInputAction.loadFromPrefsSucceeded(prefsContact);

      final result = contactInputReducer(stateWithSecure, action);

      expect(result.prefsLoadedContact?.name, 'Prefs이름');
      expect(result.prefsLoadedContact?.phone, 'Prefs번호');
      expect(result.secureLoadedContact?.name, 'Secure이름');
      expect(result.secureLoadedContact?.phone, 'Secure번호');
    });

    test('Secure 불러오기가 Prefs 값에 영향을 주지 않는다', () {
      const prefsContact = ContactEntity(id: 0, name: 'Prefs이름', phone: 'Prefs번호');
      final stateWithPrefs = initialState.copyWith(
        prefsLoadedContact: prefsContact,
      );
      const secureContact = ContactEntity(id: 0, name: 'Secure이름', phone: 'Secure번호');
      const action = ContactInputAction.loadFromSecureSucceeded(secureContact);

      final result = contactInputReducer(stateWithPrefs, action);

      expect(result.secureLoadedContact?.name, 'Secure이름');
      expect(result.secureLoadedContact?.phone, 'Secure번호');
      expect(result.prefsLoadedContact?.name, 'Prefs이름');
      expect(result.prefsLoadedContact?.phone, 'Prefs번호');
    });
  });
}
