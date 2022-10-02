import 'package:freezed_annotation/freezed_annotation.dart';

part 'simulcast.freezed.dart';

part 'simulcast.g.dart';

@freezed
class Simulcast with _$Simulcast {
  const factory Simulcast({
    required String uuid,
    required String season,
    required int year,
  }) = _Simulcast;

  factory Simulcast.fromJson(Map<String, dynamic> json) =>
      _$SimulcastFromJson(json);
}
