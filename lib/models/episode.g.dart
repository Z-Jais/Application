// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Episode _$EpisodeFromJson(Map<String, dynamic> json) => Episode(
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

Map<String, dynamic> _$EpisodeToJson(Episode instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'platform': instance.platform.toJson(),
      'anime': instance.anime.toJson(),
      'episodeType': instance.episodeType.toJson(),
      'langType': instance.langType.toJson(),
      'hash': instance.hash,
      'releaseDate': instance.releaseDate,
      'season': instance.season,
      'number': instance.number,
      'title': instance.title,
      'url': instance.url,
      'image': instance.image,
      'duration': instance.duration,
    };
