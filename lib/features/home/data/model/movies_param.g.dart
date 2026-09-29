// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movies_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetMoviesParams _$GetMoviesParamsFromJson(Map<String, dynamic> json) =>
    GetMoviesParams(
      page: (json['page'] as num?)?.toInt(),
      limit: (json['limit'] as num?)?.toInt(),
      quality: json['quality'] as String?,
      minimumRating: (json['minimum_rating'] as num?)?.toInt(),
      queryTerm: json['query_term'] as String?,
      genre: json['genre'] as String?,
      sortBy: json['sort_by'] as String?,
      orderBy: json['order_by'] as String?,
    );

Map<String, dynamic> _$GetMoviesParamsToJson(GetMoviesParams instance) =>
    <String, dynamic>{
      'page': ?instance.page,
      'limit': ?instance.limit,
      'quality': ?instance.quality,
      'minimum_rating': ?instance.minimumRating,
      'query_term': ?instance.queryTerm,
      'genre': ?instance.genre,
      'sort_by': ?instance.sortBy,
      'order_by': ?instance.orderBy,
    };
