import 'package:injectable/injectable.dart';
import 'package:movies/core/network/api_result.dart';
import 'package:movies/features/home/data/model/movie_model.dart';
import 'package:movies/features/movie_details/data/api_service/movie_details_api_service.dart';
import 'package:movies/features/movie_details/data/datasource/movie_details_remote_datasource.dart';
import 'package:movies/features/movie_details/data/model/movie_details_model.dart';
import 'package:movies/features/movie_details/data/model/movie_details_params.dart';
import 'package:movies/features/movie_details/domain/entity/movie_details_entity.dart';

@Injectable(as: MovieDetailsRemoteDataSource)
class MovieDetailsRemoteDataSourceImpl implements MovieDetailsRemoteDataSource {
  const MovieDetailsRemoteDataSourceImpl(this._apiService);

  final MovieDetailsApiService _apiService;

  @override
  FutureApiResult<MovieDetailsEntity> getMovieDetails(
    GetMovieDetailsParams params,
  ) async {
    try {
      final dynamic response = await _apiService.getMovieDetails(
        movieId: params.movieId,
        imdbId: params.imdbId,
        withImages: params.withImages,
        withCast: params.withCast,
      );

      if (response is! Map<String, dynamic>) {
        return const ApiError(message: 'Invalid response format');
      }

      final data = response['data'] as Map<String, dynamic>?;
      final movieJson = data?['movie'] as Map<String, dynamic>?;

      if (movieJson == null) {
        return const ApiError(message: 'Movie details not found');
      }

      final movie = MovieDetailsModel.fromJson(movieJson);
      return ApiSuccess(data: movie.toEntity());
    } on Exception catch (e) {
      return ApiError(message: e.toString());
    }
  }

  @override
  FutureApiResult<List<MovieModel>> getMovieSuggestions(int movieId) async {
    try {
      final dynamic response = await _apiService.getMovieSuggestions(
        movieId: movieId,
      );

      if (response is! Map<String, dynamic>) {
        return const ApiError(message: 'Invalid response format');
      }

      final data = response['data'] as Map<String, dynamic>?;
      final moviesJson = data?['movies'] as List<dynamic>? ?? const [];

      final movies = moviesJson
          .map((m) => MovieModel.fromJson(m as Map<String, dynamic>))
          .toList();

      return ApiSuccess(data: movies);
    } on Exception catch (e) {
      return ApiError(message: e.toString());
    }
  }
}
