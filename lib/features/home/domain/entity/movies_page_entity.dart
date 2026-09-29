import 'package:movies/features/home/domain/entity/movie_entity.dart';

class MoviesPageEntity {
  const MoviesPageEntity({
    required this.movies,
    required this.totalCount,
    required this.limit,
    required this.pageNumber,
  });

  final List<MovieEntity> movies;
  final int totalCount;
  final int limit;
  final int pageNumber;
}
