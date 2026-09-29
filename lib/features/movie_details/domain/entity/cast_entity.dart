class CastEntity {
  const CastEntity({
    required this.name,
    required this.characterName,
    this.urlSmallImage,
    this.imdbCode,
  });

  final String name;
  final String characterName;
  final String? urlSmallImage;
  final String? imdbCode;
}
