import 'package:injectable/injectable.dart';
import 'package:movies/core/network/api_result.dart';
import 'package:movies/features/home/data/api_service/api_service.dart';
import 'package:movies/features/home/data/datasource/movie_datasource.dart';
import 'package:movies/features/home/data/model/movie_model.dart';

@Injectable(as: MovieDataSource)
class MovieDataSourceImpl implements MovieDataSource {
  MovieDataSourceImpl(this._apiService);

  final ApiService _apiService;

  @override
  FutureApiResult<List<MovieModel>> getMovies() async {
    try {
      final response = await _apiService.getMovies();
      final data = response['data'] as Map<String, dynamic>?;
      final moviesJson = data?['movies'] as List<dynamic>? ?? const [];
      final moviesList = moviesJson
          .map((e) => MovieModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return ApiSuccess(data: moviesList);
    } on Exception catch (e) {
      return ApiError(message: e.toString());
    }
  }
}
