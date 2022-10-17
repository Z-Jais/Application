// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'episodetype.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

EpisodeType _$EpisodeTypeFromJson(Map<String, dynamic> json) {
  return _EpisodeType.fromJson(json);
}

/// @nodoc
mixin _$EpisodeType {
  String get uuid => throw _privateConstructorUsedError;

  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $EpisodeTypeCopyWith<EpisodeType> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EpisodeTypeCopyWith<$Res> {
  factory $EpisodeTypeCopyWith(
          EpisodeType value, $Res Function(EpisodeType) then) =
      _$EpisodeTypeCopyWithImpl<$Res, EpisodeType>;

  @useResult
  $Res call({String uuid, String name});
}

/// @nodoc
class _$EpisodeTypeCopyWithImpl<$Res, $Val extends EpisodeType>
    implements $EpisodeTypeCopyWith<$Res> {
  _$EpisodeTypeCopyWithImpl(this._value, this._then);

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
abstract class _$$_EpisodeTypeCopyWith<$Res>
    implements $EpisodeTypeCopyWith<$Res> {
  factory _$$_EpisodeTypeCopyWith(
          _$_EpisodeType value, $Res Function(_$_EpisodeType) then) =
      __$$_EpisodeTypeCopyWithImpl<$Res>;

  @override
  @useResult
  $Res call({String uuid, String name});
}

/// @nodoc
class __$$_EpisodeTypeCopyWithImpl<$Res>
    extends _$EpisodeTypeCopyWithImpl<$Res, _$_EpisodeType>
    implements _$$_EpisodeTypeCopyWith<$Res> {
  __$$_EpisodeTypeCopyWithImpl(
      _$_EpisodeType _value, $Res Function(_$_EpisodeType) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uuid = null,
    Object? name = null,
  }) {
    return _then(_$_EpisodeType(
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
class _$_EpisodeType implements _EpisodeType {
  const _$_EpisodeType({required this.uuid, required this.name});

  factory _$_EpisodeType.fromJson(Map<String, dynamic> json) =>
      _$$_EpisodeTypeFromJson(json);

  @override
  final String uuid;
  @override
  final String name;

  @override
  String toString() {
    return 'EpisodeType(uuid: $uuid, name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EpisodeType &&
            (identical(other.uuid, uuid) || other.uuid == uuid) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, uuid, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_EpisodeTypeCopyWith<_$_EpisodeType> get copyWith =>
      __$$_EpisodeTypeCopyWithImpl<_$_EpisodeType>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_EpisodeTypeToJson(
      this,
    );
  }
}

abstract class _EpisodeType implements EpisodeType {
  const factory _EpisodeType(
      {required final String uuid,
      required final String name}) = _$_EpisodeType;

  factory _EpisodeType.fromJson(Map<String, dynamic> json) =
      _$_EpisodeType.fromJson;

  @override
  String get uuid;

  @override
  String get name;

  @override
  @JsonKey(ignore: true)
  _$$_EpisodeTypeCopyWith<_$_EpisodeType> get copyWith =>
      throw _privateConstructorUsedError;
}
