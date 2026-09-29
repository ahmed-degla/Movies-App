import 'package:movies/core/network/api_result.dart';
import 'package:movies/features/movie_details/domain/entity/movie_details_entity.dart';

abstract interface class MovieDetailsRepo {
  FutureApiResult<MovieDetailsEntity> getMovieDetails(int movieId);
  FutureApiResult<bool> toggleBookmark(MovieDetailsEntity movie);
  FutureApiResult<void> addToHistory(MovieDetailsEntity movie);
}
