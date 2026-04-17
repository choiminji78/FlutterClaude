// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'contact_input_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ContactInputState {
  bool get isLoading => throw _privateConstructorUsedError;
  AppException? get error => throw _privateConstructorUsedError;
  String get nameInput => throw _privateConstructorUsedError;
  String get phoneInput =>
      throw _privateConstructorUsedError; // SharedPreferences에서 불러온 값
  ContactEntity? get prefsLoadedContact =>
      throw _privateConstructorUsedError; // SecureStorage에서 불러온 값
  ContactEntity? get secureLoadedContact =>
      throw _privateConstructorUsedError; // Drift에서 불러온 연락처 목록
  List<ContactEntity> get driftLoadedContacts =>
      throw _privateConstructorUsedError;

  /// Create a copy of ContactInputState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ContactInputStateCopyWith<ContactInputState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContactInputStateCopyWith<$Res> {
  factory $ContactInputStateCopyWith(
    ContactInputState value,
    $Res Function(ContactInputState) then,
  ) = _$ContactInputStateCopyWithImpl<$Res, ContactInputState>;
  @useResult
  $Res call({
    bool isLoading,
    AppException? error,
    String nameInput,
    String phoneInput,
    ContactEntity? prefsLoadedContact,
    ContactEntity? secureLoadedContact,
    List<ContactEntity> driftLoadedContacts,
  });

  $AppExceptionCopyWith<$Res>? get error;
  $ContactEntityCopyWith<$Res>? get prefsLoadedContact;
  $ContactEntityCopyWith<$Res>? get secureLoadedContact;
}

/// @nodoc
class _$ContactInputStateCopyWithImpl<$Res, $Val extends ContactInputState>
    implements $ContactInputStateCopyWith<$Res> {
  _$ContactInputStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ContactInputState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? error = freezed,
    Object? nameInput = null,
    Object? phoneInput = null,
    Object? prefsLoadedContact = freezed,
    Object? secureLoadedContact = freezed,
    Object? driftLoadedContacts = null,
  }) {
    return _then(
      _value.copyWith(
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            error: freezed == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                      as AppException?,
            nameInput: null == nameInput
                ? _value.nameInput
                : nameInput // ignore: cast_nullable_to_non_nullable
                      as String,
            phoneInput: null == phoneInput
                ? _value.phoneInput
                : phoneInput // ignore: cast_nullable_to_non_nullable
                      as String,
            prefsLoadedContact: freezed == prefsLoadedContact
                ? _value.prefsLoadedContact
                : prefsLoadedContact // ignore: cast_nullable_to_non_nullable
                      as ContactEntity?,
            secureLoadedContact: freezed == secureLoadedContact
                ? _value.secureLoadedContact
                : secureLoadedContact // ignore: cast_nullable_to_non_nullable
                      as ContactEntity?,
            driftLoadedContacts: null == driftLoadedContacts
                ? _value.driftLoadedContacts
                : driftLoadedContacts // ignore: cast_nullable_to_non_nullable
                      as List<ContactEntity>,
          )
          as $Val,
    );
  }

  /// Create a copy of ContactInputState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AppExceptionCopyWith<$Res>? get error {
    if (_value.error == null) {
      return null;
    }

    return $AppExceptionCopyWith<$Res>(_value.error!, (value) {
      return _then(_value.copyWith(error: value) as $Val);
    });
  }

  /// Create a copy of ContactInputState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ContactEntityCopyWith<$Res>? get prefsLoadedContact {
    if (_value.prefsLoadedContact == null) {
      return null;
    }

    return $ContactEntityCopyWith<$Res>(_value.prefsLoadedContact!, (value) {
      return _then(_value.copyWith(prefsLoadedContact: value) as $Val);
    });
  }

  /// Create a copy of ContactInputState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ContactEntityCopyWith<$Res>? get secureLoadedContact {
    if (_value.secureLoadedContact == null) {
      return null;
    }

    return $ContactEntityCopyWith<$Res>(_value.secureLoadedContact!, (value) {
      return _then(_value.copyWith(secureLoadedContact: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ContactInputStateImplCopyWith<$Res>
    implements $ContactInputStateCopyWith<$Res> {
  factory _$$ContactInputStateImplCopyWith(
    _$ContactInputStateImpl value,
    $Res Function(_$ContactInputStateImpl) then,
  ) = __$$ContactInputStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool isLoading,
    AppException? error,
    String nameInput,
    String phoneInput,
    ContactEntity? prefsLoadedContact,
    ContactEntity? secureLoadedContact,
    List<ContactEntity> driftLoadedContacts,
  });

  @override
  $AppExceptionCopyWith<$Res>? get error;
  @override
  $ContactEntityCopyWith<$Res>? get prefsLoadedContact;
  @override
  $ContactEntityCopyWith<$Res>? get secureLoadedContact;
}

/// @nodoc
class __$$ContactInputStateImplCopyWithImpl<$Res>
    extends _$ContactInputStateCopyWithImpl<$Res, _$ContactInputStateImpl>
    implements _$$ContactInputStateImplCopyWith<$Res> {
  __$$ContactInputStateImplCopyWithImpl(
    _$ContactInputStateImpl _value,
    $Res Function(_$ContactInputStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ContactInputState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? error = freezed,
    Object? nameInput = null,
    Object? phoneInput = null,
    Object? prefsLoadedContact = freezed,
    Object? secureLoadedContact = freezed,
    Object? driftLoadedContacts = null,
  }) {
    return _then(
      _$ContactInputStateImpl(
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        error: freezed == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as AppException?,
        nameInput: null == nameInput
            ? _value.nameInput
            : nameInput // ignore: cast_nullable_to_non_nullable
                  as String,
        phoneInput: null == phoneInput
            ? _value.phoneInput
            : phoneInput // ignore: cast_nullable_to_non_nullable
                  as String,
        prefsLoadedContact: freezed == prefsLoadedContact
            ? _value.prefsLoadedContact
            : prefsLoadedContact // ignore: cast_nullable_to_non_nullable
                  as ContactEntity?,
        secureLoadedContact: freezed == secureLoadedContact
            ? _value.secureLoadedContact
            : secureLoadedContact // ignore: cast_nullable_to_non_nullable
                  as ContactEntity?,
        driftLoadedContacts: null == driftLoadedContacts
            ? _value._driftLoadedContacts
            : driftLoadedContacts // ignore: cast_nullable_to_non_nullable
                  as List<ContactEntity>,
      ),
    );
  }
}

/// @nodoc

class _$ContactInputStateImpl implements _ContactInputState {
  const _$ContactInputStateImpl({
    this.isLoading = false,
    this.error = null,
    this.nameInput = '',
    this.phoneInput = '',
    this.prefsLoadedContact = null,
    this.secureLoadedContact = null,
    final List<ContactEntity> driftLoadedContacts = const [],
  }) : _driftLoadedContacts = driftLoadedContacts;

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final AppException? error;
  @override
  @JsonKey()
  final String nameInput;
  @override
  @JsonKey()
  final String phoneInput;
  // SharedPreferences에서 불러온 값
  @override
  @JsonKey()
  final ContactEntity? prefsLoadedContact;
  // SecureStorage에서 불러온 값
  @override
  @JsonKey()
  final ContactEntity? secureLoadedContact;
  // Drift에서 불러온 연락처 목록
  final List<ContactEntity> _driftLoadedContacts;
  // Drift에서 불러온 연락처 목록
  @override
  @JsonKey()
  List<ContactEntity> get driftLoadedContacts {
    if (_driftLoadedContacts is EqualUnmodifiableListView)
      return _driftLoadedContacts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_driftLoadedContacts);
  }

  @override
  String toString() {
    return 'ContactInputState(isLoading: $isLoading, error: $error, nameInput: $nameInput, phoneInput: $phoneInput, prefsLoadedContact: $prefsLoadedContact, secureLoadedContact: $secureLoadedContact, driftLoadedContacts: $driftLoadedContacts)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContactInputStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.nameInput, nameInput) ||
                other.nameInput == nameInput) &&
            (identical(other.phoneInput, phoneInput) ||
                other.phoneInput == phoneInput) &&
            (identical(other.prefsLoadedContact, prefsLoadedContact) ||
                other.prefsLoadedContact == prefsLoadedContact) &&
            (identical(other.secureLoadedContact, secureLoadedContact) ||
                other.secureLoadedContact == secureLoadedContact) &&
            const DeepCollectionEquality().equals(
              other._driftLoadedContacts,
              _driftLoadedContacts,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    isLoading,
    error,
    nameInput,
    phoneInput,
    prefsLoadedContact,
    secureLoadedContact,
    const DeepCollectionEquality().hash(_driftLoadedContacts),
  );

  /// Create a copy of ContactInputState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ContactInputStateImplCopyWith<_$ContactInputStateImpl> get copyWith =>
      __$$ContactInputStateImplCopyWithImpl<_$ContactInputStateImpl>(
        this,
        _$identity,
      );
}

abstract class _ContactInputState implements ContactInputState {
  const factory _ContactInputState({
    final bool isLoading,
    final AppException? error,
    final String nameInput,
    final String phoneInput,
    final ContactEntity? prefsLoadedContact,
    final ContactEntity? secureLoadedContact,
    final List<ContactEntity> driftLoadedContacts,
  }) = _$ContactInputStateImpl;

  @override
  bool get isLoading;
  @override
  AppException? get error;
  @override
  String get nameInput;
  @override
  String get phoneInput; // SharedPreferences에서 불러온 값
  @override
  ContactEntity? get prefsLoadedContact; // SecureStorage에서 불러온 값
  @override
  ContactEntity? get secureLoadedContact; // Drift에서 불러온 연락처 목록
  @override
  List<ContactEntity> get driftLoadedContacts;

  /// Create a copy of ContactInputState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ContactInputStateImplCopyWith<_$ContactInputStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
