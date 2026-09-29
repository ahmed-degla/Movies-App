import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/features/home/data/model/movies_response_model.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@lazySingleton
@RestApi()
abstract class ApiService {
  @factoryMethod
  factory ApiService(Dio dio) = _ApiService;

  @GET('list_movies.json')
  Future<MoviesResponseModel> getMovies({
    @Query('page') int? page,
    @Query('limit') int? limit,
    @Query('quality') String? quality,
    @Query('minimum_rating') int? minimumRating,
    @Query('query_term') String? queryTerm,
    @Query('genre') String? genre,
    @Query('sort_by') String? sortBy,
    @Query('order_by') String? orderBy,
  });
}
/*
  @GET('movie_details.json')
  Future<dynamic> getMovieDetails({
    @Query('movie_id') required int movieId,
    @Query('with_images') bool withImages = true,
    @Query('with_cast') bool withCast = true,
  });

  @GET('movie_suggestions.json')
  Future<dynamic> getMovieSuggestions({
    @Query('movie_id') required int movieId,
  });*/
