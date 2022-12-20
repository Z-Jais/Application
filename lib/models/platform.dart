import 'package:freezed_annotation/freezed_annotation.dart';

part 'platform.freezed.dart';
part 'platform.g.dart';

@freezed
class Platform with _$Platform {
  const factory Platform({
    required String uuid,
    required String name,
    required String url,
    required String image,
  }) = _Platform;

  factory Platform.fromJson(Map<String, dynamic> json) =>
      _$PlatformFromJson(json);
}
