import 'package:flutter_claude/app/di/contact_di.dart';
import 'package:flutter_claude/domain/contact/entity/contact_entity.dart';
import 'package:flutter_claude/feature/contact_input/action/contact_input_action.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContactInputEffect {
  ContactInputEffect(this._ref, this._dispatch);

  final Ref _ref;
  final void Function(ContactInputAction) _dispatch;

  bool _isSavingToPrefs = false;
  bool _isLoadingFromPrefs = false;
  bool _isSavingToSecure = false;
  bool _isLoadingFromSecure = false;
  bool _isSavingToDrift = false;
  bool _isLoadingFromDrift = false;

  Future<void> handleEffect(ContactInputAction action) async {
    await action.when(
      nameInputChanged: (_) => null,
      phoneInputChanged: (_) => null,
      saveToPrefsStarted: (contact) => _saveToPrefs(contact),
      saveToPrefsSucceeded: () => null,
      saveToPrefsFailed: (_) => null,
      loadFromPrefsStarted: () => _loadFromPrefs(),
      loadFromPrefsSucceeded: (_) => null,
      loadFromPrefsFailed: (_) => null,
      saveToSecureStarted: (contact) => _saveToSecure(contact),
      saveToSecureSucceeded: () => null,
      saveToSecureFailed: (_) => null,
      loadFromSecureStarted: () => _loadFromSecure(),
      loadFromSecureSucceeded: (_) => null,
      loadFromSecureFailed: (_) => null,
      saveToDriftStarted: (contact) => _saveToDrift(contact),
      saveToDriftSucceeded: () => null,
      saveToDriftFailed: (_) => null,
      loadFromDriftStarted: () => _loadFromDrift(),
      loadFromDriftSucceeded: (_) => null,
      loadFromDriftFailed: (_) => null,
    );
  }

  // ── SharedPreferences 저장 ──

  Future<void> _saveToPrefs(ContactEntity contact) async {
    if (_isSavingToPrefs) return;
    _isSavingToPrefs = true;
    try {
      final useCase = await _ref.read(saveContactToPrefsUseCaseProvider.future);
      final result = await useCase(contact);
      result.when(
        success: (_) => _dispatch(ContactInputAction.saveToPrefsSucceeded()),
        failure: (e) => _dispatch(ContactInputAction.saveToPrefsFailed(e)),
      );
    } finally {
      _isSavingToPrefs = false;
    }
  }

  // ── SharedPreferences 불러오기 ──

  Future<void> _loadFromPrefs() async {
    if (_isLoadingFromPrefs) return;
    _isLoadingFromPrefs = true;
    try {
      final useCase = await _ref.read(loadContactFromPrefsUseCaseProvider.future);
      final result = await useCase();
      result.when(
        success: (contact) =>
            _dispatch(ContactInputAction.loadFromPrefsSucceeded(contact)),
        failure: (e) => _dispatch(ContactInputAction.loadFromPrefsFailed(e)),
      );
    } finally {
      _isLoadingFromPrefs = false;
    }
  }

  // ── SecureStorage 저장 ──

  Future<void> _saveToSecure(ContactEntity contact) async {
    if (_isSavingToSecure) return;
    _isSavingToSecure = true;
    try {
      final useCase =
          await _ref.read(saveContactToSecureUseCaseProvider.future);
      final result = await useCase(contact);
      result.when(
        success: (_) => _dispatch(ContactInputAction.saveToSecureSucceeded()),
        failure: (e) => _dispatch(ContactInputAction.saveToSecureFailed(e)),
      );
    } finally {
      _isSavingToSecure = false;
    }
  }

  // ── SecureStorage 불러오기 ──

  Future<void> _loadFromSecure() async {
    if (_isLoadingFromSecure) return;
    _isLoadingFromSecure = true;
    try {
      final useCase =
          await _ref.read(loadContactFromSecureUseCaseProvider.future);
      final result = await useCase();
      result.when(
        success: (contact) =>
            _dispatch(ContactInputAction.loadFromSecureSucceeded(contact)),
        failure: (e) => _dispatch(ContactInputAction.loadFromSecureFailed(e)),
      );
    } finally {
      _isLoadingFromSecure = false;
    }
  }

  // ── Drift 저장 ──

  Future<void> _saveToDrift(ContactEntity contact) async {
    if (_isSavingToDrift) return;
    _isSavingToDrift = true;
    try {
      final repo = await _ref.read(contactRepositoryProvider.future);
      final result = await repo.insertContact(contact);
      result.when(
        success: (_) => _dispatch(ContactInputAction.saveToDriftSucceeded()),
        failure: (e) => _dispatch(ContactInputAction.saveToDriftFailed(e)),
      );
    } finally {
      _isSavingToDrift = false;
    }
  }

  // ── Drift 불러오기 ──

  Future<void> _loadFromDrift() async {
    if (_isLoadingFromDrift) return;
    _isLoadingFromDrift = true;
    try {
      final repo = await _ref.read(contactRepositoryProvider.future);
      final result = await repo.getAllContacts();
      result.when(
        success: (contacts) =>
            _dispatch(ContactInputAction.loadFromDriftSucceeded(contacts)),
        failure: (e) => _dispatch(ContactInputAction.loadFromDriftFailed(e)),
      );
    } finally {
      _isLoadingFromDrift = false;
    }
  }
}
