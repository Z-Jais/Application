// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Episode _$$_EpisodeFromJson(Map<String, dynamic> json) => _$_Episode(
      uuid: json['uuid'] as String,
      platform: Platform.fromJson(json['platform'] as Map<String, dynamic>),
      anime: Anime.fromJson(json['anime'] as Map<String, dynamic>),
      episodeType:
          EpisodeType.fromJson(json['episodeType'] as Map<String, dynamic>),
      langType: LangType.fromJson(json['langType'] as Map<String, dynamic>),
      hash: json['hash'] as String,
      releaseDate: json['releaseDate'] as String,
      season: json['season'] as int,
      number: json['number'] as int,
      title: json['title'] as String?,
      url: json['url'] as String,
      image: json['image'] as String,
      duration: json['duration'] as int,
    );

Map<String, dynamic> _$$_EpisodeToJson(_$_Episode instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'platform': instance.platform,
      'anime': instance.anime,
      'episodeType': instance.episodeType,
      'langType': instance.langType,
      'hash': instance.hash,
      'releaseDate': instance.releaseDate,
      'season': instance.season,
      'number': instance.number,
      'title': instance.title,
      'url': instance.url,
      'image': instance.image,
      'duration': instance.duration,
    };
