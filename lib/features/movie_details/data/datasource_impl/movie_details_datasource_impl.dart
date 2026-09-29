import 'package:injectable/injectable.dart';
import 'package:movies/core/network/api_result.dart';
import 'package:movies/core/utils/app_utils.dart';
import 'package:movies/features/movie_details/data/api_service/movie_details_api_service.dart';
import 'package:movies/features/movie_details/data/datasource/movie_details_datasource.dart';
import 'package:movies/features/movie_details/data/model/json_parsers.dart';
import 'package:movies/features/movie_details/data/model/movie_details_model.dart';
import 'package:movies/features/movie_details/data/model/similar_movie_model.dart';

@Injectable(as: MovieDetailsDataSource)
class MovieDetailsDataSourceImpl implements MovieDetailsDataSource {
  MovieDetailsDataSourceImpl(this._apiService);

  final MovieDetailsApiService _apiService;

  @override
  FutureApiResult<MovieDetailsModel> getMovieDetails(int movieId) async {
    try {
      final response = await _apiService.getMovieDetails(movieId: movieId);
      final movieJson = asJsonMap(asJsonMap(response)?['data'])?['movie'];
      final movieMap = asJsonMap(movieJson);

      if (movieMap == null) {
        return ApiError(message: tr.movieDetailsLoadFailed);
      }

      return ApiSuccess(data: MovieDetailsModel.fromJson(movieMap));
    } on Exception catch (e) {
      return ApiError(message: e.toString());
    }
  }

  @override
  FutureApiResult<List<SimilarMovieModel>> getMovieSuggestions(
    int movieId,
  ) async {
    try {
      final response = await _apiService.getMovieSuggestions(movieId: movieId);
      final data = asJsonMap(asJsonMap(response)?['data']);
      if (data == null) {
        return ApiError(message: tr.movieDetailsSuggestionsFailed);
      }

      final movies = asJsonList(data['movies'])
          .map(asJsonMap)
          .whereType<Map<String, dynamic>>()
          .map(SimilarMovieModel.fromJson)
          .toList();

      return ApiSuccess(data: movies);
    } on Exception catch (e) {
      return ApiError(message: e.toString());
    }
  }
}
