import 'package:movies/core/network/api_result.dart';
import 'package:movies/features/home/domain/entity/movie_entity.dart';
import 'package:movies/features/movie_details/data/model/movie_details_params.dart';
import 'package:movies/features/movie_details/domain/entity/movie_details_entity.dart';

abstract interface class MovieDetailsRepo {
  FutureApiResult<MovieDetailsEntity> getMovieDetails(
    GetMovieDetailsParams params,
  );

  FutureApiResult<List<MovieEntity>> getMovieSuggestions(
    int movieId,
  );
}
