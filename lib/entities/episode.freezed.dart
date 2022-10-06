// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'episode.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Episode _$EpisodeFromJson(Map<String, dynamic> json) {
  return _Episode.fromJson(json);
}

/// @nodoc
mixin _$Episode {
  String get uuid => throw _privateConstructorUsedError;

  Platform get platform => throw _privateConstructorUsedError;

  Anime get anime => throw _privateConstructorUsedError;

  EpisodeType get episodeType => throw _privateConstructorUsedError;

  LangType get langType => throw _privateConstructorUsedError;

  String get hash => throw _privateConstructorUsedError;

  String get releaseDate => throw _privateConstructorUsedError;

  int get season => throw _privateConstructorUsedError;

  int get number => throw _privateConstructorUsedError;

  String? get title => throw _privateConstructorUsedError;

  String get url => throw _privateConstructorUsedError;

  String get image => throw _privateConstructorUsedError;

  int get duration => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $EpisodeCopyWith<Episode> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EpisodeCopyWith<$Res> {
  factory $EpisodeCopyWith(Episode value, $Res Function(Episode) then) =
      _$EpisodeCopyWithImpl<$Res>;

  $Res call(
      {String uuid,
      Platform platform,
      Anime anime,
      EpisodeType episodeType,
      LangType langType,
      String hash,
      String releaseDate,
      int season,
      int number,
      String? title,
      String url,
      String image,
      int duration});

  $PlatformCopyWith<$Res> get platform;

  $AnimeCopyWith<$Res> get anime;

  $EpisodeTypeCopyWith<$Res> get episodeType;

  $LangTypeCopyWith<$Res> get langType;
}

/// @nodoc
class _$EpisodeCopyWithImpl<$Res> implements $EpisodeCopyWith<$Res> {
  _$EpisodeCopyWithImpl(this._value, this._then);

  final Episode _value;

  // ignore: unused_field
  final $Res Function(Episode) _then;

  @override
  $Res call({
    Object? uuid = freezed,
    Object? platform = freezed,
    Object? anime = freezed,
    Object? episodeType = freezed,
    Object? langType = freezed,
    Object? hash = freezed,
    Object? releaseDate = freezed,
    Object? season = freezed,
    Object? number = freezed,
    Object? title = freezed,
    Object? url = freezed,
    Object? image = freezed,
    Object? duration = freezed,
  }) {
    return _then(_value.copyWith(
      uuid: uuid == freezed
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String,
      platform: platform == freezed
          ? _value.platform
          : platform // ignore: cast_nullable_to_non_nullable
              as Platform,
      anime: anime == freezed
          ? _value.anime
          : anime // ignore: cast_nullable_to_non_nullable
              as Anime,
      episodeType: episodeType == freezed
          ? _value.episodeType
          : episodeType // ignore: cast_nullable_to_non_nullable
              as EpisodeType,
      langType: langType == freezed
          ? _value.langType
          : langType // ignore: cast_nullable_to_non_nullable
              as LangType,
      hash: hash == freezed
          ? _value.hash
          : hash // ignore: cast_nullable_to_non_nullable
              as String,
      releaseDate: releaseDate == freezed
          ? _value.releaseDate
          : releaseDate // ignore: cast_nullable_to_non_nullable
              as String,
      season: season == freezed
          ? _value.season
          : season // ignore: cast_nullable_to_non_nullable
              as int,
      number: number == freezed
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as int,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      image: image == freezed
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      duration: duration == freezed
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }

  @override
  $PlatformCopyWith<$Res> get platform {
    return $PlatformCopyWith<$Res>(_value.platform, (value) {
      return _then(_value.copyWith(platform: value));
    });
  }

  @override
  $AnimeCopyWith<$Res> get anime {
    return $AnimeCopyWith<$Res>(_value.anime, (value) {
      return _then(_value.copyWith(anime: value));
    });
  }

  @override
  $EpisodeTypeCopyWith<$Res> get episodeType {
    return $EpisodeTypeCopyWith<$Res>(_value.episodeType, (value) {
      return _then(_value.copyWith(episodeType: value));
    });
  }

  @override
  $LangTypeCopyWith<$Res> get langType {
    return $LangTypeCopyWith<$Res>(_value.langType, (value) {
      return _then(_value.copyWith(langType: value));
    });
  }
}

/// @nodoc
abstract class _$$_EpisodeCopyWith<$Res> implements $EpisodeCopyWith<$Res> {
  factory _$$_EpisodeCopyWith(
          _$_Episode value, $Res Function(_$_Episode) then) =
      __$$_EpisodeCopyWithImpl<$Res>;

  @override
  $Res call(
      {String uuid,
      Platform platform,
      Anime anime,
      EpisodeType episodeType,
      LangType langType,
      String hash,
      String releaseDate,
      int season,
      int number,
      String? title,
      String url,
      String image,
      int duration});

  @override
  $PlatformCopyWith<$Res> get platform;

  @override
  $AnimeCopyWith<$Res> get anime;

  @override
  $EpisodeTypeCopyWith<$Res> get episodeType;

  @override
  $LangTypeCopyWith<$Res> get langType;
}

/// @nodoc
class __$$_EpisodeCopyWithImpl<$Res> extends _$EpisodeCopyWithImpl<$Res>
    implements _$$_EpisodeCopyWith<$Res> {
  __$$_EpisodeCopyWithImpl(_$_Episode _value, $Res Function(_$_Episode) _then)
      : super(_value, (v) => _then(v as _$_Episode));

  @override
  _$_Episode get _value => super._value as _$_Episode;

  @override
  $Res call({
    Object? uuid = freezed,
    Object? platform = freezed,
    Object? anime = freezed,
    Object? episodeType = freezed,
    Object? langType = freezed,
    Object? hash = freezed,
    Object? releaseDate = freezed,
    Object? season = freezed,
    Object? number = freezed,
    Object? title = freezed,
    Object? url = freezed,
    Object? image = freezed,
    Object? duration = freezed,
  }) {
    return _then(_$_Episode(
      uuid: uuid == freezed
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String,
      platform: platform == freezed
          ? _value.platform
          : platform // ignore: cast_nullable_to_non_nullable
              as Platform,
      anime: anime == freezed
          ? _value.anime
          : anime // ignore: cast_nullable_to_non_nullable
              as Anime,
      episodeType: episodeType == freezed
          ? _value.episodeType
          : episodeType // ignore: cast_nullable_to_non_nullable
              as EpisodeType,
      langType: langType == freezed
          ? _value.langType
          : langType // ignore: cast_nullable_to_non_nullable
              as LangType,
      hash: hash == freezed
          ? _value.hash
          : hash // ignore: cast_nullable_to_non_nullable
              as String,
      releaseDate: releaseDate == freezed
          ? _value.releaseDate
          : releaseDate // ignore: cast_nullable_to_non_nullable
              as String,
      season: season == freezed
          ? _value.season
          : season // ignore: cast_nullable_to_non_nullable
              as int,
      number: number == freezed
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as int,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      image: image == freezed
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      duration: duration == freezed
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Episode implements _Episode {
  const _$_Episode(
      {required this.uuid,
      required this.platform,
      required this.anime,
      required this.episodeType,
      required this.langType,
      required this.hash,
      required this.releaseDate,
      required this.season,
      required this.number,
      required this.title,
      required this.url,
      required this.image,
      required this.duration});

  factory _$_Episode.fromJson(Map<String, dynamic> json) =>
      _$$_EpisodeFromJson(json);

  @override
  final String uuid;
  @override
  final Platform platform;
  @override
  final Anime anime;
  @override
  final EpisodeType episodeType;
  @override
  final LangType langType;
  @override
  final String hash;
  @override
  final String releaseDate;
  @override
  final int season;
  @override
  final int number;
  @override
  final String? title;
  @override
  final String url;
  @override
  final String image;
  @override
  final int duration;

  @override
  String toString() {
    return 'Episode(uuid: $uuid, platform: $platform, anime: $anime, episodeType: $episodeType, langType: $langType, hash: $hash, releaseDate: $releaseDate, season: $season, number: $number, title: $title, url: $url, image: $image, duration: $duration)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Episode &&
            const DeepCollectionEquality().equals(other.uuid, uuid) &&
            const DeepCollectionEquality().equals(other.platform, platform) &&
            const DeepCollectionEquality().equals(other.anime, anime) &&
            const DeepCollectionEquality()
                .equals(other.episodeType, episodeType) &&
            const DeepCollectionEquality().equals(other.langType, langType) &&
            const DeepCollectionEquality().equals(other.hash, hash) &&
            const DeepCollectionEquality()
                .equals(other.releaseDate, releaseDate) &&
            const DeepCollectionEquality().equals(other.season, season) &&
            const DeepCollectionEquality().equals(other.number, number) &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality().equals(other.url, url) &&
            const DeepCollectionEquality().equals(other.image, image) &&
            const DeepCollectionEquality().equals(other.duration, duration));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(uuid),
      const DeepCollectionEquality().hash(platform),
      const DeepCollectionEquality().hash(anime),
      const DeepCollectionEquality().hash(episodeType),
      const DeepCollectionEquality().hash(langType),
      const DeepCollectionEquality().hash(hash),
      const DeepCollectionEquality().hash(releaseDate),
      const DeepCollectionEquality().hash(season),
      const DeepCollectionEquality().hash(number),
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(url),
      const DeepCollectionEquality().hash(image),
      const DeepCollectionEquality().hash(duration));

  @JsonKey(ignore: true)
  @override
  _$$_EpisodeCopyWith<_$_Episode> get copyWith =>
      __$$_EpisodeCopyWithImpl<_$_Episode>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_EpisodeToJson(
      this,
    );
  }
}

abstract class _Episode implements Episode {
  const factory _Episode(
      {required final String uuid,
      required final Platform platform,
      required final Anime anime,
      required final EpisodeType episodeType,
      required final LangType langType,
      required final String hash,
      required final String releaseDate,
      required final int season,
      required final int number,
      required final String? title,
      required final String url,
      required final String image,
      required final int duration}) = _$_Episode;

  factory _Episode.fromJson(Map<String, dynamic> json) = _$_Episode.fromJson;

  @override
  String get uuid;

  @override
  Platform get platform;

  @override
  Anime get anime;

  @override
  EpisodeType get episodeType;

  @override
  LangType get langType;

  @override
  String get hash;

  @override
  String get releaseDate;

  @override
  int get season;

  @override
  int get number;

  @override
  String? get title;

  @override
  String get url;

  @override
  String get image;

  @override
  int get duration;

  @override
  @JsonKey(ignore: true)
  _$$_EpisodeCopyWith<_$_Episode> get copyWith =>
      throw _privateConstructorUsedError;
}
