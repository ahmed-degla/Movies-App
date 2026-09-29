class SimilarMovieEntity {
  const SimilarMovieEntity({
    required this.id,
    required this.title,
    required this.posterImage,
    required this.rating,
  });

  final int id;
  final String title;
  final String posterImage;
  final num rating;
}
