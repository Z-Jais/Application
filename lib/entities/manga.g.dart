// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Manga _$$_MangaFromJson(Map<String, dynamic> json) => _$_Manga(
      uuid: json['uuid'] as String,
      platform: Platform.fromJson(json['platform'] as Map<String, dynamic>),
      anime: Anime.fromJson(json['anime'] as Map<String, dynamic>),
      hash: json['hash'] as String,
      releaseDate: json['releaseDate'] as String,
      url: json['url'] as String,
      cover: json['cover'] as String,
      editor: json['editor'] as String,
      ref: json['ref'] as String?,
      ean: json['ean'] as int?,
      age: json['age'] as int?,
      price: (json['price'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$_MangaToJson(_$_Manga instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'platform': instance.platform,
      'anime': instance.anime,
      'hash': instance.hash,
      'releaseDate': instance.releaseDate,
      'url': instance.url,
      'cover': instance.cover,
      'editor': instance.editor,
      'ref': instance.ref,
      'ean': instance.ean,
      'age': instance.age,
      'price': instance.price,
    };
