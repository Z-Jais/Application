import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jais/models/anime.dart';
import 'package:jais/models/episodetype.dart';
import 'package:jais/models/langtype.dart';
import 'package:jais/models/platform.dart';

part 'episode.freezed.dart';
part 'episode.g.dart';

@freezed
class Episode with _$Episode {
  const factory Episode({
    required String uuid,
    required Platform platform,
    required Anime anime,
    required EpisodeType episodeType,
    required LangType langType,
    required String hash,
    required String releaseDate,
    required int season,
    required int number,
    required String? title,
    required String url,
    required String image,
    required int duration,
  }) = _Episode;

  factory Episode.fromJson(Map<String, dynamic> json) =>
      _$EpisodeFromJson(json);
}
