import 'package:injectable/injectable.dart';
import 'package:movies/core/firebase_service/firebase_auth_service.dart';
import 'package:movies/features/home/domain/entity/movie_entity.dart';
import 'package:movies/features/movie_details/data/datasource/movie_details_local_datasource.dart';

@Injectable(as: MovieDetailsLocalDataSource)
class MovieDetailsLocalDataSourceImpl implements MovieDetailsLocalDataSource {
  MovieDetailsLocalDataSourceImpl(this._firebaseAuthService);

  final FirebaseAuthService _firebaseAuthService;

  @override
  Future<bool> isBookmarked(String movieId) async {
    if (_firebaseAuthService.currentUser == null) {
      return false;
    }
    final watchlist = await _firebaseAuthService.watchlistStream().first;
    return watchlist.any((movie) => movie.id == movieId);
  }

  @override
  Future<bool> toggleBookmark(MovieEntity movie) async {
    if (_firebaseAuthService.currentUser == null) {
      throw Exception('A signed-in user is required.');
    }
    final currentlyBookmarked = await isBookmarked(movie.id);
    if (currentlyBookmarked) {
      await _firebaseAuthService.removeFromWatchlist(movie.id);
      return false;
    }

    await _firebaseAuthService.addToWatchlist(movie);
    return true;
  }

  @override
  Future<void> addToHistory(MovieEntity movie) async {
    if (_firebaseAuthService.currentUser == null) {
      return;
    }
    await _firebaseAuthService.addToHistory(movie);
  }
}
