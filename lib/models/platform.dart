import 'package:json_annotation/json_annotation.dart';

part 'platform.g.dart';

@JsonSerializable(explicitToJson: true)
class Platform {
  final String uuid;
  final String name;
  final String url;
  final String image;

  Platform({
    required this.uuid,
    required this.name,
    required this.url,
    required this.image,
  });

  factory Platform.fromJson(Map<String, dynamic> json) =>
      _$PlatformFromJson(json);

  Map<String, dynamic> toJson() => _$PlatformToJson(this);
}
