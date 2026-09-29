// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movies_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MoviesResponseModel _$MoviesResponseModelFromJson(Map<String, dynamic> json) =>
    MoviesResponseModel(
      data: MoviesDataModel.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'] as String? ?? '',
      statusMessage: json['status_message'] as String? ?? '',
    );

Map<String, dynamic> _$MoviesResponseModelToJson(
  MoviesResponseModel instance,
) => <String, dynamic>{
  'status': instance.status,
  'status_message': instance.statusMessage,
  'data': instance.data.toJson(),
};

MoviesDataModel _$MoviesDataModelFromJson(Map<String, dynamic> json) =>
    MoviesDataModel(
      movieCount: (json['movie_count'] as num?)?.toInt() ?? 0,
      limit: (json['limit'] as num?)?.toInt() ?? 0,
      pageNumber: (json['page_number'] as num?)?.toInt() ?? 0,
      movies:
          (json['movies'] as List<dynamic>?)
              ?.map((e) => MovieModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$MoviesDataModelToJson(MoviesDataModel instance) =>
    <String, dynamic>{
      'movie_count': instance.movieCount,
      'limit': instance.limit,
      'page_number': instance.pageNumber,
      'movies': instance.movies.map((e) => e.toJson()).toList(),
    };
