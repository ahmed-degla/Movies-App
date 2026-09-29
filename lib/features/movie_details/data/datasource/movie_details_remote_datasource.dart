import 'package:movies/core/network/api_result.dart';
import 'package:movies/features/home/data/model/movie_model.dart';
import 'package:movies/features/movie_details/data/model/movie_details_params.dart';
import 'package:movies/features/movie_details/domain/entity/movie_details_entity.dart';

abstract interface class MovieDetailsRemoteDataSource {
  FutureApiResult<MovieDetailsEntity> getMovieDetails(
    GetMovieDetailsParams params,
  );

  FutureApiResult<List<MovieModel>> getMovieSuggestions(int movieId);
}
