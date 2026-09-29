import 'package:json_annotation/json_annotation.dart';
import 'package:movies/features/home/domain/entity/movie_entity.dart';

part 'movie_model.g.dart';

@JsonSerializable()
class MovieModel {
  const MovieModel({
    required this.id,
    required this.rating,
    required this.genres,
    required this.backgroundImage,
    required this.backgroundImageOriginal,
    required this.smallCoverImage,
    required this.mediumCoverImage,
    required this.largeCoverImage,
    required this.title,
    required this.description,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) =>
      _$MovieModelFromJson(json);

  Map<String, dynamic> toJson() => _$MovieModelToJson(this);

  @JsonKey(fromJson: _movieIdFromJson, toJson: _movieIdToJson)
  final int id;

  final num rating;

  @JsonKey(defaultValue: <String>[])
  final List<String> genres;

  @JsonKey(name: 'background_image', defaultValue: '')
  final String backgroundImage;

  @JsonKey(name: 'background_image_original', defaultValue: '')
  final String backgroundImageOriginal;

  @JsonKey(name: 'small_cover_image', defaultValue: '')
  final String smallCoverImage;

  @JsonKey(name: 'medium_cover_image', defaultValue: '')
  final String mediumCoverImage;

  @JsonKey(name: 'large_cover_image', defaultValue: '')
  final String largeCoverImage;

  @JsonKey(defaultValue: '')
  final String title;

  @JsonKey(name: 'description_full', defaultValue: '')
  final String description;

  MovieEntity toEntity() => MovieEntity(
    id: id.toString(),
    rating: rating,
    genres: genres,
    backgroundImage: backgroundImage,
    backgroundImageOriginal: backgroundImageOriginal,
    smallCoverImage: smallCoverImage,
    mediumCoverImage: mediumCoverImage,
    largeCoverImage: largeCoverImage,
  );
}

int _movieIdFromJson(Object? value) {
  if (value is num) return value.toInt();
  if (value is String) {
    final id = int.tryParse(value);
    if (id != null) return id;
  }
  throw FormatException('Invalid movie ID: $value');
}

Object _movieIdToJson(int value) => value;
