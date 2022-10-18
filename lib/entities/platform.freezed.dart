// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'platform.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Platform _$PlatformFromJson(Map<String, dynamic> json) {
  return _Platform.fromJson(json);
}

/// @nodoc
mixin _$Platform {
  String get uuid => throw _privateConstructorUsedError;

  String get name => throw _privateConstructorUsedError;

  String get url => throw _privateConstructorUsedError;

  String get image => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PlatformCopyWith<Platform> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlatformCopyWith<$Res> {
  factory $PlatformCopyWith(Platform value, $Res Function(Platform) then) =
      _$PlatformCopyWithImpl<$Res, Platform>;

  @useResult
  $Res call({String uuid, String name, String url, String image});
}

/// @nodoc
class _$PlatformCopyWithImpl<$Res, $Val extends Platform>
    implements $PlatformCopyWith<$Res> {
  _$PlatformCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;

  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uuid = null,
    Object? name = null,
    Object? url = null,
    Object? image = null,
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
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PlatformCopyWith<$Res> implements $PlatformCopyWith<$Res> {
  factory _$$_PlatformCopyWith(
          _$_Platform value, $Res Function(_$_Platform) then) =
      __$$_PlatformCopyWithImpl<$Res>;

  @override
  @useResult
  $Res call({String uuid, String name, String url, String image});
}

/// @nodoc
class __$$_PlatformCopyWithImpl<$Res>
    extends _$PlatformCopyWithImpl<$Res, _$_Platform>
    implements _$$_PlatformCopyWith<$Res> {
  __$$_PlatformCopyWithImpl(
      _$_Platform _value, $Res Function(_$_Platform) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uuid = null,
    Object? name = null,
    Object? url = null,
    Object? image = null,
  }) {
    return _then(_$_Platform(
      uuid: null == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Platform implements _Platform {
  const _$_Platform(
      {required this.uuid,
      required this.name,
      required this.url,
      required this.image});

  factory _$_Platform.fromJson(Map<String, dynamic> json) =>
      _$$_PlatformFromJson(json);

  @override
  final String uuid;
  @override
  final String name;
  @override
  final String url;
  @override
  final String image;

  @override
  String toString() {
    return 'Platform(uuid: $uuid, name: $name, url: $url, image: $image)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Platform &&
            (identical(other.uuid, uuid) || other.uuid == uuid) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.image, image) || other.image == image));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, uuid, name, url, image);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PlatformCopyWith<_$_Platform> get copyWith =>
      __$$_PlatformCopyWithImpl<_$_Platform>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PlatformToJson(
      this,
    );
  }
}

abstract class _Platform implements Platform {
  const factory _Platform(
      {required final String uuid,
      required final String name,
      required final String url,
      required final String image}) = _$_Platform;

  factory _Platform.fromJson(Map<String, dynamic> json) = _$_Platform.fromJson;

  @override
  String get uuid;

  @override
  String get name;

  @override
  String get url;

  @override
  String get image;

  @override
  @JsonKey(ignore: true)
  _$$_PlatformCopyWith<_$_Platform> get copyWith =>
      throw _privateConstructorUsedError;
}
