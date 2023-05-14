// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'missing_anime.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MissingAnime _$MissingAnimeFromJson(Map<String, dynamic> json) => MissingAnime(
      anime: Anime.fromJson(json['anime'] as Map<String, dynamic>),
      episodeCount: json['episodeCount'] as int,
      lastEpisode: json['lastEpisode'] as String,
    );

Map<String, dynamic> _$MissingAnimeToJson(MissingAnime instance) =>
    <String, dynamic>{
      'anime': instance.anime.toJson(),
      'episodeCount': instance.episodeCount,
      'lastEpisode': instance.lastEpisode,
    };
