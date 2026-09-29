import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'movie_details_api_service.g.dart';

@lazySingleton
@RestApi()
abstract class MovieDetailsApiService {
  @factoryMethod
  factory MovieDetailsApiService(Dio dio) = _MovieDetailsApiService;

  @GET('movie_details.json')
  Future<dynamic> getMovieDetails({
    @Query('movie_id') int? movieId,
    @Query('imdb_id') String? imdbId,
    @Query('with_images') bool? withImages,
    @Query('with_cast') bool? withCast,
  });

  @GET('movie_suggestions.json')
  Future<dynamic> getMovieSuggestions({
    @Query('movie_id') required int movieId,
  });
}
