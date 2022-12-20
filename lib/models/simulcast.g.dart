// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simulcast.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Simulcast _$SimulcastFromJson(Map<String, dynamic> json) => Simulcast(
      uuid: json['uuid'] as String,
      season: json['season'] as String,
      year: json['year'] as int,
    );

Map<String, dynamic> _$SimulcastToJson(Simulcast instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'season': instance.season,
      'year': instance.year,
    };
