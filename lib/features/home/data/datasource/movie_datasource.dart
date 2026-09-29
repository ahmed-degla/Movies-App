import 'package:movies/core/network/api_result.dart';
import 'package:movies/features/home/data/model/movies_param.dart';
import 'package:movies/features/home/data/model/movies_response_model.dart';

abstract interface class MovieDataSource {
  FutureApiResult<MoviesDataModel> getMovies(GetMoviesParams params);
}
