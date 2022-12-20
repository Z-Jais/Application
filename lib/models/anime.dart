import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jais/models/country.dart';
import 'package:jais/models/genre.dart';
import 'package:jais/models/simulcast.dart';

part 'anime.g.dart';

@JsonSerializable(explicitToJson: true)
class Anime {
  final String uuid;
  final Country country;
  final String name;
  final String releaseDate;
  final String image;
  final String? description;
  final List<String> hashes;
  final List<Simulcast> simulcasts;
  final List<Genre> genres;

Anime({
    required this.uuid,
    required this.country,
    required this.name,
    required this.releaseDate,
    required this.image,
    required this.description,
    required this.hashes,
    required this.simulcasts,
    required this.genres,
  });

  factory Anime.fromJson(Map<String, dynamic> json) => _$AnimeFromJson(json);
  Map<String, dynamic> toJson() => _$AnimeToJson(this);
}
