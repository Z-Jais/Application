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

  List<Episode>? get episodes => throw _privateConstructorUsedError;

  List<Manga>? get mangas => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AnimeCopyWith<Anime> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnimeCopyWith<$Res> {
  factory $AnimeCopyWith(Anime value, $Res Function(Anime) then) =
      _$AnimeCopyWithImpl<$Res>;

  $Res call(
      {String uuid,
      Country country,
      String name,
      String releaseDate,
      String image,
      String? description,
      List<String> hashes,
      List<Simulcast> simulcasts,
      List<Episode>? episodes,
      List<Manga>? mangas});

  $CountryCopyWith<$Res> get country;
}

/// @nodoc
class _$AnimeCopyWithImpl<$Res> implements $AnimeCopyWith<$Res> {
  _$AnimeCopyWithImpl(this._value, this._then);

  final Anime _value;

  // ignore: unused_field
  final $Res Function(Anime) _then;

  @override
  $Res call({
    Object? uuid = freezed,
    Object? country = freezed,
    Object? name = freezed,
    Object? releaseDate = freezed,
    Object? image = freezed,
    Object? description = freezed,
    Object? hashes = freezed,
    Object? simulcasts = freezed,
    Object? episodes = freezed,
    Object? mangas = freezed,
  }) {
    return _then(_value.copyWith(
      uuid: uuid == freezed
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String,
      country: country == freezed
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as Country,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      releaseDate: releaseDate == freezed
          ? _value.releaseDate
          : releaseDate // ignore: cast_nullable_to_non_nullable
              as String,
      image: image == freezed
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      hashes: hashes == freezed
          ? _value.hashes
          : hashes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      simulcasts: simulcasts == freezed
          ? _value.simulcasts
          : simulcasts // ignore: cast_nullable_to_non_nullable
              as List<Simulcast>,
      episodes: episodes == freezed
          ? _value.episodes
          : episodes // ignore: cast_nullable_to_non_nullable
              as List<Episode>?,
      mangas: mangas == freezed
          ? _value.mangas
          : mangas // ignore: cast_nullable_to_non_nullable
              as List<Manga>?,
    ));
  }

  @override
  $CountryCopyWith<$Res> get country {
    return $CountryCopyWith<$Res>(_value.country, (value) {
      return _then(_value.copyWith(country: value));
    });
  }
}

/// @nodoc
abstract class _$$_AnimeCopyWith<$Res> implements $AnimeCopyWith<$Res> {
  factory _$$_AnimeCopyWith(_$_Anime value, $Res Function(_$_Anime) then) =
      __$$_AnimeCopyWithImpl<$Res>;

  @override
  $Res call(
      {String uuid,
      Country country,
      String name,
      String releaseDate,
      String image,
      String? description,
      List<String> hashes,
      List<Simulcast> simulcasts,
      List<Episode>? episodes,
      List<Manga>? mangas});

  @override
  $CountryCopyWith<$Res> get country;
}

/// @nodoc
class __$$_AnimeCopyWithImpl<$Res> extends _$AnimeCopyWithImpl<$Res>
    implements _$$_AnimeCopyWith<$Res> {
  __$$_AnimeCopyWithImpl(_$_Anime _value, $Res Function(_$_Anime) _then)
      : super(_value, (v) => _then(v as _$_Anime));

  @override
  _$_Anime get _value => super._value as _$_Anime;

  @override
  $Res call({
    Object? uuid = freezed,
    Object? country = freezed,
    Object? name = freezed,
    Object? releaseDate = freezed,
    Object? image = freezed,
    Object? description = freezed,
    Object? hashes = freezed,
    Object? simulcasts = freezed,
    Object? episodes = freezed,
    Object? mangas = freezed,
  }) {
    return _then(_$_Anime(
      uuid: uuid == freezed
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String,
      country: country == freezed
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as Country,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      releaseDate: releaseDate == freezed
          ? _value.releaseDate
          : releaseDate // ignore: cast_nullable_to_non_nullable
              as String,
      image: image == freezed
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      hashes: hashes == freezed
          ? _value._hashes
          : hashes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      simulcasts: simulcasts == freezed
          ? _value._simulcasts
          : simulcasts // ignore: cast_nullable_to_non_nullable
              as List<Simulcast>,
      episodes: episodes == freezed
          ? _value._episodes
          : episodes // ignore: cast_nullable_to_non_nullable
              as List<Episode>?,
      mangas: mangas == freezed
          ? _value._mangas
          : mangas // ignore: cast_nullable_to_non_nullable
              as List<Manga>?,
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
      final List<Episode>? episodes,
      final List<Manga>? mangas})
      : _hashes = hashes,
        _simulcasts = simulcasts,
        _episodes = episodes,
        _mangas = mangas;

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

  final List<Episode>? _episodes;

  @override
  List<Episode>? get episodes {
    final value = _episodes;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<Manga>? _mangas;

  @override
  List<Manga>? get mangas {
    final value = _mangas;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Anime(uuid: $uuid, country: $country, name: $name, releaseDate: $releaseDate, image: $image, description: $description, hashes: $hashes, simulcasts: $simulcasts, episodes: $episodes, mangas: $mangas)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Anime &&
            const DeepCollectionEquality().equals(other.uuid, uuid) &&
            const DeepCollectionEquality().equals(other.country, country) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality()
                .equals(other.releaseDate, releaseDate) &&
            const DeepCollectionEquality().equals(other.image, image) &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality().equals(other._hashes, _hashes) &&
            const DeepCollectionEquality()
                .equals(other._simulcasts, _simulcasts) &&
            const DeepCollectionEquality().equals(other._episodes, _episodes) &&
            const DeepCollectionEquality().equals(other._mangas, _mangas));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(uuid),
      const DeepCollectionEquality().hash(country),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(releaseDate),
      const DeepCollectionEquality().hash(image),
      const DeepCollectionEquality().hash(description),
      const DeepCollectionEquality().hash(_hashes),
      const DeepCollectionEquality().hash(_simulcasts),
      const DeepCollectionEquality().hash(_episodes),
      const DeepCollectionEquality().hash(_mangas));

  @JsonKey(ignore: true)
  @override
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
      final List<Episode>? episodes,
      final List<Manga>? mangas}) = _$_Anime;

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
  List<Episode>? get episodes;

  @override
  List<Manga>? get mangas;

  @override
  @JsonKey(ignore: true)
  _$$_AnimeCopyWith<_$_Anime> get copyWith =>
      throw _privateConstructorUsedError;
}
