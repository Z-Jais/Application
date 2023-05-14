import 'package:jais/models/anime.dart';
import 'package:json_annotation/json_annotation.dart';

part 'missing_anime.g.dart';

@JsonSerializable(explicitToJson: true)
class MissingAnime {
  final Anime anime;
  final int episodeCount;
  final String lastEpisode;

  MissingAnime({
    required this.anime,
    required this.episodeCount,
    required this.lastEpisode,
  });

  factory MissingAnime.fromJson(Map<String, dynamic> json) =>
      _$MissingAnimeFromJson(json);

  Map<String, dynamic> toJson() => _$MissingAnimeToJson(this);

  @override
  String toString() {
    return 'MissingAnime{anime: ${anime.name}, episodeCount: $episodeCount, lastEpisode: $lastEpisode}';
  }
}
