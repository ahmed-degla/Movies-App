abstract interface class MovieDetailsLocalDataSource {
  Future<bool> isBookmarked(int movieId);
  Future<bool> toggleBookmark(int movieId);
}
