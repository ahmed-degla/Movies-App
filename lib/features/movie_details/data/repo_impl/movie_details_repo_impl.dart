import 'package:injectable/injectable.dart';
import 'package:movies/core/internet_checker/internet_checker.dart';
import 'package:movies/core/network/api_result.dart';
import 'package:movies/features/movie_details/data/datasource/movie_details_datasource.dart';
import 'package:movies/features/movie_details/data/datasource/movie_details_local_datasource.dart';
import 'package:movies/features/movie_details/domain/entity/movie_details_entity.dart';
import 'package:movies/features/movie_details/domain/repo/movie_details_repo.dart';

@Injectable(as: MovieDetailsRepo)
class MovieDetailsRepoImpl implements MovieDetailsRepo {
  MovieDetailsRepoImpl(this._remoteDataSource, this._localDataSource);

  final MovieDetailsDataSource _remoteDataSource;
  final MovieDetailsLocalDataSource _localDataSource;

  @override
  FutureApiResult<MovieDetailsEntity> getMovieDetails(int movieId) async {
    if (!await InternetChecker.checkConnection()) {
      return const ApiError(message: 'No internet connection');
    }

    try {
      final detailsFuture = _remoteDataSource.getMovieDetails(movieId);
      final suggestionsFuture = _remoteDataSource.getMovieSuggestions(movieId);
      final isBookmarkedFuture = _localDataSource.isBookmarked(movieId);

      final detailsResult = await detailsFuture;
      final suggestions = await suggestionsFuture;
      final isBookmarked = await isBookmarkedFuture;

      return switch (detailsResult) {
        ApiSuccess(:final data) => ApiSuccess(
            data: data.copyWith(
              similarMovies: suggestions,
              isBookmarked: isBookmarked,
            ),
          ),
        ApiError(:final message) => ApiError(message: message),
      };
    } on Exception catch (e) {
      return ApiError(message: e.toString());
    }
  }

  @override
  FutureApiResult<bool> toggleBookmark(int movieId) async {
    try {
      final result = await _localDataSource.toggleBookmark(movieId);
      return ApiSuccess(data: result);
    } on Exception catch (e) {
      return ApiError(message: e.toString());
    }
  }
}
