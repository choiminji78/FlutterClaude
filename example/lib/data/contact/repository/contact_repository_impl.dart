import 'package:flutter_claude/data/common/mapper/storage_exception_mapper.dart';
import 'package:flutter_claude/data/contact/datasource/local/contact_local_data_source.dart';
import 'package:flutter_claude/data/contact/mapper/contact_drift_mapper.dart';
import 'package:flutter_claude/domain/common/entity/app_result.dart';
import 'package:flutter_claude/domain/contact/entity/contact_entity.dart';
import 'package:flutter_claude/domain/contact/repository/contact_repository.dart';

class ContactRepositoryImpl implements ContactRepository {
  const ContactRepositoryImpl({
    required this.localDataSource,
    required this.storageExceptionMapper,
    required this.driftMapper,
  });

  final ContactLocalDataSource localDataSource;
  final StorageExceptionMapper storageExceptionMapper;
  final ContactDriftMapper driftMapper;

  // ── SharedPreferences ─────────────────────────────────────────

  @override
  Future<AppResult<ContactEntity?>> readContactFromPrefs() async {
    final nameResponse = await localDataSource.getNameFromPrefs();
    final phoneResponse = await localDataSource.getPhoneFromPrefs();

    final name = nameResponse.when(success: (v) => v, failure: (_) => null);
    final phone = phoneResponse.when(success: (v) => v, failure: (_) => null);

    if (name == null || phone == null) return const AppResult.success(null);
    return AppResult.success(ContactEntity(id: 0, name: name, phone: phone));
  }

  @override
  Future<AppResult<void>> writeContactToPrefs(ContactEntity entity) async {
    final nameResponse = await localDataSource.setNameToPrefs(entity.name);
    final nameError = nameResponse.when(success: (_) => null, failure: (e) => e);
    if (nameError != null) {
      return AppResult.failure(storageExceptionMapper.map(nameError));
    }

    final phoneResponse = await localDataSource.setPhoneToPrefs(entity.phone);
    return phoneResponse.when(
      success: (_) => const AppResult.success(null),
      failure: (e) => AppResult.failure(storageExceptionMapper.map(e)),
    );
  }

  // ── SecureStorage ─────────────────────────────────────────────

  @override
  Future<AppResult<ContactEntity?>> readContactFromSecure() async {
    final nameResponse = await localDataSource.readNameFromSecure();
    final phoneResponse = await localDataSource.readPhoneFromSecure();

    final name = nameResponse.when(success: (v) => v, failure: (_) => null);
    final phone = phoneResponse.when(success: (v) => v, failure: (_) => null);

    if (name == null || phone == null) return const AppResult.success(null);
    return AppResult.success(ContactEntity(id: 0, name: name, phone: phone));
  }

  @override
  Future<AppResult<void>> writeContactToSecure(ContactEntity entity) async {
    final nameResponse = await localDataSource.writeNameToSecure(entity.name);
    final nameError = nameResponse.when(success: (_) => null, failure: (e) => e);
    if (nameError != null) {
      return AppResult.failure(storageExceptionMapper.map(nameError));
    }

    final phoneResponse = await localDataSource.writePhoneToSecure(entity.phone);
    return phoneResponse.when(
      success: (_) => const AppResult.success(null),
      failure: (e) => AppResult.failure(storageExceptionMapper.map(e)),
    );
  }

  // ── Drift ─────────────────────────────────────────────────────

  @override
  Future<AppResult<List<ContactEntity>>> getAllContacts() async {
    final response = await localDataSource.getAllContacts();
    return response.when(
      success: (rows) => AppResult.success(rows.map<ContactEntity>(driftMapper.toDomain).toList()),
      failure: (e) => AppResult.failure(storageExceptionMapper.map(e)),
    );
  }

  @override
  Future<AppResult<void>> insertContact(ContactEntity entity) async {
    final response = await localDataSource.insertContact(
      companion: driftMapper.toInsertCompanion(entity),
    );
    return response.when(
      success: (_) => const AppResult.success(null),
      failure: (e) => AppResult.failure(storageExceptionMapper.map(e)),
    );
  }

  @override
  Future<AppResult<void>> deleteContact({required int id}) async {
    final response = await localDataSource.deleteContact(id: id);
    return response.when(
      success: (_) => const AppResult.success(null),
      failure: (e) => AppResult.failure(storageExceptionMapper.map(e)),
    );
  }
}
