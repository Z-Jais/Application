// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'langtype.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

LangType _$LangTypeFromJson(Map<String, dynamic> json) {
  return _LangType.fromJson(json);
}

/// @nodoc
mixin _$LangType {
  String get uuid => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LangTypeCopyWith<LangType> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LangTypeCopyWith<$Res> {
  factory $LangTypeCopyWith(LangType value, $Res Function(LangType) then) =
      _$LangTypeCopyWithImpl<$Res, LangType>;
  @useResult
  $Res call({String uuid, String name});
}

/// @nodoc
class _$LangTypeCopyWithImpl<$Res, $Val extends LangType>
    implements $LangTypeCopyWith<$Res> {
  _$LangTypeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uuid = null,
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      uuid: null == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_LangTypeCopyWith<$Res> implements $LangTypeCopyWith<$Res> {
  factory _$$_LangTypeCopyWith(
          _$_LangType value, $Res Function(_$_LangType) then) =
      __$$_LangTypeCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String uuid, String name});
}

/// @nodoc
class __$$_LangTypeCopyWithImpl<$Res>
    extends _$LangTypeCopyWithImpl<$Res, _$_LangType>
    implements _$$_LangTypeCopyWith<$Res> {
  __$$_LangTypeCopyWithImpl(
      _$_LangType _value, $Res Function(_$_LangType) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uuid = null,
    Object? name = null,
  }) {
    return _then(_$_LangType(
      uuid: null == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_LangType implements _LangType {
  const _$_LangType({required this.uuid, required this.name});

  factory _$_LangType.fromJson(Map<String, dynamic> json) =>
      _$$_LangTypeFromJson(json);

  @override
  final String uuid;
  @override
  final String name;

  @override
  String toString() {
    return 'LangType(uuid: $uuid, name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LangType &&
            (identical(other.uuid, uuid) || other.uuid == uuid) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, uuid, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LangTypeCopyWith<_$_LangType> get copyWith =>
      __$$_LangTypeCopyWithImpl<_$_LangType>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LangTypeToJson(
      this,
    );
  }
}

abstract class _LangType implements LangType {
  const factory _LangType(
      {required final String uuid, required final String name}) = _$_LangType;

  factory _LangType.fromJson(Map<String, dynamic> json) = _$_LangType.fromJson;

  @override
  String get uuid;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$_LangTypeCopyWith<_$_LangType> get copyWith =>
      throw _privateConstructorUsedError;
}
