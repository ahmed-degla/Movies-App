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

  final int? page;
  final int? limit;
  final String? quality;
  final int? minimumRating;
  final String? queryTerm;
  final String? genre;
  final String? sortBy;
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
  }) {
    return GetMoviesParams(
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
}
