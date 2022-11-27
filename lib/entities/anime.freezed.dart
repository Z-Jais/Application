// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'anime.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Anime _$AnimeFromJson(Map<String, dynamic> json) {
  return _Anime.fromJson(json);
}

/// @nodoc
mixin _$Anime {
  String get uuid => throw _privateConstructorUsedError;
  Country get country => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get releaseDate => throw _privateConstructorUsedError;
  String get image => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  List<String> get hashes => throw _privateConstructorUsedError;
  List<Simulcast> get simulcasts => throw _privateConstructorUsedError;

  List<Genre> get genres => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AnimeCopyWith<Anime> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnimeCopyWith<$Res> {
  factory $AnimeCopyWith(Anime value, $Res Function(Anime) then) =
      _$AnimeCopyWithImpl<$Res, Anime>;

  @useResult
  $Res call(
      {String uuid,
      Country country,
      String name,
      String releaseDate,
      String image,
      String? description,
      List<String> hashes,
      List<Simulcast> simulcasts,
      List<Genre> genres});

  $CountryCopyWith<$Res> get country;
}

/// @nodoc
class _$AnimeCopyWithImpl<$Res, $Val extends Anime>
    implements $AnimeCopyWith<$Res> {
  _$AnimeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uuid = null,
    Object? country = null,
    Object? name = null,
    Object? releaseDate = null,
    Object? image = null,
    Object? description = freezed,
    Object? hashes = null,
    Object? simulcasts = null,
    Object? genres = null,
  }) {
    return _then(_value.copyWith(
      uuid: null == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String,
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as Country,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      releaseDate: null == releaseDate
          ? _value.releaseDate
          : releaseDate // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      hashes: null == hashes
          ? _value.hashes
          : hashes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      simulcasts: null == simulcasts
          ? _value.simulcasts
          : simulcasts // ignore: cast_nullable_to_non_nullable
              as List<Simulcast>,
      genres: null == genres
          ? _value.genres
          : genres // ignore: cast_nullable_to_non_nullable
              as List<Genre>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CountryCopyWith<$Res> get country {
    return $CountryCopyWith<$Res>(_value.country, (value) {
      return _then(_value.copyWith(country: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_AnimeCopyWith<$Res> implements $AnimeCopyWith<$Res> {
  factory _$$_AnimeCopyWith(_$_Anime value, $Res Function(_$_Anime) then) =
      __$$_AnimeCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String uuid,
      Country country,
      String name,
      String releaseDate,
      String image,
      String? description,
      List<String> hashes,
      List<Simulcast> simulcasts,
      List<Genre> genres});

  @override
  $CountryCopyWith<$Res> get country;
}

/// @nodoc
class __$$_AnimeCopyWithImpl<$Res> extends _$AnimeCopyWithImpl<$Res, _$_Anime>
    implements _$$_AnimeCopyWith<$Res> {
  __$$_AnimeCopyWithImpl(_$_Anime _value, $Res Function(_$_Anime) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uuid = null,
    Object? country = null,
    Object? name = null,
    Object? releaseDate = null,
    Object? image = null,
    Object? description = freezed,
    Object? hashes = null,
    Object? simulcasts = null,
    Object? genres = null,
  }) {
    return _then(_$_Anime(
      uuid: null == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String,
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as Country,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      releaseDate: null == releaseDate
          ? _value.releaseDate
          : releaseDate // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      hashes: null == hashes
          ? _value._hashes
          : hashes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      simulcasts: null == simulcasts
          ? _value._simulcasts
          : simulcasts // ignore: cast_nullable_to_non_nullable
              as List<Simulcast>,
      genres: null == genres
          ? _value._genres
          : genres // ignore: cast_nullable_to_non_nullable
              as List<Genre>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Anime implements _Anime {
  const _$_Anime(
      {required this.uuid,
      required this.country,
      required this.name,
      required this.releaseDate,
      required this.image,
      required this.description,
      required final List<String> hashes,
      required final List<Simulcast> simulcasts,
      required final List<Genre> genres})
      : _hashes = hashes,
        _simulcasts = simulcasts,
        _genres = genres;

  factory _$_Anime.fromJson(Map<String, dynamic> json) =>
      _$$_AnimeFromJson(json);

  @override
  final String uuid;
  @override
  final Country country;
  @override
  final String name;
  @override
  final String releaseDate;
  @override
  final String image;
  @override
  final String? description;
  final List<String> _hashes;
  @override
  List<String> get hashes {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_hashes);
  }

  final List<Simulcast> _simulcasts;

  @override
  List<Simulcast> get simulcasts {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_simulcasts);
  }

  final List<Genre> _genres;

  @override
  List<Genre> get genres {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_genres);
  }

  @override
  String toString() {
    return 'Anime(uuid: $uuid, country: $country, name: $name, releaseDate: $releaseDate, image: $image, description: $description, hashes: $hashes, simulcasts: $simulcasts, genres: $genres)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Anime &&
            (identical(other.uuid, uuid) || other.uuid == uuid) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.releaseDate, releaseDate) ||
                other.releaseDate == releaseDate) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._hashes, _hashes) &&
            const DeepCollectionEquality()
                .equals(other._simulcasts, _simulcasts) &&
            const DeepCollectionEquality().equals(other._genres, _genres));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      uuid,
      country,
      name,
      releaseDate,
      image,
      description,
      const DeepCollectionEquality().hash(_hashes),
      const DeepCollectionEquality().hash(_simulcasts),
      const DeepCollectionEquality().hash(_genres));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AnimeCopyWith<_$_Anime> get copyWith =>
      __$$_AnimeCopyWithImpl<_$_Anime>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AnimeToJson(
      this,
    );
  }
}

abstract class _Anime implements Anime {
  const factory _Anime(
      {required final String uuid,
      required final Country country,
      required final String name,
      required final String releaseDate,
      required final String image,
      required final String? description,
      required final List<String> hashes,
      required final List<Simulcast> simulcasts,
      required final List<Genre> genres}) = _$_Anime;

  factory _Anime.fromJson(Map<String, dynamic> json) = _$_Anime.fromJson;

  @override
  String get uuid;
  @override
  Country get country;
  @override
  String get name;
  @override
  String get releaseDate;
  @override
  String get image;
  @override
  String? get description;
  @override
  List<String> get hashes;

  @override
  List<Simulcast> get simulcasts;

  @override
  List<Genre> get genres;

  @override
  @JsonKey(ignore: true)
  _$$_AnimeCopyWith<_$_Anime> get copyWith =>
      throw _privateConstructorUsedError;
}
