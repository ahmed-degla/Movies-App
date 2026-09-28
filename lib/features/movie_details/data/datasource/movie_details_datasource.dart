import 'package:movies/core/network/api_result.dart';
import 'package:movies/features/movie_details/data/model/movie_details_model.dart';
import 'package:movies/features/movie_details/data/model/similar_movie_model.dart';

abstract interface class MovieDetailsDataSource {
  FutureApiResult<MovieDetailsModel> getMovieDetails(int movieId);
  Future<List<SimilarMovieModel>> getMovieSuggestions(int movieId);
}
