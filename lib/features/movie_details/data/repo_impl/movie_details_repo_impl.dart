import 'package:injectable/injectable.dart';
import 'package:movies/core/internet_checker/internet_checker.dart';
import 'package:movies/core/network/api_result.dart';
import 'package:movies/core/utils/app_utils.dart';
import 'package:movies/features/movie_details/data/datasource/movie_details_datasource.dart';
import 'package:movies/features/movie_details/data/datasource/movie_details_local_datasource.dart';
import 'package:movies/features/movie_details/data/model/movie_details_mapper.dart';
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
      return ApiError(message: tr.movieDetailsNoInternet);
    }

    try {
      final detailsResult = await _remoteDataSource.getMovieDetails(movieId);
      switch (detailsResult) {
        case ApiError(:final message):
          return ApiError(message: message);
        case ApiSuccess(:final data):
          final suggestionsResult = await _remoteDataSource.getMovieSuggestions(
            movieId,
          );
          switch (suggestionsResult) {
            case ApiError(:final message):
              return ApiError(message: message);
            case ApiSuccess(data: final similarMovies):
              final isBookmarked = await _localDataSource.isBookmarked(
                data.id.toString(),
              );
              return ApiSuccess(
                data: data.copyWith(
                  similarMovies: similarMovies,
                  isBookmarked: isBookmarked,
                ),
              );
          }
      }
    } on Exception catch (e) {
      return ApiError(message: e.toString());
    }
  }

  @override
  FutureApiResult<bool> toggleBookmark(MovieDetailsEntity movie) async {
    try {
      final isBookmarked = await _localDataSource.toggleBookmark(
        toHomeMovieEntity(movie),
      );
      return ApiSuccess(data: isBookmarked);
    } on Exception catch (e) {
      return ApiError(message: e.toString());
    }
  }

  @override
  FutureApiResult<void> addToHistory(MovieDetailsEntity movie) async {
    try {
      await _localDataSource.addToHistory(toHomeMovieEntity(movie));
      return const ApiSuccess<void>(data: null);
    } on Exception catch (e) {
      return ApiError(message: e.toString());
    }
  }
}
