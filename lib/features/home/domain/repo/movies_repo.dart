import 'package:movies/core/network/api_result.dart';
import 'package:movies/features/home/data/model/movies_param.dart';
import 'package:movies/features/home/domain/entity/movie_entity.dart';

abstract interface class MoviesRepo {
  FutureApiResult<List<MovieEntity>> getMovies(GetMoviesParams params);
}
