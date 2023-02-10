import 'package:freezed_annotation/freezed_annotation.dart';

part 'episodetype.g.dart';

@JsonSerializable(explicitToJson: true)
class EpisodeType {
  final String uuid;
  final String name;

  EpisodeType({
    required this.uuid,
    required this.name,
  });

  factory EpisodeType.fromJson(Map<String, dynamic> json) =>
      _$EpisodeTypeFromJson(json);
  Map<String, dynamic> toJson() => _$EpisodeTypeToJson(this);

  @override
  String toString() {
    if (name == 'EPISODE') {
      return 'Épisode';
    }

    if (name == 'SPECIAL') {
      return 'Spécial';
    }

    if (name == 'FILM') {
      return 'Film';
    }

    return '??';
  }
}
