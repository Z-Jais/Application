import 'package:json_annotation/json_annotation.dart';

part 'country.g.dart';

@JsonSerializable(explicitToJson: true)
class Country {
  final String uuid;
  final String tag;
  final String name;

  Country({
    required this.uuid,
    required this.tag,
    required this.name,
  });

  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);
  Map<String, dynamic> toJson() => _$CountryToJson(this);
}
