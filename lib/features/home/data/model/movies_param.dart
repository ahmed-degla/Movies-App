import 'package:json_annotation/json_annotation.dart';

part 'movies_param.g.dart';

@JsonSerializable(includeIfNull: false)
class GetMoviesParams {
  const GetMoviesParams({
    this.page,
    this.limit,
    this.quality,
    this.minimumRating,
    this.queryTerm,
    this.genre,
    this.sortBy,
    this.orderBy,
  });

  factory GetMoviesParams.fromJson(Map<String, dynamic> json) =>
      _$GetMoviesParamsFromJson(json);

  Map<String, dynamic> toJson() => _$GetMoviesParamsToJson(this);

  final int? page;
  final int? limit;
  final String? quality;
  @JsonKey(name: 'minimum_rating')
  final int? minimumRating;

  @JsonKey(name: 'query_term')
  final String? queryTerm;
  final String? genre;

  @JsonKey(name: 'sort_by')
  final String? sortBy;

  @JsonKey(name: 'order_by')
  final String? orderBy;

  GetMoviesParams copyWith({
    int? page,
    int? limit,
    String? quality,
    int? minimumRating,
    String? queryTerm,
    String? genre,
    String? sortBy,
    String? orderBy,
  }) => GetMoviesParams(
    page: page ?? this.page,
    limit: limit ?? this.limit,
    quality: quality ?? this.quality,
    minimumRating: minimumRating ?? this.minimumRating,
    queryTerm: queryTerm ?? this.queryTerm,
    genre: genre ?? this.genre,
    sortBy: sortBy ?? this.sortBy,
    orderBy: orderBy ?? this.orderBy,
  );
}
