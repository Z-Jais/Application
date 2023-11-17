import 'package:json_annotation/json_annotation.dart';

part 'profile.g.dart';

@JsonSerializable(explicitToJson: true)
class Profile {
  final String uuid;
  final String creationDate;
  final String lastUpdate;
  final List<String> animes;
  final List<String> episodes;
  int totalDurationSeen;
  final String? token;

  Profile({
    required this.uuid,
    required this.creationDate,
    required this.lastUpdate,
    required this.animes,
    required this.episodes,
    required this.totalDurationSeen,
    this.token,
  });

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}
