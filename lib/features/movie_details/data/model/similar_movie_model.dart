import 'package:movies/features/movie_details/data/model/json_parsers.dart';
import 'package:movies/features/movie_details/domain/entity/similar_movie_entity.dart';

class SimilarMovieModel extends SimilarMovieEntity {
  const SimilarMovieModel({
    required super.id,
    required super.title,
    required super.posterImage,
    required super.rating,
  });

  factory SimilarMovieModel.fromJson(Map<String, dynamic> json) {
    final mediumCover = parseJsonString(json['medium_cover_image']);
    final largeCover = parseJsonString(json['large_cover_image']);
    final smallCover = parseJsonString(json['small_cover_image']);

    return SimilarMovieModel(
      id: parseJsonInt(json['id']),
      title: parseJsonString(json['title']),
      posterImage: mediumCover.isNotEmpty
          ? mediumCover
          : (largeCover.isNotEmpty ? largeCover : smallCover),
      rating: parseJsonNum(json['rating']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'medium_cover_image': posterImage,
    'rating': rating,
  };
}
