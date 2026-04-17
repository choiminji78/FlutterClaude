import 'package:flutter_claude/domain/common/exception/app_exception.dart';
import 'package:flutter_claude/domain/contact/entity/contact_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact_input_action.freezed.dart';

@freezed
sealed class ContactInputAction with _$ContactInputAction {
  // 입력 변경
  const factory ContactInputAction.nameInputChanged(String name) =
      NameInputChanged;
  const factory ContactInputAction.phoneInputChanged(String phone) =
      PhoneInputChanged;

  // SharedPreferences 저장
  const factory ContactInputAction.saveToPrefsStarted(ContactEntity contact) =
      SaveToPrefsStarted;
  const factory ContactInputAction.saveToPrefsSucceeded() =
      SaveToPrefsSucceeded;
  const factory ContactInputAction.saveToPrefsFailed(AppException error) =
      SaveToPrefsFailed;

  // SharedPreferences 불러오기
  const factory ContactInputAction.loadFromPrefsStarted() =
      LoadFromPrefsStarted;
  const factory ContactInputAction.loadFromPrefsSucceeded(
    ContactEntity? contact,
  ) = LoadFromPrefsSucceeded;
  const factory ContactInputAction.loadFromPrefsFailed(AppException error) =
      LoadFromPrefsFailed;

  // SecureStorage 저장
  const factory ContactInputAction.saveToSecureStarted(ContactEntity contact) =
      SaveToSecureStarted;
  const factory ContactInputAction.saveToSecureSucceeded() =
      SaveToSecureSucceeded;
  const factory ContactInputAction.saveToSecureFailed(AppException error) =
      SaveToSecureFailed;

  // SecureStorage 불러오기
  const factory ContactInputAction.loadFromSecureStarted() =
      LoadFromSecureStarted;
  const factory ContactInputAction.loadFromSecureSucceeded(
    ContactEntity? contact,
  ) = LoadFromSecureSucceeded;
  const factory ContactInputAction.loadFromSecureFailed(AppException error) =
      LoadFromSecureFailed;

  // Drift 저장
  const factory ContactInputAction.saveToDriftStarted(ContactEntity contact) =
      SaveToDriftStarted;
  const factory ContactInputAction.saveToDriftSucceeded() =
      SaveToDriftSucceeded;
  const factory ContactInputAction.saveToDriftFailed(AppException error) =
      SaveToDriftFailed;

  // Drift 불러오기
  const factory ContactInputAction.loadFromDriftStarted() =
      LoadFromDriftStarted;
  const factory ContactInputAction.loadFromDriftSucceeded(
    List<ContactEntity> contacts,
  ) = LoadFromDriftSucceeded;
  const factory ContactInputAction.loadFromDriftFailed(AppException error) =
      LoadFromDriftFailed;
}
