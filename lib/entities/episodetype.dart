import 'package:freezed_annotation/freezed_annotation.dart';

part 'episodetype.freezed.dart';
part 'episodetype.g.dart';

@freezed
class EpisodeType with _$EpisodeType {
  const factory EpisodeType({
    required String uuid,
    required String name,
  }) = _EpisodeType;

  factory EpisodeType.fromJson(Map<String, dynamic> json) =>
      _$EpisodeTypeFromJson(json);
}
