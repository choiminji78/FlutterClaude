import 'package:flutter_claude/core/storage/common/dto/storage_response.dart';
import 'package:flutter_claude/core/storage/common/exception/storage_exception.dart';
import 'package:flutter_claude/core/storage/database/drift/drift_database_service.dart';
import 'package:flutter_claude/core/storage/preferences/preferences_service.dart';
import 'package:flutter_claude/core/storage/secure_storage/secure_storage_service.dart';

abstract class ContactLocalDataSource {
  // SharedPreferences
  Future<StorageResponse<String>> getNameFromPrefs();
  Future<StorageResponse<void>> setNameToPrefs(String value);

  Future<StorageResponse<String>> getPhoneFromPrefs();
  Future<StorageResponse<void>> setPhoneToPrefs(String value);

  // SecureStorage — 전부 비동기
  Future<StorageResponse<String>> readNameFromSecure();
  Future<StorageResponse<void>> writeNameToSecure(String value);

  Future<StorageResponse<String>> readPhoneFromSecure();
  Future<StorageResponse<void>> writePhoneToSecure(String value);

  // Drift — 전부 비동기
  Future<StorageResponse<List<ContactTableData>>> getAllContacts();
  Future<StorageResponse<void>> insertContact({required ContactTableCompanion companion});
  Future<StorageResponse<void>> deleteContact({required int id});
}

class ContactLocalDataSourceImpl implements ContactLocalDataSource {
  const ContactLocalDataSourceImpl({
    required PreferencesService preferencesService,
    required SecureStorageService secureStorageService,
    required DriftDatabaseService driftDatabaseService,
  })  : _prefs = preferencesService,
        _secure = secureStorageService,
        _db = driftDatabaseService;

  final PreferencesService _prefs;
  final SecureStorageService _secure;
  final DriftDatabaseService _db;

  // SharedPreferences 키
  static const _kPrefsName = 'contact_prefs_name';
  static const _kPrefsPhone = 'contact_prefs_phone';

  // SecureStorage 키
  static const _kSecureName = 'contact_secure_name';
  static const _kSecurePhone = 'contact_secure_phone';

  // ── SharedPreferences: Name ──

  @override
  Future<StorageResponse<String>> getNameFromPrefs() async {
    final value = _prefs.getString(_kPrefsName);
    if (value == null) {
      return StorageResponse.failure(
        StorageException.notFound('Name not found in Prefs'),
      );
    }
    return StorageResponse.success(value);
  }

  @override
  Future<StorageResponse<void>> setNameToPrefs(String value) async {
    try {
      await _prefs.setString(_kPrefsName, value);
      return const StorageResponse.success(null);
    } catch (e) {
      return StorageResponse.failure(StorageException.general(e.toString()));
    }
  }

  // ── SharedPreferences: Phone ──

  @override
  Future<StorageResponse<String>> getPhoneFromPrefs() async {
    final value = _prefs.getString(_kPrefsPhone);
    if (value == null) {
      return StorageResponse.failure(
        StorageException.notFound('Phone not found in Prefs'),
      );
    }
    return StorageResponse.success(value);
  }

  @override
  Future<StorageResponse<void>> setPhoneToPrefs(String value) async {
    try {
      await _prefs.setString(_kPrefsPhone, value);
      return const StorageResponse.success(null);
    } catch (e) {
      return StorageResponse.failure(StorageException.general(e.toString()));
    }
  }

  // ── SecureStorage: Name ──

  @override
  Future<StorageResponse<String>> readNameFromSecure() async {
    try {
      final value = await _secure.read(key: _kSecureName);
      if (value == null) {
        return StorageResponse.failure(
          StorageException.notFound('Name not found in Secure'),
        );
      }
      return StorageResponse.success(value);
    } catch (e) {
      return StorageResponse.failure(StorageException.general(e.toString()));
    }
  }

  @override
  Future<StorageResponse<void>> writeNameToSecure(String value) async {
    try {
      await _secure.write(key: _kSecureName, value: value);
      return const StorageResponse.success(null);
    } catch (e) {
      return StorageResponse.failure(StorageException.general(e.toString()));
    }
  }

  // ── SecureStorage: Phone ──

  @override
  Future<StorageResponse<String>> readPhoneFromSecure() async {
    try {
      final value = await _secure.read(key: _kSecurePhone);
      if (value == null) {
        return StorageResponse.failure(
          StorageException.notFound('Phone not found in Secure'),
        );
      }
      return StorageResponse.success(value);
    } catch (e) {
      return StorageResponse.failure(StorageException.general(e.toString()));
    }
  }

  @override
  Future<StorageResponse<void>> writePhoneToSecure(String value) async {
    try {
      await _secure.write(key: _kSecurePhone, value: value);
      return const StorageResponse.success(null);
    } catch (e) {
      return StorageResponse.failure(StorageException.general(e.toString()));
    }
  }

  // ── Drift ────────────────────────────────────────────────────

  @override
  Future<StorageResponse<List<ContactTableData>>> getAllContacts() async {
    try {
      final rows = await _db.select(_db.contactTable).get();
      return StorageResponse.success(rows);
    } catch (e) {
      return StorageResponse.failure(StorageException.general(e.toString()));
    }
  }

  @override
  Future<StorageResponse<void>> insertContact({required ContactTableCompanion companion}) async {
    try {
      await _db.into(_db.contactTable).insert(companion);
      return const StorageResponse.success(null);
    } catch (e) {
      return StorageResponse.failure(StorageException.general(e.toString()));
    }
  }

  @override
  Future<StorageResponse<void>> deleteContact({required int id}) async {
    try {
      await (_db.delete(_db.contactTable)..where((t) => t.id.equals(id))).go();
      return const StorageResponse.success(null);
    } catch (e) {
      return StorageResponse.failure(StorageException.general(e.toString()));
    }
  }
}
