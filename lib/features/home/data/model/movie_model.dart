import 'package:movies/features/home/domain/entity/movie_entity.dart';

class MovieModel extends MovieEntity {
  const MovieModel({
    required super.id,
    required super.rating,
    required super.genres,
    required super.backgroundImage,
    required super.backgroundImageOriginal,
    required super.smallCoverImage,
    required super.mediumCoverImage,
    required super.largeCoverImage,
    required this.title,
    required this.description,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
    id: json['id'].toString(),
    rating: json['rating'] ?? 0,
    genres: List<String>.from(json['genres'] ?? const []),
    backgroundImage: json['background_image'] ?? '',
    backgroundImageOriginal: json['background_image_original'] ?? '',
    smallCoverImage: json['small_cover_image'] ?? '',
    mediumCoverImage: json['medium_cover_image'] ?? '',
    largeCoverImage: json['large_cover_image'] ?? '',
    title: json['title'] ?? '',
    description: json['description_full'] ?? '',
  );

  final String title;
  final String description;
}
