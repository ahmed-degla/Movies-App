import 'package:movies/features/movie_details/domain/entity/similar_movie_entity.dart';

class SimilarMovieModel extends SimilarMovieEntity {
  const SimilarMovieModel({
    required super.id,
    required super.title,
    required super.posterImage,
    required super.rating,
  });

  factory SimilarMovieModel.fromJson(Map<String, dynamic> json) =>
      SimilarMovieModel(
        id: (json['id'] as num?)?.toInt() ?? 0,
        title: json['title']?.toString() ?? '',
        posterImage: json['medium_cover_image']?.toString() ??
            json['large_cover_image']?.toString() ??
            json['small_cover_image']?.toString() ??
            '',
        rating: json['rating'] as num? ?? 0,
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'medium_cover_image': posterImage,
    'rating': rating,
  };
}
