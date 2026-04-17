// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'network_exception.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$NetworkException {
  String get message => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) network,
    required TResult Function(int statusCode, String message) server,
    required TResult Function(String message) unauthorized,
    required TResult Function(String message) forbidden,
    required TResult Function(String message) notFound,
    required TResult Function(String message) timeout,
    required TResult Function(String message) unknown,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? network,
    TResult? Function(int statusCode, String message)? server,
    TResult? Function(String message)? unauthorized,
    TResult? Function(String message)? forbidden,
    TResult? Function(String message)? notFound,
    TResult? Function(String message)? timeout,
    TResult? Function(String message)? unknown,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? network,
    TResult Function(int statusCode, String message)? server,
    TResult Function(String message)? unauthorized,
    TResult Function(String message)? forbidden,
    TResult Function(String message)? notFound,
    TResult Function(String message)? timeout,
    TResult Function(String message)? unknown,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkExceptionNetwork value) network,
    required TResult Function(NetworkExceptionServer value) server,
    required TResult Function(NetworkExceptionUnauthorized value) unauthorized,
    required TResult Function(NetworkExceptionForbidden value) forbidden,
    required TResult Function(NetworkExceptionNotFound value) notFound,
    required TResult Function(NetworkExceptionTimeout value) timeout,
    required TResult Function(NetworkExceptionUnknown value) unknown,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkExceptionNetwork value)? network,
    TResult? Function(NetworkExceptionServer value)? server,
    TResult? Function(NetworkExceptionUnauthorized value)? unauthorized,
    TResult? Function(NetworkExceptionForbidden value)? forbidden,
    TResult? Function(NetworkExceptionNotFound value)? notFound,
    TResult? Function(NetworkExceptionTimeout value)? timeout,
    TResult? Function(NetworkExceptionUnknown value)? unknown,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkExceptionNetwork value)? network,
    TResult Function(NetworkExceptionServer value)? server,
    TResult Function(NetworkExceptionUnauthorized value)? unauthorized,
    TResult Function(NetworkExceptionForbidden value)? forbidden,
    TResult Function(NetworkExceptionNotFound value)? notFound,
    TResult Function(NetworkExceptionTimeout value)? timeout,
    TResult Function(NetworkExceptionUnknown value)? unknown,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;

  /// Create a copy of NetworkException
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NetworkExceptionCopyWith<NetworkException> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NetworkExceptionCopyWith<$Res> {
  factory $NetworkExceptionCopyWith(
    NetworkException value,
    $Res Function(NetworkException) then,
  ) = _$NetworkExceptionCopyWithImpl<$Res, NetworkException>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$NetworkExceptionCopyWithImpl<$Res, $Val extends NetworkException>
    implements $NetworkExceptionCopyWith<$Res> {
  _$NetworkExceptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NetworkException
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _value.copyWith(
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$NetworkExceptionNetworkImplCopyWith<$Res>
    implements $NetworkExceptionCopyWith<$Res> {
  factory _$$NetworkExceptionNetworkImplCopyWith(
    _$NetworkExceptionNetworkImpl value,
    $Res Function(_$NetworkExceptionNetworkImpl) then,
  ) = __$$NetworkExceptionNetworkImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$NetworkExceptionNetworkImplCopyWithImpl<$Res>
    extends _$NetworkExceptionCopyWithImpl<$Res, _$NetworkExceptionNetworkImpl>
    implements _$$NetworkExceptionNetworkImplCopyWith<$Res> {
  __$$NetworkExceptionNetworkImplCopyWithImpl(
    _$NetworkExceptionNetworkImpl _value,
    $Res Function(_$NetworkExceptionNetworkImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NetworkException
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$NetworkExceptionNetworkImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$NetworkExceptionNetworkImpl implements NetworkExceptionNetwork {
  const _$NetworkExceptionNetworkImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'NetworkException.network(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NetworkExceptionNetworkImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of NetworkException
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NetworkExceptionNetworkImplCopyWith<_$NetworkExceptionNetworkImpl>
  get copyWith =>
      __$$NetworkExceptionNetworkImplCopyWithImpl<
        _$NetworkExceptionNetworkImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) network,
    required TResult Function(int statusCode, String message) server,
    required TResult Function(String message) unauthorized,
    required TResult Function(String message) forbidden,
    required TResult Function(String message) notFound,
    required TResult Function(String message) timeout,
    required TResult Function(String message) unknown,
  }) {
    return network(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? network,
    TResult? Function(int statusCode, String message)? server,
    TResult? Function(String message)? unauthorized,
    TResult? Function(String message)? forbidden,
    TResult? Function(String message)? notFound,
    TResult? Function(String message)? timeout,
    TResult? Function(String message)? unknown,
  }) {
    return network?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? network,
    TResult Function(int statusCode, String message)? server,
    TResult Function(String message)? unauthorized,
    TResult Function(String message)? forbidden,
    TResult Function(String message)? notFound,
    TResult Function(String message)? timeout,
    TResult Function(String message)? unknown,
    required TResult orElse(),
  }) {
    if (network != null) {
      return network(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkExceptionNetwork value) network,
    required TResult Function(NetworkExceptionServer value) server,
    required TResult Function(NetworkExceptionUnauthorized value) unauthorized,
    required TResult Function(NetworkExceptionForbidden value) forbidden,
    required TResult Function(NetworkExceptionNotFound value) notFound,
    required TResult Function(NetworkExceptionTimeout value) timeout,
    required TResult Function(NetworkExceptionUnknown value) unknown,
  }) {
    return network(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkExceptionNetwork value)? network,
    TResult? Function(NetworkExceptionServer value)? server,
    TResult? Function(NetworkExceptionUnauthorized value)? unauthorized,
    TResult? Function(NetworkExceptionForbidden value)? forbidden,
    TResult? Function(NetworkExceptionNotFound value)? notFound,
    TResult? Function(NetworkExceptionTimeout value)? timeout,
    TResult? Function(NetworkExceptionUnknown value)? unknown,
  }) {
    return network?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkExceptionNetwork value)? network,
    TResult Function(NetworkExceptionServer value)? server,
    TResult Function(NetworkExceptionUnauthorized value)? unauthorized,
    TResult Function(NetworkExceptionForbidden value)? forbidden,
    TResult Function(NetworkExceptionNotFound value)? notFound,
    TResult Function(NetworkExceptionTimeout value)? timeout,
    TResult Function(NetworkExceptionUnknown value)? unknown,
    required TResult orElse(),
  }) {
    if (network != null) {
      return network(this);
    }
    return orElse();
  }
}

abstract class NetworkExceptionNetwork implements NetworkException {
  const factory NetworkExceptionNetwork(final String message) =
      _$NetworkExceptionNetworkImpl;

  @override
  String get message;

  /// Create a copy of NetworkException
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NetworkExceptionNetworkImplCopyWith<_$NetworkExceptionNetworkImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NetworkExceptionServerImplCopyWith<$Res>
    implements $NetworkExceptionCopyWith<$Res> {
  factory _$$NetworkExceptionServerImplCopyWith(
    _$NetworkExceptionServerImpl value,
    $Res Function(_$NetworkExceptionServerImpl) then,
  ) = __$$NetworkExceptionServerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int statusCode, String message});
}

/// @nodoc
class __$$NetworkExceptionServerImplCopyWithImpl<$Res>
    extends _$NetworkExceptionCopyWithImpl<$Res, _$NetworkExceptionServerImpl>
    implements _$$NetworkExceptionServerImplCopyWith<$Res> {
  __$$NetworkExceptionServerImplCopyWithImpl(
    _$NetworkExceptionServerImpl _value,
    $Res Function(_$NetworkExceptionServerImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NetworkException
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? statusCode = null, Object? message = null}) {
    return _then(
      _$NetworkExceptionServerImpl(
        null == statusCode
            ? _value.statusCode
            : statusCode // ignore: cast_nullable_to_non_nullable
                  as int,
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$NetworkExceptionServerImpl implements NetworkExceptionServer {
  const _$NetworkExceptionServerImpl(this.statusCode, this.message);

  @override
  final int statusCode;
  @override
  final String message;

  @override
  String toString() {
    return 'NetworkException.server(statusCode: $statusCode, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NetworkExceptionServerImpl &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, statusCode, message);

  /// Create a copy of NetworkException
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NetworkExceptionServerImplCopyWith<_$NetworkExceptionServerImpl>
  get copyWith =>
      __$$NetworkExceptionServerImplCopyWithImpl<_$NetworkExceptionServerImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) network,
    required TResult Function(int statusCode, String message) server,
    required TResult Function(String message) unauthorized,
    required TResult Function(String message) forbidden,
    required TResult Function(String message) notFound,
    required TResult Function(String message) timeout,
    required TResult Function(String message) unknown,
  }) {
    return server(statusCode, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? network,
    TResult? Function(int statusCode, String message)? server,
    TResult? Function(String message)? unauthorized,
    TResult? Function(String message)? forbidden,
    TResult? Function(String message)? notFound,
    TResult? Function(String message)? timeout,
    TResult? Function(String message)? unknown,
  }) {
    return server?.call(statusCode, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? network,
    TResult Function(int statusCode, String message)? server,
    TResult Function(String message)? unauthorized,
    TResult Function(String message)? forbidden,
    TResult Function(String message)? notFound,
    TResult Function(String message)? timeout,
    TResult Function(String message)? unknown,
    required TResult orElse(),
  }) {
    if (server != null) {
      return server(statusCode, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkExceptionNetwork value) network,
    required TResult Function(NetworkExceptionServer value) server,
    required TResult Function(NetworkExceptionUnauthorized value) unauthorized,
    required TResult Function(NetworkExceptionForbidden value) forbidden,
    required TResult Function(NetworkExceptionNotFound value) notFound,
    required TResult Function(NetworkExceptionTimeout value) timeout,
    required TResult Function(NetworkExceptionUnknown value) unknown,
  }) {
    return server(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkExceptionNetwork value)? network,
    TResult? Function(NetworkExceptionServer value)? server,
    TResult? Function(NetworkExceptionUnauthorized value)? unauthorized,
    TResult? Function(NetworkExceptionForbidden value)? forbidden,
    TResult? Function(NetworkExceptionNotFound value)? notFound,
    TResult? Function(NetworkExceptionTimeout value)? timeout,
    TResult? Function(NetworkExceptionUnknown value)? unknown,
  }) {
    return server?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkExceptionNetwork value)? network,
    TResult Function(NetworkExceptionServer value)? server,
    TResult Function(NetworkExceptionUnauthorized value)? unauthorized,
    TResult Function(NetworkExceptionForbidden value)? forbidden,
    TResult Function(NetworkExceptionNotFound value)? notFound,
    TResult Function(NetworkExceptionTimeout value)? timeout,
    TResult Function(NetworkExceptionUnknown value)? unknown,
    required TResult orElse(),
  }) {
    if (server != null) {
      return server(this);
    }
    return orElse();
  }
}

abstract class NetworkExceptionServer implements NetworkException {
  const factory NetworkExceptionServer(
    final int statusCode,
    final String message,
  ) = _$NetworkExceptionServerImpl;

  int get statusCode;
  @override
  String get message;

  /// Create a copy of NetworkException
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NetworkExceptionServerImplCopyWith<_$NetworkExceptionServerImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NetworkExceptionUnauthorizedImplCopyWith<$Res>
    implements $NetworkExceptionCopyWith<$Res> {
  factory _$$NetworkExceptionUnauthorizedImplCopyWith(
    _$NetworkExceptionUnauthorizedImpl value,
    $Res Function(_$NetworkExceptionUnauthorizedImpl) then,
  ) = __$$NetworkExceptionUnauthorizedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$NetworkExceptionUnauthorizedImplCopyWithImpl<$Res>
    extends
        _$NetworkExceptionCopyWithImpl<$Res, _$NetworkExceptionUnauthorizedImpl>
    implements _$$NetworkExceptionUnauthorizedImplCopyWith<$Res> {
  __$$NetworkExceptionUnauthorizedImplCopyWithImpl(
    _$NetworkExceptionUnauthorizedImpl _value,
    $Res Function(_$NetworkExceptionUnauthorizedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NetworkException
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$NetworkExceptionUnauthorizedImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$NetworkExceptionUnauthorizedImpl
    implements NetworkExceptionUnauthorized {
  const _$NetworkExceptionUnauthorizedImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'NetworkException.unauthorized(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NetworkExceptionUnauthorizedImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of NetworkException
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NetworkExceptionUnauthorizedImplCopyWith<
    _$NetworkExceptionUnauthorizedImpl
  >
  get copyWith =>
      __$$NetworkExceptionUnauthorizedImplCopyWithImpl<
        _$NetworkExceptionUnauthorizedImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) network,
    required TResult Function(int statusCode, String message) server,
    required TResult Function(String message) unauthorized,
    required TResult Function(String message) forbidden,
    required TResult Function(String message) notFound,
    required TResult Function(String message) timeout,
    required TResult Function(String message) unknown,
  }) {
    return unauthorized(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? network,
    TResult? Function(int statusCode, String message)? server,
    TResult? Function(String message)? unauthorized,
    TResult? Function(String message)? forbidden,
    TResult? Function(String message)? notFound,
    TResult? Function(String message)? timeout,
    TResult? Function(String message)? unknown,
  }) {
    return unauthorized?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? network,
    TResult Function(int statusCode, String message)? server,
    TResult Function(String message)? unauthorized,
    TResult Function(String message)? forbidden,
    TResult Function(String message)? notFound,
    TResult Function(String message)? timeout,
    TResult Function(String message)? unknown,
    required TResult orElse(),
  }) {
    if (unauthorized != null) {
      return unauthorized(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkExceptionNetwork value) network,
    required TResult Function(NetworkExceptionServer value) server,
    required TResult Function(NetworkExceptionUnauthorized value) unauthorized,
    required TResult Function(NetworkExceptionForbidden value) forbidden,
    required TResult Function(NetworkExceptionNotFound value) notFound,
    required TResult Function(NetworkExceptionTimeout value) timeout,
    required TResult Function(NetworkExceptionUnknown value) unknown,
  }) {
    return unauthorized(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkExceptionNetwork value)? network,
    TResult? Function(NetworkExceptionServer value)? server,
    TResult? Function(NetworkExceptionUnauthorized value)? unauthorized,
    TResult? Function(NetworkExceptionForbidden value)? forbidden,
    TResult? Function(NetworkExceptionNotFound value)? notFound,
    TResult? Function(NetworkExceptionTimeout value)? timeout,
    TResult? Function(NetworkExceptionUnknown value)? unknown,
  }) {
    return unauthorized?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkExceptionNetwork value)? network,
    TResult Function(NetworkExceptionServer value)? server,
    TResult Function(NetworkExceptionUnauthorized value)? unauthorized,
    TResult Function(NetworkExceptionForbidden value)? forbidden,
    TResult Function(NetworkExceptionNotFound value)? notFound,
    TResult Function(NetworkExceptionTimeout value)? timeout,
    TResult Function(NetworkExceptionUnknown value)? unknown,
    required TResult orElse(),
  }) {
    if (unauthorized != null) {
      return unauthorized(this);
    }
    return orElse();
  }
}

abstract class NetworkExceptionUnauthorized implements NetworkException {
  const factory NetworkExceptionUnauthorized(final String message) =
      _$NetworkExceptionUnauthorizedImpl;

  @override
  String get message;

  /// Create a copy of NetworkException
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NetworkExceptionUnauthorizedImplCopyWith<
    _$NetworkExceptionUnauthorizedImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NetworkExceptionForbiddenImplCopyWith<$Res>
    implements $NetworkExceptionCopyWith<$Res> {
  factory _$$NetworkExceptionForbiddenImplCopyWith(
    _$NetworkExceptionForbiddenImpl value,
    $Res Function(_$NetworkExceptionForbiddenImpl) then,
  ) = __$$NetworkExceptionForbiddenImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$NetworkExceptionForbiddenImplCopyWithImpl<$Res>
    extends
        _$NetworkExceptionCopyWithImpl<$Res, _$NetworkExceptionForbiddenImpl>
    implements _$$NetworkExceptionForbiddenImplCopyWith<$Res> {
  __$$NetworkExceptionForbiddenImplCopyWithImpl(
    _$NetworkExceptionForbiddenImpl _value,
    $Res Function(_$NetworkExceptionForbiddenImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NetworkException
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$NetworkExceptionForbiddenImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$NetworkExceptionForbiddenImpl implements NetworkExceptionForbidden {
  const _$NetworkExceptionForbiddenImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'NetworkException.forbidden(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NetworkExceptionForbiddenImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of NetworkException
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NetworkExceptionForbiddenImplCopyWith<_$NetworkExceptionForbiddenImpl>
  get copyWith =>
      __$$NetworkExceptionForbiddenImplCopyWithImpl<
        _$NetworkExceptionForbiddenImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) network,
    required TResult Function(int statusCode, String message) server,
    required TResult Function(String message) unauthorized,
    required TResult Function(String message) forbidden,
    required TResult Function(String message) notFound,
    required TResult Function(String message) timeout,
    required TResult Function(String message) unknown,
  }) {
    return forbidden(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? network,
    TResult? Function(int statusCode, String message)? server,
    TResult? Function(String message)? unauthorized,
    TResult? Function(String message)? forbidden,
    TResult? Function(String message)? notFound,
    TResult? Function(String message)? timeout,
    TResult? Function(String message)? unknown,
  }) {
    return forbidden?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? network,
    TResult Function(int statusCode, String message)? server,
    TResult Function(String message)? unauthorized,
    TResult Function(String message)? forbidden,
    TResult Function(String message)? notFound,
    TResult Function(String message)? timeout,
    TResult Function(String message)? unknown,
    required TResult orElse(),
  }) {
    if (forbidden != null) {
      return forbidden(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkExceptionNetwork value) network,
    required TResult Function(NetworkExceptionServer value) server,
    required TResult Function(NetworkExceptionUnauthorized value) unauthorized,
    required TResult Function(NetworkExceptionForbidden value) forbidden,
    required TResult Function(NetworkExceptionNotFound value) notFound,
    required TResult Function(NetworkExceptionTimeout value) timeout,
    required TResult Function(NetworkExceptionUnknown value) unknown,
  }) {
    return forbidden(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkExceptionNetwork value)? network,
    TResult? Function(NetworkExceptionServer value)? server,
    TResult? Function(NetworkExceptionUnauthorized value)? unauthorized,
    TResult? Function(NetworkExceptionForbidden value)? forbidden,
    TResult? Function(NetworkExceptionNotFound value)? notFound,
    TResult? Function(NetworkExceptionTimeout value)? timeout,
    TResult? Function(NetworkExceptionUnknown value)? unknown,
  }) {
    return forbidden?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkExceptionNetwork value)? network,
    TResult Function(NetworkExceptionServer value)? server,
    TResult Function(NetworkExceptionUnauthorized value)? unauthorized,
    TResult Function(NetworkExceptionForbidden value)? forbidden,
    TResult Function(NetworkExceptionNotFound value)? notFound,
    TResult Function(NetworkExceptionTimeout value)? timeout,
    TResult Function(NetworkExceptionUnknown value)? unknown,
    required TResult orElse(),
  }) {
    if (forbidden != null) {
      return forbidden(this);
    }
    return orElse();
  }
}

abstract class NetworkExceptionForbidden implements NetworkException {
  const factory NetworkExceptionForbidden(final String message) =
      _$NetworkExceptionForbiddenImpl;

  @override
  String get message;

  /// Create a copy of NetworkException
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NetworkExceptionForbiddenImplCopyWith<_$NetworkExceptionForbiddenImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NetworkExceptionNotFoundImplCopyWith<$Res>
    implements $NetworkExceptionCopyWith<$Res> {
  factory _$$NetworkExceptionNotFoundImplCopyWith(
    _$NetworkExceptionNotFoundImpl value,
    $Res Function(_$NetworkExceptionNotFoundImpl) then,
  ) = __$$NetworkExceptionNotFoundImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$NetworkExceptionNotFoundImplCopyWithImpl<$Res>
    extends _$NetworkExceptionCopyWithImpl<$Res, _$NetworkExceptionNotFoundImpl>
    implements _$$NetworkExceptionNotFoundImplCopyWith<$Res> {
  __$$NetworkExceptionNotFoundImplCopyWithImpl(
    _$NetworkExceptionNotFoundImpl _value,
    $Res Function(_$NetworkExceptionNotFoundImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NetworkException
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$NetworkExceptionNotFoundImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$NetworkExceptionNotFoundImpl implements NetworkExceptionNotFound {
  const _$NetworkExceptionNotFoundImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'NetworkException.notFound(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NetworkExceptionNotFoundImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of NetworkException
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NetworkExceptionNotFoundImplCopyWith<_$NetworkExceptionNotFoundImpl>
  get copyWith =>
      __$$NetworkExceptionNotFoundImplCopyWithImpl<
        _$NetworkExceptionNotFoundImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) network,
    required TResult Function(int statusCode, String message) server,
    required TResult Function(String message) unauthorized,
    required TResult Function(String message) forbidden,
    required TResult Function(String message) notFound,
    required TResult Function(String message) timeout,
    required TResult Function(String message) unknown,
  }) {
    return notFound(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? network,
    TResult? Function(int statusCode, String message)? server,
    TResult? Function(String message)? unauthorized,
    TResult? Function(String message)? forbidden,
    TResult? Function(String message)? notFound,
    TResult? Function(String message)? timeout,
    TResult? Function(String message)? unknown,
  }) {
    return notFound?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? network,
    TResult Function(int statusCode, String message)? server,
    TResult Function(String message)? unauthorized,
    TResult Function(String message)? forbidden,
    TResult Function(String message)? notFound,
    TResult Function(String message)? timeout,
    TResult Function(String message)? unknown,
    required TResult orElse(),
  }) {
    if (notFound != null) {
      return notFound(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkExceptionNetwork value) network,
    required TResult Function(NetworkExceptionServer value) server,
    required TResult Function(NetworkExceptionUnauthorized value) unauthorized,
    required TResult Function(NetworkExceptionForbidden value) forbidden,
    required TResult Function(NetworkExceptionNotFound value) notFound,
    required TResult Function(NetworkExceptionTimeout value) timeout,
    required TResult Function(NetworkExceptionUnknown value) unknown,
  }) {
    return notFound(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkExceptionNetwork value)? network,
    TResult? Function(NetworkExceptionServer value)? server,
    TResult? Function(NetworkExceptionUnauthorized value)? unauthorized,
    TResult? Function(NetworkExceptionForbidden value)? forbidden,
    TResult? Function(NetworkExceptionNotFound value)? notFound,
    TResult? Function(NetworkExceptionTimeout value)? timeout,
    TResult? Function(NetworkExceptionUnknown value)? unknown,
  }) {
    return notFound?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkExceptionNetwork value)? network,
    TResult Function(NetworkExceptionServer value)? server,
    TResult Function(NetworkExceptionUnauthorized value)? unauthorized,
    TResult Function(NetworkExceptionForbidden value)? forbidden,
    TResult Function(NetworkExceptionNotFound value)? notFound,
    TResult Function(NetworkExceptionTimeout value)? timeout,
    TResult Function(NetworkExceptionUnknown value)? unknown,
    required TResult orElse(),
  }) {
    if (notFound != null) {
      return notFound(this);
    }
    return orElse();
  }
}

abstract class NetworkExceptionNotFound implements NetworkException {
  const factory NetworkExceptionNotFound(final String message) =
      _$NetworkExceptionNotFoundImpl;

  @override
  String get message;

  /// Create a copy of NetworkException
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NetworkExceptionNotFoundImplCopyWith<_$NetworkExceptionNotFoundImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NetworkExceptionTimeoutImplCopyWith<$Res>
    implements $NetworkExceptionCopyWith<$Res> {
  factory _$$NetworkExceptionTimeoutImplCopyWith(
    _$NetworkExceptionTimeoutImpl value,
    $Res Function(_$NetworkExceptionTimeoutImpl) then,
  ) = __$$NetworkExceptionTimeoutImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$NetworkExceptionTimeoutImplCopyWithImpl<$Res>
    extends _$NetworkExceptionCopyWithImpl<$Res, _$NetworkExceptionTimeoutImpl>
    implements _$$NetworkExceptionTimeoutImplCopyWith<$Res> {
  __$$NetworkExceptionTimeoutImplCopyWithImpl(
    _$NetworkExceptionTimeoutImpl _value,
    $Res Function(_$NetworkExceptionTimeoutImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NetworkException
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$NetworkExceptionTimeoutImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$NetworkExceptionTimeoutImpl implements NetworkExceptionTimeout {
  const _$NetworkExceptionTimeoutImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'NetworkException.timeout(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NetworkExceptionTimeoutImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of NetworkException
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NetworkExceptionTimeoutImplCopyWith<_$NetworkExceptionTimeoutImpl>
  get copyWith =>
      __$$NetworkExceptionTimeoutImplCopyWithImpl<
        _$NetworkExceptionTimeoutImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) network,
    required TResult Function(int statusCode, String message) server,
    required TResult Function(String message) unauthorized,
    required TResult Function(String message) forbidden,
    required TResult Function(String message) notFound,
    required TResult Function(String message) timeout,
    required TResult Function(String message) unknown,
  }) {
    return timeout(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? network,
    TResult? Function(int statusCode, String message)? server,
    TResult? Function(String message)? unauthorized,
    TResult? Function(String message)? forbidden,
    TResult? Function(String message)? notFound,
    TResult? Function(String message)? timeout,
    TResult? Function(String message)? unknown,
  }) {
    return timeout?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? network,
    TResult Function(int statusCode, String message)? server,
    TResult Function(String message)? unauthorized,
    TResult Function(String message)? forbidden,
    TResult Function(String message)? notFound,
    TResult Function(String message)? timeout,
    TResult Function(String message)? unknown,
    required TResult orElse(),
  }) {
    if (timeout != null) {
      return timeout(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkExceptionNetwork value) network,
    required TResult Function(NetworkExceptionServer value) server,
    required TResult Function(NetworkExceptionUnauthorized value) unauthorized,
    required TResult Function(NetworkExceptionForbidden value) forbidden,
    required TResult Function(NetworkExceptionNotFound value) notFound,
    required TResult Function(NetworkExceptionTimeout value) timeout,
    required TResult Function(NetworkExceptionUnknown value) unknown,
  }) {
    return timeout(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkExceptionNetwork value)? network,
    TResult? Function(NetworkExceptionServer value)? server,
    TResult? Function(NetworkExceptionUnauthorized value)? unauthorized,
    TResult? Function(NetworkExceptionForbidden value)? forbidden,
    TResult? Function(NetworkExceptionNotFound value)? notFound,
    TResult? Function(NetworkExceptionTimeout value)? timeout,
    TResult? Function(NetworkExceptionUnknown value)? unknown,
  }) {
    return timeout?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkExceptionNetwork value)? network,
    TResult Function(NetworkExceptionServer value)? server,
    TResult Function(NetworkExceptionUnauthorized value)? unauthorized,
    TResult Function(NetworkExceptionForbidden value)? forbidden,
    TResult Function(NetworkExceptionNotFound value)? notFound,
    TResult Function(NetworkExceptionTimeout value)? timeout,
    TResult Function(NetworkExceptionUnknown value)? unknown,
    required TResult orElse(),
  }) {
    if (timeout != null) {
      return timeout(this);
    }
    return orElse();
  }
}

abstract class NetworkExceptionTimeout implements NetworkException {
  const factory NetworkExceptionTimeout(final String message) =
      _$NetworkExceptionTimeoutImpl;

  @override
  String get message;

  /// Create a copy of NetworkException
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NetworkExceptionTimeoutImplCopyWith<_$NetworkExceptionTimeoutImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NetworkExceptionUnknownImplCopyWith<$Res>
    implements $NetworkExceptionCopyWith<$Res> {
  factory _$$NetworkExceptionUnknownImplCopyWith(
    _$NetworkExceptionUnknownImpl value,
    $Res Function(_$NetworkExceptionUnknownImpl) then,
  ) = __$$NetworkExceptionUnknownImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$NetworkExceptionUnknownImplCopyWithImpl<$Res>
    extends _$NetworkExceptionCopyWithImpl<$Res, _$NetworkExceptionUnknownImpl>
    implements _$$NetworkExceptionUnknownImplCopyWith<$Res> {
  __$$NetworkExceptionUnknownImplCopyWithImpl(
    _$NetworkExceptionUnknownImpl _value,
    $Res Function(_$NetworkExceptionUnknownImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NetworkException
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$NetworkExceptionUnknownImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$NetworkExceptionUnknownImpl implements NetworkExceptionUnknown {
  const _$NetworkExceptionUnknownImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'NetworkException.unknown(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NetworkExceptionUnknownImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of NetworkException
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NetworkExceptionUnknownImplCopyWith<_$NetworkExceptionUnknownImpl>
  get copyWith =>
      __$$NetworkExceptionUnknownImplCopyWithImpl<
        _$NetworkExceptionUnknownImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) network,
    required TResult Function(int statusCode, String message) server,
    required TResult Function(String message) unauthorized,
    required TResult Function(String message) forbidden,
    required TResult Function(String message) notFound,
    required TResult Function(String message) timeout,
    required TResult Function(String message) unknown,
  }) {
    return unknown(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? network,
    TResult? Function(int statusCode, String message)? server,
    TResult? Function(String message)? unauthorized,
    TResult? Function(String message)? forbidden,
    TResult? Function(String message)? notFound,
    TResult? Function(String message)? timeout,
    TResult? Function(String message)? unknown,
  }) {
    return unknown?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? network,
    TResult Function(int statusCode, String message)? server,
    TResult Function(String message)? unauthorized,
    TResult Function(String message)? forbidden,
    TResult Function(String message)? notFound,
    TResult Function(String message)? timeout,
    TResult Function(String message)? unknown,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkExceptionNetwork value) network,
    required TResult Function(NetworkExceptionServer value) server,
    required TResult Function(NetworkExceptionUnauthorized value) unauthorized,
    required TResult Function(NetworkExceptionForbidden value) forbidden,
    required TResult Function(NetworkExceptionNotFound value) notFound,
    required TResult Function(NetworkExceptionTimeout value) timeout,
    required TResult Function(NetworkExceptionUnknown value) unknown,
  }) {
    return unknown(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkExceptionNetwork value)? network,
    TResult? Function(NetworkExceptionServer value)? server,
    TResult? Function(NetworkExceptionUnauthorized value)? unauthorized,
    TResult? Function(NetworkExceptionForbidden value)? forbidden,
    TResult? Function(NetworkExceptionNotFound value)? notFound,
    TResult? Function(NetworkExceptionTimeout value)? timeout,
    TResult? Function(NetworkExceptionUnknown value)? unknown,
  }) {
    return unknown?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkExceptionNetwork value)? network,
    TResult Function(NetworkExceptionServer value)? server,
    TResult Function(NetworkExceptionUnauthorized value)? unauthorized,
    TResult Function(NetworkExceptionForbidden value)? forbidden,
    TResult Function(NetworkExceptionNotFound value)? notFound,
    TResult Function(NetworkExceptionTimeout value)? timeout,
    TResult Function(NetworkExceptionUnknown value)? unknown,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(this);
    }
    return orElse();
  }
}

abstract class NetworkExceptionUnknown implements NetworkException {
  const factory NetworkExceptionUnknown(final String message) =
      _$NetworkExceptionUnknownImpl;

  @override
  String get message;

  /// Create a copy of NetworkException
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NetworkExceptionUnknownImplCopyWith<_$NetworkExceptionUnknownImpl>
  get copyWith => throw _privateConstructorUsedError;
}
