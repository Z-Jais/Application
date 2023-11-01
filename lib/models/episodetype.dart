import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:json_annotation/json_annotation.dart';

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

  String toStringTranslated(BuildContext context) {
    switch (name) {
      case 'EPISODE':
        return AppLocalizations.of(context)!.episodes(1);
      case 'SPECIAL':
        return AppLocalizations.of(context)!.special;
      case 'FILM':
        return AppLocalizations.of(context)!.film;
      default:
        return '??';
    }
  }
}
