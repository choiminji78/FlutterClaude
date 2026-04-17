import 'package:flutter_claude/domain/common/entity/app_result.dart';
import 'package:flutter_claude/domain/contact/entity/contact_entity.dart';

abstract class ContactRepository {
  // SharedPreferences
  Future<AppResult<ContactEntity?>> readContactFromPrefs();
  Future<AppResult<void>> writeContactToPrefs(ContactEntity entity);

  // SecureStorage — 전부 비동기
  Future<AppResult<ContactEntity?>> readContactFromSecure();
  Future<AppResult<void>> writeContactToSecure(ContactEntity entity);

  // Drift — 전부 비동기
  Future<AppResult<List<ContactEntity>>> getAllContacts();
  Future<AppResult<void>> insertContact(ContactEntity entity);
  Future<AppResult<void>> deleteContact({required int id});
}
