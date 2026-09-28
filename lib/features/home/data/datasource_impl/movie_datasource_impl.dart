import 'package:injectable/injectable.dart';
import 'package:movies/core/network/api_result.dart';
import 'package:movies/features/home/data/api_service/api_service.dart';
import 'package:movies/features/home/data/datasource/movie_datasource.dart';
import 'package:movies/features/home/data/model/movie_model.dart';
import 'package:movies/features/home/data/model/movies_param.dart';

@Injectable(as: MovieDataSource)
class MovieDataSourceImpl implements MovieDataSource {
  MovieDataSourceImpl(this._apiService);

  final ApiService _apiService;

  @override
  FutureApiResult<List<MovieModel>> getMovies(GetMoviesParams params) async {
    try {
      final response = await _apiService.getMovies(
        page: params.page,
        limit: params.limit,
        quality: params.quality,
        minimumRating: params.minimumRating,
        queryTerm: params.queryTerm,
        genre: params.genre,
        sortBy: params.sortBy,
        orderBy: params.orderBy,
      ) as Map<String, dynamic>;

      final data = response['data'] as Map<String, dynamic>?;

      final moviesJson = data?['movies'] as List<dynamic>? ?? const [];

      final movies = moviesJson
          .map((movie) => MovieModel.fromJson(movie as Map<String, dynamic>))
          .toList();

      return ApiSuccess(data: movies);
    } on Exception catch (e) {
      return ApiError(message: e.toString());
    }
  }
}
