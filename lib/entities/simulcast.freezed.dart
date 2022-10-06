// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'simulcast.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Simulcast _$SimulcastFromJson(Map<String, dynamic> json) {
  return _Simulcast.fromJson(json);
}

/// @nodoc
mixin _$Simulcast {
  String get uuid => throw _privateConstructorUsedError;
  String get season => throw _privateConstructorUsedError;
  int get year => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SimulcastCopyWith<Simulcast> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SimulcastCopyWith<$Res> {
  factory $SimulcastCopyWith(Simulcast value, $Res Function(Simulcast) then) =
      _$SimulcastCopyWithImpl<$Res>;
  $Res call({String uuid, String season, int year});
}

/// @nodoc
class _$SimulcastCopyWithImpl<$Res> implements $SimulcastCopyWith<$Res> {
  _$SimulcastCopyWithImpl(this._value, this._then);

  final Simulcast _value;
  // ignore: unused_field
  final $Res Function(Simulcast) _then;

  @override
  $Res call({
    Object? uuid = freezed,
    Object? season = freezed,
    Object? year = freezed,
  }) {
    return _then(_value.copyWith(
      uuid: uuid == freezed
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String,
      season: season == freezed
          ? _value.season
          : season // ignore: cast_nullable_to_non_nullable
              as String,
      year: year == freezed
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$$_SimulcastCopyWith<$Res> implements $SimulcastCopyWith<$Res> {
  factory _$$_SimulcastCopyWith(
          _$_Simulcast value, $Res Function(_$_Simulcast) then) =
      __$$_SimulcastCopyWithImpl<$Res>;
  @override
  $Res call({String uuid, String season, int year});
}

/// @nodoc
class __$$_SimulcastCopyWithImpl<$Res> extends _$SimulcastCopyWithImpl<$Res>
    implements _$$_SimulcastCopyWith<$Res> {
  __$$_SimulcastCopyWithImpl(
      _$_Simulcast _value, $Res Function(_$_Simulcast) _then)
      : super(_value, (v) => _then(v as _$_Simulcast));

  @override
  _$_Simulcast get _value => super._value as _$_Simulcast;

  @override
  $Res call({
    Object? uuid = freezed,
    Object? season = freezed,
    Object? year = freezed,
  }) {
    return _then(_$_Simulcast(
      uuid: uuid == freezed
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String,
      season: season == freezed
          ? _value.season
          : season // ignore: cast_nullable_to_non_nullable
              as String,
      year: year == freezed
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Simulcast implements _Simulcast {
  const _$_Simulcast(
      {required this.uuid, required this.season, required this.year});

  factory _$_Simulcast.fromJson(Map<String, dynamic> json) =>
      _$$_SimulcastFromJson(json);

  @override
  final String uuid;
  @override
  final String season;
  @override
  final int year;

  @override
  String toString() {
    return 'Simulcast(uuid: $uuid, season: $season, year: $year)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Simulcast &&
            const DeepCollectionEquality().equals(other.uuid, uuid) &&
            const DeepCollectionEquality().equals(other.season, season) &&
            const DeepCollectionEquality().equals(other.year, year));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(uuid),
      const DeepCollectionEquality().hash(season),
      const DeepCollectionEquality().hash(year));

  @JsonKey(ignore: true)
  @override
  _$$_SimulcastCopyWith<_$_Simulcast> get copyWith =>
      __$$_SimulcastCopyWithImpl<_$_Simulcast>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SimulcastToJson(
      this,
    );
  }
}

abstract class _Simulcast implements Simulcast {
  const factory _Simulcast(
      {required final String uuid,
      required final String season,
      required final int year}) = _$_Simulcast;

  factory _Simulcast.fromJson(Map<String, dynamic> json) =
      _$_Simulcast.fromJson;

  @override
  String get uuid;
  @override
  String get season;
  @override
  int get year;
  @override
  @JsonKey(ignore: true)
  _$$_SimulcastCopyWith<_$_Simulcast> get copyWith =>
      throw _privateConstructorUsedError;
}
