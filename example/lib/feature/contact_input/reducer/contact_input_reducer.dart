import 'package:flutter_claude/feature/contact_input/action/contact_input_action.dart';
import 'package:flutter_claude/feature/contact_input/state/contact_input_state.dart';

ContactInputState contactInputReducer(
  ContactInputState state,
  ContactInputAction action,
) {
  return action.when(
    nameInputChanged: (name) => state.copyWith(nameInput: name),
    phoneInputChanged: (phone) => state.copyWith(phoneInput: phone),

    // SharedPreferences 저장
    saveToPrefsStarted: (_) => state.copyWith(isLoading: true, error: null),
    saveToPrefsSucceeded: () => state.copyWith(isLoading: false),
    saveToPrefsFailed: (error) =>
        state.copyWith(isLoading: false, error: error),

    // SharedPreferences 불러오기
    loadFromPrefsStarted: () => state.copyWith(isLoading: true, error: null),
    loadFromPrefsSucceeded: (contact) => state.copyWith(
      isLoading: false,
      prefsLoadedContact: contact,
    ),
    loadFromPrefsFailed: (error) =>
        state.copyWith(isLoading: false, error: error),

    // SecureStorage 저장
    saveToSecureStarted: (_) =>
        state.copyWith(isLoading: true, error: null),
    saveToSecureSucceeded: () => state.copyWith(isLoading: false),
    saveToSecureFailed: (error) =>
        state.copyWith(isLoading: false, error: error),

    // SecureStorage 불러오기
    loadFromSecureStarted: () => state.copyWith(isLoading: true, error: null),
    loadFromSecureSucceeded: (contact) => state.copyWith(
      isLoading: false,
      secureLoadedContact: contact,
    ),
    loadFromSecureFailed: (error) =>
        state.copyWith(isLoading: false, error: error),

    // Drift 저장
    saveToDriftStarted: (_) => state.copyWith(isLoading: true, error: null),
    saveToDriftSucceeded: () => state.copyWith(isLoading: false),
    saveToDriftFailed: (error) =>
        state.copyWith(isLoading: false, error: error),

    // Drift 불러오기
    loadFromDriftStarted: () => state.copyWith(isLoading: true, error: null),
    loadFromDriftSucceeded: (contacts) => state.copyWith(
      isLoading: false,
      driftLoadedContacts: contacts,
    ),
    loadFromDriftFailed: (error) =>
        state.copyWith(isLoading: false, error: error),
  );
}
