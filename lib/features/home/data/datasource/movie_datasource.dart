import 'package:movies/core/network/api_result.dart';
import 'package:movies/features/home/data/model/movie_model.dart';

abstract interface class MovieDataSource {
  FutureApiResult<List<MovieModel>> getMovies();
}