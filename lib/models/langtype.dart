import 'package:freezed_annotation/freezed_annotation.dart';

part 'langtype.freezed.dart';
part 'langtype.g.dart';

@freezed
class LangType with _$LangType {
  const factory LangType({
    required String uuid,
    required String name,
  }) = _LangType;

  factory LangType.fromJson(Map<String, dynamic> json) =>
      _$LangTypeFromJson(json);
}
