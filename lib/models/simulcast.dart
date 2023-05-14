import 'package:json_annotation/json_annotation.dart';

part 'simulcast.g.dart';

@JsonSerializable(explicitToJson: true)
class Simulcast {
  final String uuid;
  final String season;
  final int year;

  Simulcast({
    required this.uuid,
    required this.season,
    required this.year,
  });

  factory Simulcast.fromJson(Map<String, dynamic> json) =>
      _$SimulcastFromJson(json);

  Map<String, dynamic> toJson() => _$SimulcastToJson(this);
}
