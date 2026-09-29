import 'package:movies/features/home/domain/entity/movie_entity.dart';
import 'package:movies/features/movie_details/domain/entity/movie_details_entity.dart';

MovieEntity toHomeMovieEntity(MovieDetailsEntity movie) => MovieEntity(
  id: movie.id.toString(),
  rating: movie.rating,
  genres: movie.genres,
  backgroundImage: movie.backdropImage,
  backgroundImageOriginal: movie.backdropImage,
  smallCoverImage: movie.posterImage,
  mediumCoverImage: movie.posterImage,
  largeCoverImage: movie.posterImage,
);
