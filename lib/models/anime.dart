import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jais/models/country.dart';
import 'package:jais/models/genre.dart';
import 'package:jais/models/simulcast.dart';

part 'anime.freezed.dart';
part 'anime.g.dart';

@freezed
class Anime with _$Anime {
  const factory Anime({
    required String uuid,
    required Country country,
    required String name,
    required String releaseDate,
    required String image,
    required String? description,
    required List<String> hashes,
    required List<Simulcast> simulcasts,
    required List<Genre> genres,
  }) = _Anime;

  factory Anime.fromJson(Map<String, dynamic> json) => _$AnimeFromJson(json);
}
