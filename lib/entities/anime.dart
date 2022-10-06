import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jais/entities/country.dart';
import 'package:jais/entities/simulcast.dart';

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
  }) = _Anime;

  factory Anime.fromJson(Map<String, dynamic> json) => _$AnimeFromJson(json);
}
