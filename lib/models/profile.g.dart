// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile(
      uuid: json['uuid'] as String,
      creationDate: json['creationDate'] as String,
      lastUpdate: json['lastUpdate'] as String,
      animes:
          (json['animes'] as List<dynamic>).map((e) => e as String).toList(),
      episodes:
          (json['episodes'] as List<dynamic>).map((e) => e as String).toList(),
      totalDurationSeen: json['totalDurationSeen'] as int,
      token: json['token'] as String?,
    );

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'creationDate': instance.creationDate,
      'lastUpdate': instance.lastUpdate,
      'animes': instance.animes,
      'episodes': instance.episodes,
      'totalDurationSeen': instance.totalDurationSeen,
      'token': instance.token,
    };
