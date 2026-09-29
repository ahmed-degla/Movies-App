// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_details_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetMovieDetailsParams _$GetMovieDetailsParamsFromJson(
  Map<String, dynamic> json,
) => GetMovieDetailsParams(
  movieId: (json['movie_id'] as num?)?.toInt(),
  imdbId: json['imdb_id'] as String?,
  withImages: json['with_images'] as bool? ?? true,
  withCast: json['with_cast'] as bool? ?? true,
);

Map<String, dynamic> _$GetMovieDetailsParamsToJson(
  GetMovieDetailsParams instance,
) => <String, dynamic>{
  'movie_id': ?instance.movieId,
  'imdb_id': ?instance.imdbId,
  'with_images': instance.withImages,
  'with_cast': instance.withCast,
};
