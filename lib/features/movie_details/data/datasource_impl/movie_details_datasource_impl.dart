import 'package:injectable/injectable.dart';
import 'package:movies/core/network/api_result.dart';
import 'package:movies/features/movie_details/data/api_service/movie_details_api_service.dart';
import 'package:movies/features/movie_details/data/datasource/movie_details_datasource.dart';
import 'package:movies/features/movie_details/data/model/movie_details_model.dart';
import 'package:movies/features/movie_details/data/model/similar_movie_model.dart';

@Injectable(as: MovieDetailsDataSource)
class MovieDetailsDataSourceImpl implements MovieDetailsDataSource {
  MovieDetailsDataSourceImpl(this._apiService);

  final MovieDetailsApiService _apiService;

  @override
  FutureApiResult<MovieDetailsModel> getMovieDetails(int movieId) async {
    try {
      final response = await _apiService.getMovieDetails(
        movieId: movieId,
      ) as Map<String, dynamic>?;

      final data = response?['data'] as Map<String, dynamic>?;
      final movieJson = data?['movie'] as Map<String, dynamic>?;

      if (movieJson == null) {
        return const ApiError(message: 'Movie details not found');
      }

      final movie = MovieDetailsModel.fromJson(movieJson);
      return ApiSuccess(data: movie);
    } on Exception catch (e) {
      return ApiError(message: e.toString());
    }
  }

  @override
  Future<List<SimilarMovieModel>> getMovieSuggestions(int movieId) async {
    try {
      final response = await _apiService.getMovieSuggestions(movieId: movieId)
          as Map<String, dynamic>?;
      final data = response?['data'] as Map<String, dynamic>?;
      final moviesJson = data?['movies'] as List<dynamic>? ?? const [];

      return moviesJson
          .whereType<Map<String, dynamic>>()
          .map(SimilarMovieModel.fromJson)
          .toList();
    } on Exception catch (_) {
      return const [];
    }
  }
}
