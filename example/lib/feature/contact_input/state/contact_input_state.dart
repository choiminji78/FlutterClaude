import 'package:flutter_claude/domain/common/exception/app_exception.dart';
import 'package:flutter_claude/domain/contact/entity/contact_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact_input_state.freezed.dart';

@freezed
class ContactInputState with _$ContactInputState {
  const factory ContactInputState({
    @Default(false) bool isLoading,
    @Default(null) AppException? error,
    @Default('') String nameInput,
    @Default('') String phoneInput,
    // SharedPreferences에서 불러온 값
    @Default(null) ContactEntity? prefsLoadedContact,
    // SecureStorage에서 불러온 값
    @Default(null) ContactEntity? secureLoadedContact,
    // Drift에서 불러온 연락처 목록
    @Default([]) List<ContactEntity> driftLoadedContacts,
  }) = _ContactInputState;
}
