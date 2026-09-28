import 'package:injectable/injectable.dart';
import 'package:movies/features/movie_details/data/datasource/movie_details_local_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Injectable(as: MovieDetailsLocalDataSource)
class MovieDetailsLocalDataSourceImpl implements MovieDetailsLocalDataSource {
  static const String _bookmarksKey = 'bookmarked_movie_ids';

  @override
  Future<bool> isBookmarked(int movieId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final bookmarks = prefs.getStringList(_bookmarksKey) ?? const [];
      return bookmarks.contains(movieId.toString());
    } on Exception catch (_) {
      return false;
    }
  }

  @override
  Future<bool> toggleBookmark(int movieId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final bookmarks =
          (prefs.getStringList(_bookmarksKey) ?? const []).toList();
      final idStr = movieId.toString();

      final bool isNowBookmarked;
      if (bookmarks.contains(idStr)) {
        bookmarks.remove(idStr);
        isNowBookmarked = false;
      } else {
        bookmarks.add(idStr);
        isNowBookmarked = true;
      }

      await prefs.setStringList(_bookmarksKey, bookmarks);
      return isNowBookmarked;
    } on Exception catch (_) {
      return false;
    }
  }
}
