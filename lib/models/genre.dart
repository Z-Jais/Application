import 'package:json_annotation/json_annotation.dart';

part 'genre.g.dart';

@JsonSerializable(explicitToJson: true)
class Genre {
  final String uuid;
  final String name;

  Genre({
    required this.uuid,
    required this.name,
  });

  factory Genre.fromJson(Map<String, dynamic> json) => _$GenreFromJson(json);
  Map<String, dynamic> toJson() => _$GenreToJson(this);
}
