// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieModel _$MovieModelFromJson(Map<String, dynamic> json) => MovieModel(
  id: _movieIdFromJson(json['id']),
  rating: json['rating'] as num,
  genres:
      (json['genres'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      [],
  backgroundImage: json['background_image'] as String? ?? '',
  backgroundImageOriginal: json['background_image_original'] as String? ?? '',
  smallCoverImage: json['small_cover_image'] as String? ?? '',
  mediumCoverImage: json['medium_cover_image'] as String? ?? '',
  largeCoverImage: json['large_cover_image'] as String? ?? '',
  title: json['title'] as String? ?? '',
  description: json['description_full'] as String? ?? '',
);

Map<String, dynamic> _$MovieModelToJson(MovieModel instance) =>
    <String, dynamic>{
      'id': _movieIdToJson(instance.id),
      'rating': instance.rating,
      'genres': instance.genres,
      'background_image': instance.backgroundImage,
      'background_image_original': instance.backgroundImageOriginal,
      'small_cover_image': instance.smallCoverImage,
      'medium_cover_image': instance.mediumCoverImage,
      'large_cover_image': instance.largeCoverImage,
      'title': instance.title,
      'description_full': instance.description,
    };
