import 'package:json_annotation/json_annotation.dart';
import 'package:movies/features/home/domain/entity/movie_entity.dart';
import 'package:movies/features/movie_details/data/model/cast_model.dart';
import 'package:movies/features/movie_details/data/model/torrent_model.dart';
import 'package:movies/features/movie_details/domain/entity/movie_details_entity.dart';

part 'movie_details_model.g.dart';

@JsonSerializable(explicitToJson: true)
class MovieDetailsModel {
  const MovieDetailsModel({
    required this.id,
    required this.url,
    required this.imdbCode,
    required this.title,
    required this.titleEnglish,
    required this.titleLong,
    required this.slug,
    required this.year,
    required this.rating,
    required this.runtime,
    required this.genres,
    required this.likeCount,
    required this.descriptionIntro,
    required this.descriptionFull,
    required this.ytTrailerCode,
    required this.language,
    required this.mpaRating,
    required this.backgroundImage,
    required this.backgroundImageOriginal,
    required this.smallCoverImage,
    required this.mediumCoverImage,
    required this.largeCoverImage,
    required this.screenshots,
    required this.cast,
    required this.torrents,
  });

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDetailsModelToJson(this);

  final int id;
  final String url;

  @JsonKey(name: 'imdb_code', fromJson: _stringFromJson)
  final String imdbCode;

  final String title;

  @JsonKey(name: 'title_english')
  final String titleEnglish;

  @JsonKey(name: 'title_long')
  final String titleLong;

  final String slug;
  final int year;
  final num rating;
  final int runtime;
  final List<String> genres;

  @JsonKey(name: 'like_count')
  final int likeCount;

  @JsonKey(name: 'description_intro')
  final String descriptionIntro;

  @JsonKey(name: 'description_full')
  final String descriptionFull;

  @JsonKey(name: 'yt_trailer_code')
  final String ytTrailerCode;

  final String language;

  @JsonKey(name: 'mpa_rating')
  final String mpaRating;

  @JsonKey(name: 'background_image')
  final String backgroundImage;

  @JsonKey(name: 'background_image_original')
  final String backgroundImageOriginal;

  @JsonKey(name: 'small_cover_image')
  final String smallCoverImage;

  @JsonKey(name: 'medium_cover_image')
  final String mediumCoverImage;

  @JsonKey(name: 'large_cover_image')
  final String largeCoverImage;

  @JsonKey(readValue: _readScreenshots, includeToJson: false)
  final List<String> screenshots;

  @JsonKey(defaultValue: <CastModel>[])
  final List<CastModel> cast;

  @JsonKey(defaultValue: <TorrentModel>[])
  final List<TorrentModel> torrents;

  MovieDetailsEntity toEntity() => MovieDetailsEntity(
    id: id,
    url: url,
    imdbCode: imdbCode,
    title: title,
    titleEnglish: titleEnglish,
    titleLong: titleLong,
    slug: slug,
    year: year,
    rating: rating,
    runtime: runtime,
    genres: genres,
    likeCount: likeCount,
    descriptionIntro: descriptionIntro,
    descriptionFull: descriptionFull,
    ytTrailerCode: ytTrailerCode,
    language: language,
    mpaRating: mpaRating,
    backgroundImage: backgroundImage,
    backgroundImageOriginal: backgroundImageOriginal,
    smallCoverImage: smallCoverImage,
    mediumCoverImage: mediumCoverImage,
    largeCoverImage: largeCoverImage,
    screenshots: screenshots,
    cast: cast.map((item) => item.toEntity()).toList(),
    torrents: torrents.map((item) => item.toEntity()).toList(),
  );

  MovieEntity toMovieEntity() => toEntity().toMovieEntity();
}

String _stringFromJson(Object? value) {
  if (value is String) return value;
  if (value is num) return value.toString();
  return '';
}

Object? _readScreenshots(Map<dynamic, dynamic> json, String key) {
  final screenshots = <String>[];
  for (final index in [1, 2, 3]) {
    final large = json['large_screenshot_image$index'];
    final medium = json['medium_screenshot_image$index'];
    final screenshot = large is String && large.isNotEmpty
        ? large
        : medium is String && medium.isNotEmpty
        ? medium
        : null;
    if (screenshot != null) screenshots.add(screenshot);
  }
  return screenshots;
}
