// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cast_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CastModel _$CastModelFromJson(Map<String, dynamic> json) => CastModel(
  name: json['name'] as String? ?? '',
  characterName: json['character_name'] as String? ?? '',
  urlSmallImage: json['url_small_image'] as String?,
  imdbCode: _nullableStringFromJson(json['imdb_code']),
);

Map<String, dynamic> _$CastModelToJson(CastModel instance) => <String, dynamic>{
  'name': instance.name,
  'character_name': instance.characterName,
  'url_small_image': instance.urlSmallImage,
  'imdb_code': instance.imdbCode,
};
