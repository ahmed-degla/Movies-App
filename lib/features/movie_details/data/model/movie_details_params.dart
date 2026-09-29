import 'package:json_annotation/json_annotation.dart';

part 'movie_details_params.g.dart';

@JsonSerializable(includeIfNull: false)
class GetMovieDetailsParams {
  const GetMovieDetailsParams({
    this.movieId,
    this.imdbId,
    this.withImages = true,
    this.withCast = true,
  });

  factory GetMovieDetailsParams.fromJson(Map<String, dynamic> json) =>
      _$GetMovieDetailsParamsFromJson(json);

  Map<String, dynamic> toJson() => _$GetMovieDetailsParamsToJson(this);

  @JsonKey(name: 'movie_id')
  final int? movieId;

  @JsonKey(name: 'imdb_id')
  final String? imdbId;

  @JsonKey(name: 'with_images')
  final bool withImages;

  @JsonKey(name: 'with_cast')
  final bool withCast;
}
