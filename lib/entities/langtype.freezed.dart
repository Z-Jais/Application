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
      _$LangTypeCopyWithImpl<$Res>;

  $Res call({String uuid, String name});
}

/// @nodoc
class _$LangTypeCopyWithImpl<$Res> implements $LangTypeCopyWith<$Res> {
  _$LangTypeCopyWithImpl(this._value, this._then);

  final LangType _value;

  // ignore: unused_field
  final $Res Function(LangType) _then;

  @override
  $Res call({
    Object? uuid = freezed,
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      uuid: uuid == freezed
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_LangTypeCopyWith<$Res> implements $LangTypeCopyWith<$Res> {
  factory _$$_LangTypeCopyWith(
          _$_LangType value, $Res Function(_$_LangType) then) =
      __$$_LangTypeCopyWithImpl<$Res>;

  @override
  $Res call({String uuid, String name});
}

/// @nodoc
class __$$_LangTypeCopyWithImpl<$Res> extends _$LangTypeCopyWithImpl<$Res>
    implements _$$_LangTypeCopyWith<$Res> {
  __$$_LangTypeCopyWithImpl(
      _$_LangType _value, $Res Function(_$_LangType) _then)
      : super(_value, (v) => _then(v as _$_LangType));

  @override
  _$_LangType get _value => super._value as _$_LangType;

  @override
  $Res call({
    Object? uuid = freezed,
    Object? name = freezed,
  }) {
    return _then(_$_LangType(
      uuid: uuid == freezed
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
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
            const DeepCollectionEquality().equals(other.uuid, uuid) &&
            const DeepCollectionEquality().equals(other.name, name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(uuid),
      const DeepCollectionEquality().hash(name));

  @JsonKey(ignore: true)
  @override
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
