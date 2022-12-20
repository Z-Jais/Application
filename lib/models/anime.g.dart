// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anime.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Anime _$AnimeFromJson(Map<String, dynamic> json) => Anime(
      uuid: json['uuid'] as String,
      country: Country.fromJson(json['country'] as Map<String, dynamic>),
      name: json['name'] as String,
      releaseDate: json['releaseDate'] as String,
      image: json['image'] as String,
      description: json['description'] as String?,
      hashes:
          (json['hashes'] as List<dynamic>).map((e) => e as String).toList(),
      simulcasts: (json['simulcasts'] as List<dynamic>)
          .map((e) => Simulcast.fromJson(e as Map<String, dynamic>))
          .toList(),
      genres: (json['genres'] as List<dynamic>)
          .map((e) => Genre.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AnimeToJson(Anime instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'country': instance.country.toJson(),
      'name': instance.name,
      'releaseDate': instance.releaseDate,
      'image': instance.image,
      'description': instance.description,
      'hashes': instance.hashes,
      'simulcasts': instance.simulcasts.map((e) => e.toJson()).toList(),
      'genres': instance.genres.map((e) => e.toJson()).toList(),
    };
