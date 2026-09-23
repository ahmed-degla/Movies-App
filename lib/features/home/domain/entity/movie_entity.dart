class MovieEntity {
  const MovieEntity({
    required this.id,
    required this.rating,
    required this.genres,
    required this.backgroundImage,
    required this.backgroundImageOriginal,
    required this.smallCoverImage,
    required this.mediumCoverImage,
    required this.largeCoverImage,
  });

  final String id;
  final num rating;
  final List<String> genres;
  final String backgroundImage;
  final String backgroundImageOriginal;
  final String smallCoverImage;
  final String mediumCoverImage;
  final String largeCoverImage;
}
