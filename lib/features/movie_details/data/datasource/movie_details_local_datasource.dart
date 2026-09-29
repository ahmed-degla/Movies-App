import 'package:movies/features/home/domain/entity/movie_entity.dart';

abstract interface class MovieDetailsLocalDataSource {
  Future<bool> isBookmarked(String movieId);
  Future<bool> toggleBookmark(MovieEntity movie);
  Future<void> addToHistory(MovieEntity movie);
}
