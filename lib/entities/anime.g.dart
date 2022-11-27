// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anime.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Anime _$$_AnimeFromJson(Map<String, dynamic> json) => _$_Anime(
      uuid: json['uuid'] as String,
      country: Country.fromJson(json['country'] as Map<String, dynamic>),
      name: json['name'] as String,
      releaseDate: json['releaseDate'] as String,
      image: json['image'] as String,
      description: json['description'] as String?,
      hashes: (json['hashes'] as List<dynamic>)
          .map((dynamic e) => e as String)
          .toList(),
      simulcasts: (json['simulcasts'] as List<dynamic>)
          .map((dynamic e) => Simulcast.fromJson(e as Map<String, dynamic>))
          .toList(),
      genres: (json['genres'] as List<dynamic>)
          .map((dynamic e) => Genre.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_AnimeToJson(_$_Anime instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'country': instance.country,
      'name': instance.name,
      'releaseDate': instance.releaseDate,
      'image': instance.image,
      'description': instance.description,
      'hashes': instance.hashes,
      'simulcasts': instance.simulcasts,
      'genres': instance.genres,
    };
