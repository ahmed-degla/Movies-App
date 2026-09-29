import 'package:injectable/injectable.dart';
import 'package:movies/core/internet_checker/internet_checker.dart';
import 'package:movies/core/network/api_result.dart';
import 'package:movies/features/home/data/model/movie_model.dart';
import 'package:movies/features/home/domain/entity/movie_entity.dart';
import 'package:movies/features/movie_details/data/datasource/movie_details_remote_datasource.dart';
import 'package:movies/features/movie_details/data/model/movie_details_params.dart';
import 'package:movies/features/movie_details/domain/entity/movie_details_entity.dart';
import 'package:movies/features/movie_details/domain/repo/movie_details_repo.dart';

@Injectable(as: MovieDetailsRepo)
class MovieDetailsRepoImpl implements MovieDetailsRepo {
  const MovieDetailsRepoImpl(this._remoteDataSource);

  final MovieDetailsRemoteDataSource _remoteDataSource;

  @override
  FutureApiResult<MovieDetailsEntity> getMovieDetails(
    GetMovieDetailsParams params,
  ) async {
    if (!await InternetChecker.checkConnection()) {
      return const ApiError(message: 'No internet connection');
    }

    try {
      final result = await _remoteDataSource.getMovieDetails(params);
      return switch (result) {
        ApiSuccess<MovieDetailsEntity>(:final data) => ApiSuccess(data: data),
        ApiError(:final message) => ApiError(message: message),
      };
    } on Exception catch (e) {
      return ApiError(message: e.toString());
    }
  }

  @override
  FutureApiResult<List<MovieEntity>> getMovieSuggestions(int movieId) async {
    if (!await InternetChecker.checkConnection()) {
      return const ApiError(message: 'No internet connection');
    }

    try {
      final result = await _remoteDataSource.getMovieSuggestions(movieId);
      return switch (result) {
        ApiSuccess<List<MovieModel>>(:final data) => ApiSuccess(
          data: data.map((movie) => movie.toEntity()).toList(),
        ),
        ApiError(:final message) => ApiError(message: message),
      };
    } on Exception catch (e) {
      return ApiError(message: e.toString());
    }
  }
}
