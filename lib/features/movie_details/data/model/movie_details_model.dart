import 'package:movies/features/movie_details/data/model/cast_member_model.dart';
import 'package:movies/features/movie_details/data/model/json_parsers.dart';
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
    final rawSummary = parseJsonString(json['summary']);
    final rawDescFull = parseJsonString(json['description_full']);
    final rawDescIntro = parseJsonString(json['description_intro']);

    final summary = rawSummary.isNotEmpty
        ? rawSummary
        : (rawDescFull.isNotEmpty ? rawDescFull : rawDescIntro);

    final screenshots = <String>[];
    for (final key in [
      'large_screenshot_image1',
      'large_screenshot_image2',
      'large_screenshot_image3',
      'medium_screenshot_image1',
      'medium_screenshot_image2',
      'medium_screenshot_image3',
    ]) {
      final url = parseJsonString(json[key]);
      if (url.isNotEmpty && !screenshots.contains(url)) {
        screenshots.add(url);
      }
    }

    final cast = asJsonList(json['cast'])
        .map(asJsonMap)
        .whereType<Map<String, dynamic>>()
        .map(CastMemberModel.fromJson)
        .toList();

    final genres = asJsonList(json['genres']).map(parseJsonString).toList();

    return MovieDetailsModel(
      id: parseJsonInt(json['id']),
      title: parseJsonString(json['title']),
      releaseYear: parseJsonInt(json['year']),
      backdropImage:
          parseJsonString(json['background_image_original']).isNotEmpty
          ? parseJsonString(json['background_image_original'])
          : parseJsonString(json['background_image']),
      posterImage: parseJsonString(json['large_cover_image']).isNotEmpty
          ? parseJsonString(json['large_cover_image'])
          : (parseJsonString(json['medium_cover_image']).isNotEmpty
                ? parseJsonString(json['medium_cover_image'])
                : parseJsonString(json['small_cover_image'])),
      rating: parseJsonNum(json['rating']),
      runtime: parseJsonInt(json['runtime']),
      likesCount: parseJsonInt(json['like_count']),
      summary: summary,
      screenshots: screenshots,
      genres: genres,
      cast: cast,
      similarMovies: similarMovies,
      isBookmarked: isBookmarked,
      trailerCode: parseJsonString(json['yt_trailer_code']),
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
