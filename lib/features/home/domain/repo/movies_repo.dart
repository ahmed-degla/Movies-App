import 'package:movies/core/network/api_result.dart';
import 'package:movies/features/home/data/model/movies_param.dart';
import 'package:movies/features/home/domain/entity/movies_page_entity.dart';

abstract interface class MoviesRepo {
  FutureApiResult<MoviesPageEntity> getMovies(GetMoviesParams params);
}
