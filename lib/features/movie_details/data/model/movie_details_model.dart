import 'package:movies/features/movie_details/data/model/cast_member_model.dart';
import 'package:movies/features/movie_details/data/model/similar_movie_model.dart';
import 'package:movies/features/movie_details/domain/entity/movie_details_entity.dart';

class MovieDetailsModel extends MovieDetailsEntity {
  const MovieDetailsModel({
    required super.id,
    required super.title,
    required super.releaseYear,
    required super.backdropImage,
    required super.posterImage,
    required super.rating,
    required super.runtime,
    required super.likesCount,
    required super.summary,
    required super.screenshots,
    required super.genres,
    required super.cast,
    required super.similarMovies,
    super.isBookmarked,
    super.trailerCode,
  });

  factory MovieDetailsModel.fromJson(
    Map<String, dynamic> json, {
    List<SimilarMovieModel> similarMovies = const [],
    bool isBookmarked = false,
  }) {
    final rawSummary = json['summary']?.toString();
    final rawDescFull = json['description_full']?.toString();
    final rawDescIntro = json['description_intro']?.toString();

    final summary = (rawSummary != null && rawSummary.isNotEmpty)
        ? rawSummary
        : ((rawDescFull != null && rawDescFull.isNotEmpty)
            ? rawDescFull
            : (rawDescIntro ?? ''));

    final screenshots = <String>[];
    for (final key in [
      'large_screenshot_image1',
      'large_screenshot_image2',
      'large_screenshot_image3',
      'medium_screenshot_image1',
      'medium_screenshot_image2',
      'medium_screenshot_image3',
    ]) {
      final url = json[key]?.toString();
      if (url != null && url.isNotEmpty && !screenshots.contains(url)) {
        screenshots.add(url);
      }
    }

    final castJson = json['cast'] as List<dynamic>? ?? const [];
    final cast = castJson
        .whereType<Map<String, dynamic>>()
        .map(CastMemberModel.fromJson)
        .toList();

    final genresJson = json['genres'] as List<dynamic>? ?? const [];
    final genres = genresJson.map((e) => e.toString()).toList();

    return MovieDetailsModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      title: json['title']?.toString() ?? '',
      releaseYear: (json['year'] as num?)?.toInt() ?? 0,
      backdropImage: json['background_image_original']?.toString() ??
          json['background_image']?.toString() ??
          '',
      posterImage: json['large_cover_image']?.toString() ??
          json['medium_cover_image']?.toString() ??
          json['small_cover_image']?.toString() ??
          '',
      rating: json['rating'] as num? ?? 0,
      runtime: (json['runtime'] as num?)?.toInt() ?? 0,
      likesCount: (json['like_count'] as num?)?.toInt() ?? 0,
      summary: summary,
      screenshots: screenshots,
      genres: genres,
      cast: cast,
      similarMovies: similarMovies,
      isBookmarked: isBookmarked,
      trailerCode: json['yt_trailer_code']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'year': releaseYear,
    'background_image': backdropImage,
    'large_cover_image': posterImage,
    'rating': rating,
    'runtime': runtime,
    'like_count': likesCount,
    'summary': summary,
    'genres': genres,
    'yt_trailer_code': trailerCode,
  };
}
