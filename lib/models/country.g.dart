// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Country _$CountryFromJson(Map<String, dynamic> json) => Country(
      uuid: json['uuid'] as String,
      tag: json['tag'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$CountryToJson(Country instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'tag': instance.tag,
      'name': instance.name,
    };
