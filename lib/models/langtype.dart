import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:json_annotation/json_annotation.dart';

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

  String toStringTranslated(BuildContext context) {
    switch (name) {
      case 'SUBTITLES':
        return AppLocalizations.of(context)!.subtitles;
      case 'VOICE':
        return AppLocalizations.of(context)!.voice;
      default:
        return '??';
    }
  }
}
