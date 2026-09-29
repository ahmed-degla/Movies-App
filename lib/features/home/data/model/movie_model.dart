import 'package:json_annotation/json_annotation.dart';
import 'package:movies/features/home/domain/entity/movie_entity.dart';

part 'movie_model.g.dart';

@JsonSerializable(explicitToJson: true)
class MovieModel {
  const MovieModel({
    required this.id,
    this.url = '',
    this.imdbCode = '',
    this.title = '',
    this.titleEnglish = '',
    this.titleLong = '',
    this.slug = '',
    this.year = 0,
    this.rating = 0,
    this.runtime = 0,
    this.genres = const [],
    this.summary = '',
    this.description = '',
    this.synopsis = '',
    this.ytTrailerCode = '',
    this.language = '',
    this.mpaRating = '',
    this.backgroundImage = '',
    this.backgroundImageOriginal = '',
    this.smallCoverImage = '',
    this.mediumCoverImage = '',
    this.largeCoverImage = '',
    this.state = '',
    this.torrents = const [],
    this.dateUploaded = '',
    this.dateUploadedUnix = 0,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) =>
      _$MovieModelFromJson(json);

  Map<String, dynamic> toJson() => _$MovieModelToJson(this);

  @JsonKey(fromJson: _movieIdFromJson, toJson: _movieIdToJson)
  final int id;

  @JsonKey(defaultValue: '')
  final String url;

  @JsonKey(name: 'imdb_code', defaultValue: '')
  final String imdbCode;

  @JsonKey(defaultValue: '')
  final String title;

  @JsonKey(name: 'title_english', defaultValue: '')
  final String titleEnglish;

  @JsonKey(name: 'title_long', defaultValue: '')
  final String titleLong;

  @JsonKey(defaultValue: '')
  final String slug;

  @JsonKey(defaultValue: 0)
  final int year;

  @JsonKey(defaultValue: 0)
  final num rating;

  @JsonKey(defaultValue: 0)
  final int runtime;

  final List<String> genres;

  @JsonKey(defaultValue: '')
  final String summary;

  @JsonKey(name: 'description_full', defaultValue: '')
  final String description;

  @JsonKey(defaultValue: '')
  final String synopsis;

  @JsonKey(name: 'yt_trailer_code', defaultValue: '')
  final String ytTrailerCode;

  @JsonKey(defaultValue: '')
  final String language;

  @JsonKey(name: 'mpa_rating', defaultValue: '')
  final String mpaRating;

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
  final String state;

  final List<MovieTorrentModel> torrents;

  @JsonKey(name: 'date_uploaded', defaultValue: '')
  final String dateUploaded;

  @JsonKey(name: 'date_uploaded_unix', defaultValue: 0)
  final int dateUploadedUnix;

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

@JsonSerializable()
class MovieTorrentModel {
  const MovieTorrentModel({
    this.url = '',
    this.hash = '',
    this.quality = '',
    this.type = '',
    this.isRepack = '',
    this.videoCodec = '',
    this.bitDepth = '',
    this.audioChannels = '',
    this.seeds = 0,
    this.peers = 0,
    this.size = '',
    this.sizeBytes = 0,
    this.dateUploaded = '',
    this.dateUploadedUnix = 0,
  });

  factory MovieTorrentModel.fromJson(Map<String, dynamic> json) =>
      _$MovieTorrentModelFromJson(json);

  Map<String, dynamic> toJson() => _$MovieTorrentModelToJson(this);

  @JsonKey(defaultValue: '')
  final String url;

  @JsonKey(defaultValue: '')
  final String hash;

  @JsonKey(defaultValue: '')
  final String quality;

  @JsonKey(defaultValue: '')
  final String type;

  @JsonKey(name: 'is_repack', defaultValue: '')
  final String isRepack;

  @JsonKey(name: 'video_codec', defaultValue: '')
  final String videoCodec;

  @JsonKey(name: 'bit_depth', fromJson: _stringValueFromJson)
  final String bitDepth;

  @JsonKey(name: 'audio_channels', fromJson: _stringValueFromJson)
  final String audioChannels;

  @JsonKey(defaultValue: 0)
  final int seeds;

  @JsonKey(defaultValue: 0)
  final int peers;

  @JsonKey(defaultValue: '')
  final String size;

  @JsonKey(name: 'size_bytes', defaultValue: 0)
  final int sizeBytes;

  @JsonKey(name: 'date_uploaded', defaultValue: '')
  final String dateUploaded;

  @JsonKey(name: 'date_uploaded_unix', defaultValue: 0)
  final int dateUploadedUnix;
}

String _stringValueFromJson(Object? value) {
  if (value == null) return '';
  if (value is String) return value;
  if (value is num) return value.toString();
  throw FormatException('Invalid torrent string value: $value');
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
