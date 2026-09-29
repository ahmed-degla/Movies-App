import 'package:json_annotation/json_annotation.dart';
import 'package:movies/features/home/data/model/movie_model.dart';

part 'movies_response_model.g.dart';

@JsonSerializable(explicitToJson: true)
class MoviesResponseModel {
  const MoviesResponseModel({
    required this.data,
    this.status = '',
    this.statusMessage = '',
  });

  factory MoviesResponseModel.fromJson(Map<String, dynamic> json) =>
      _$MoviesResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$MoviesResponseModelToJson(this);

  @JsonKey(defaultValue: '')
  final String status;

  @JsonKey(name: 'status_message', defaultValue: '')
  final String statusMessage;

  final MoviesDataModel data;
}

@JsonSerializable(explicitToJson: true)
class MoviesDataModel {
  const MoviesDataModel({
    this.movieCount = 0,
    this.limit = 0,
    this.pageNumber = 0,
    this.movies = const [],
  });

  factory MoviesDataModel.fromJson(Map<String, dynamic> json) =>
      _$MoviesDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$MoviesDataModelToJson(this);

  @JsonKey(name: 'movie_count', defaultValue: 0)
  final int movieCount;

  @JsonKey(defaultValue: 0)
  final int limit;

  @JsonKey(name: 'page_number', defaultValue: 0)
  final int pageNumber;

  final List<MovieModel> movies;
}
