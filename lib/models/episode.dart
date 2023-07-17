import 'package:jais/models/anime.dart';
import 'package:jais/models/episodetype.dart';
import 'package:jais/models/langtype.dart';
import 'package:jais/models/platform.dart';
import 'package:json_annotation/json_annotation.dart';

part 'episode.g.dart';

@JsonSerializable(explicitToJson: true)
class Episode {
  final String uuid;
  final Platform platform;
  final Anime anime;
  final EpisodeType episodeType;
  final LangType langType;
  final String hash;
  final String releaseDate;
  final int season;
  final int number;
  final String? title;
  final String url;
  final String image;
  final int duration;

  Episode({
    required this.uuid,
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
    required this.duration,
  });

  factory Episode.fromJson(Map<String, dynamic> json) =>
      _$EpisodeFromJson(json);

  Map<String, dynamic> toJson() => _$EpisodeToJson(this);
}
