import 'package:freezed_annotation/freezed_annotation.dart';

part 'langtype.g.dart';

@JsonSerializable(explicitToJson: true)
class LangType {
  final String uuid;
  final String name;

  LangType({
    required this.uuid,
    required this.name,
  });

  factory LangType.fromJson(Map<String, dynamic> json) =>
      _$LangTypeFromJson(json);
  Map<String, dynamic> toJson() => _$LangTypeToJson(this);

  @override
  String toString() {
    if (name == 'SUBTITLES') {
      return 'VOSTFR';
    }

    if (name == 'VOICE') {
      return 'VF';
    }

    return '??';
  }
}
