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
      _$EpisodeCopyWithImpl<$Res, Episode>;

  @useResult
  $Res call({String uuid,
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
class _$EpisodeCopyWithImpl<$Res, $Val extends Episode>
    implements $EpisodeCopyWith<$Res> {
  _$EpisodeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;

  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uuid = null,
    Object? platform = null,
    Object? anime = null,
    Object? episodeType = null,
    Object? langType = null,
    Object? hash = null,
    Object? releaseDate = null,
    Object? season = null,
    Object? number = null,
    Object? title = freezed,
    Object? url = null,
    Object? image = null,
    Object? duration = null,
  }) {
    return _then(_value.copyWith(
      uuid: null == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String,
      platform: null == platform
          ? _value.platform
          : platform // ignore: cast_nullable_to_non_nullable
              as Platform,
      anime: null == anime
          ? _value.anime
          : anime // ignore: cast_nullable_to_non_nullable
              as Anime,
      episodeType: null == episodeType
          ? _value.episodeType
          : episodeType // ignore: cast_nullable_to_non_nullable
              as EpisodeType,
      langType: null == langType
          ? _value.langType
          : langType // ignore: cast_nullable_to_non_nullable
              as LangType,
      hash: null == hash
          ? _value.hash
          : hash // ignore: cast_nullable_to_non_nullable
              as String,
      releaseDate: null == releaseDate
          ? _value.releaseDate
          : releaseDate // ignore: cast_nullable_to_non_nullable
              as String,
      season: null == season
          ? _value.season
          : season // ignore: cast_nullable_to_non_nullable
              as int,
      number: null == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as int,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PlatformCopyWith<$Res> get platform {
    return $PlatformCopyWith<$Res>(_value.platform, (value) {
      return _then(_value.copyWith(platform: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $AnimeCopyWith<$Res> get anime {
    return $AnimeCopyWith<$Res>(_value.anime, (value) {
      return _then(_value.copyWith(anime: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $EpisodeTypeCopyWith<$Res> get episodeType {
    return $EpisodeTypeCopyWith<$Res>(_value.episodeType, (value) {
      return _then(_value.copyWith(episodeType: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $LangTypeCopyWith<$Res> get langType {
    return $LangTypeCopyWith<$Res>(_value.langType, (value) {
      return _then(_value.copyWith(langType: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_EpisodeCopyWith<$Res> implements $EpisodeCopyWith<$Res> {
  factory _$$_EpisodeCopyWith(
          _$_Episode value, $Res Function(_$_Episode) then) =
      __$$_EpisodeCopyWithImpl<$Res>;

  @override
  @useResult
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
class __$$_EpisodeCopyWithImpl<$Res>
    extends _$EpisodeCopyWithImpl<$Res, _$_Episode>
    implements _$$_EpisodeCopyWith<$Res> {
  __$$_EpisodeCopyWithImpl(_$_Episode _value, $Res Function(_$_Episode) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uuid = null,
    Object? platform = null,
    Object? anime = null,
    Object? episodeType = null,
    Object? langType = null,
    Object? hash = null,
    Object? releaseDate = null,
    Object? season = null,
    Object? number = null,
    Object? title = freezed,
    Object? url = null,
    Object? image = null,
    Object? duration = null,
  }) {
    return _then(_$_Episode(
      uuid: null == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String,
      platform: null == platform
          ? _value.platform
          : platform // ignore: cast_nullable_to_non_nullable
              as Platform,
      anime: null == anime
          ? _value.anime
          : anime // ignore: cast_nullable_to_non_nullable
              as Anime,
      episodeType: null == episodeType
          ? _value.episodeType
          : episodeType // ignore: cast_nullable_to_non_nullable
              as EpisodeType,
      langType: null == langType
          ? _value.langType
          : langType // ignore: cast_nullable_to_non_nullable
              as LangType,
      hash: null == hash
          ? _value.hash
          : hash // ignore: cast_nullable_to_non_nullable
              as String,
      releaseDate: null == releaseDate
          ? _value.releaseDate
          : releaseDate // ignore: cast_nullable_to_non_nullable
              as String,
      season: null == season
          ? _value.season
          : season // ignore: cast_nullable_to_non_nullable
              as int,
      number: null == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as int,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      duration: null == duration
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
            (identical(other.uuid, uuid) || other.uuid == uuid) &&
            (identical(other.platform, platform) ||
                other.platform == platform) &&
            (identical(other.anime, anime) || other.anime == anime) &&
            (identical(other.episodeType, episodeType) ||
                other.episodeType == episodeType) &&
            (identical(other.langType, langType) ||
                other.langType == langType) &&
            (identical(other.hash, hash) || other.hash == hash) &&
            (identical(other.releaseDate, releaseDate) ||
                other.releaseDate == releaseDate) &&
            (identical(other.season, season) || other.season == season) &&
            (identical(other.number, number) || other.number == number) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.duration, duration) ||
                other.duration == duration));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      uuid,
      platform,
      anime,
      episodeType,
      langType,
      hash,
      releaseDate,
      season,
      number,
      title,
      url,
      image,
      duration);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
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
