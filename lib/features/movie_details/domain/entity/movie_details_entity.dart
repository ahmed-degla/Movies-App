import 'package:movies/features/movie_details/domain/entity/cast_member_entity.dart';
import 'package:movies/features/movie_details/domain/entity/similar_movie_entity.dart';

class MovieDetailsEntity {
  const MovieDetailsEntity({
    required this.id,
    required this.title,
    required this.releaseYear,
    required this.backdropImage,
    required this.posterImage,
    required this.rating,
    required this.runtime,
    required this.likesCount,
    required this.summary,
    required this.screenshots,
    required this.genres,
    required this.cast,
    required this.similarMovies,
    this.isBookmarked = false,
    this.trailerCode = '',
  });

  final int id;
  final String title;
  final int releaseYear;
  final String backdropImage;
  final String posterImage;
  final num rating;
  final int runtime;
  final int likesCount;
  final String summary;
  final List<String> screenshots;
  final List<String> genres;
  final List<CastMemberEntity> cast;
  final List<SimilarMovieEntity> similarMovies;
  final bool isBookmarked;
  final String trailerCode;

  MovieDetailsEntity copyWith({
    int? id,
    String? title,
    int? releaseYear,
    String? backdropImage,
    String? posterImage,
    num? rating,
    int? runtime,
    int? likesCount,
    String? summary,
    List<String>? screenshots,
    List<String>? genres,
    List<CastMemberEntity>? cast,
    List<SimilarMovieEntity>? similarMovies,
    bool? isBookmarked,
    String? trailerCode,
  }) =>
      MovieDetailsEntity(
        id: id ?? this.id,
        title: title ?? this.title,
        releaseYear: releaseYear ?? this.releaseYear,
        backdropImage: backdropImage ?? this.backdropImage,
        posterImage: posterImage ?? this.posterImage,
        rating: rating ?? this.rating,
        runtime: runtime ?? this.runtime,
        likesCount: likesCount ?? this.likesCount,
        summary: summary ?? this.summary,
        screenshots: screenshots ?? this.screenshots,
        genres: genres ?? this.genres,
        cast: cast ?? this.cast,
        similarMovies: similarMovies ?? this.similarMovies,
        isBookmarked: isBookmarked ?? this.isBookmarked,
        trailerCode: trailerCode ?? this.trailerCode,
      );
}
