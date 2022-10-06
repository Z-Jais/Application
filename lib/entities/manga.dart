import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jais/entities/anime.dart';
import 'package:jais/entities/platform.dart';

part 'manga.freezed.dart';

part 'manga.g.dart';

@freezed
class Manga with _$Manga {
  const factory Manga({
    required String uuid,
    required Platform platform,
    required Anime anime,
    required String hash,
    required String releaseDate,
    required String url,
    required String cover,
    required String editor,
    required String? ref,
    required int? ean,
    required int? age,
    required double? price,
  }) = _Manga;

  factory Manga.fromJson(Map<String, dynamic> json) =>
      _$MangaFromJson(json);
}
