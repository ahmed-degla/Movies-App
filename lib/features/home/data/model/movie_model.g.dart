// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieModel _$MovieModelFromJson(Map<String, dynamic> json) => MovieModel(
  id: _movieIdFromJson(json['id']),
  url: json['url'] as String? ?? '',
  imdbCode: json['imdb_code'] as String? ?? '',
  title: json['title'] as String? ?? '',
  titleEnglish: json['title_english'] as String? ?? '',
  titleLong: json['title_long'] as String? ?? '',
  slug: json['slug'] as String? ?? '',
  year: (json['year'] as num?)?.toInt() ?? 0,
  rating: json['rating'] as num? ?? 0,
  runtime: (json['runtime'] as num?)?.toInt() ?? 0,
  genres:
      (json['genres'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  summary: json['summary'] as String? ?? '',
  description: json['description_full'] as String? ?? '',
  synopsis: json['synopsis'] as String? ?? '',
  ytTrailerCode: json['yt_trailer_code'] as String? ?? '',
  language: json['language'] as String? ?? '',
  mpaRating: json['mpa_rating'] as String? ?? '',
  backgroundImage: json['background_image'] as String? ?? '',
  backgroundImageOriginal: json['background_image_original'] as String? ?? '',
  smallCoverImage: json['small_cover_image'] as String? ?? '',
  mediumCoverImage: json['medium_cover_image'] as String? ?? '',
  largeCoverImage: json['large_cover_image'] as String? ?? '',
  state: json['state'] as String? ?? '',
  torrents:
      (json['torrents'] as List<dynamic>?)
          ?.map((e) => MovieTorrentModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  dateUploaded: json['date_uploaded'] as String? ?? '',
  dateUploadedUnix: (json['date_uploaded_unix'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$MovieModelToJson(MovieModel instance) =>
    <String, dynamic>{
      'id': _movieIdToJson(instance.id),
      'url': instance.url,
      'imdb_code': instance.imdbCode,
      'title': instance.title,
      'title_english': instance.titleEnglish,
      'title_long': instance.titleLong,
      'slug': instance.slug,
      'year': instance.year,
      'rating': instance.rating,
      'runtime': instance.runtime,
      'genres': instance.genres,
      'summary': instance.summary,
      'description_full': instance.description,
      'synopsis': instance.synopsis,
      'yt_trailer_code': instance.ytTrailerCode,
      'language': instance.language,
      'mpa_rating': instance.mpaRating,
      'background_image': instance.backgroundImage,
      'background_image_original': instance.backgroundImageOriginal,
      'small_cover_image': instance.smallCoverImage,
      'medium_cover_image': instance.mediumCoverImage,
      'large_cover_image': instance.largeCoverImage,
      'state': instance.state,
      'torrents': instance.torrents.map((e) => e.toJson()).toList(),
      'date_uploaded': instance.dateUploaded,
      'date_uploaded_unix': instance.dateUploadedUnix,
    };

MovieTorrentModel _$MovieTorrentModelFromJson(Map<String, dynamic> json) =>
    MovieTorrentModel(
      url: json['url'] as String? ?? '',
      hash: json['hash'] as String? ?? '',
      quality: json['quality'] as String? ?? '',
      type: json['type'] as String? ?? '',
      isRepack: json['is_repack'] as String? ?? '',
      videoCodec: json['video_codec'] as String? ?? '',
      bitDepth: json['bit_depth'] == null
          ? ''
          : _stringValueFromJson(json['bit_depth']),
      audioChannels: json['audio_channels'] == null
          ? ''
          : _stringValueFromJson(json['audio_channels']),
      seeds: (json['seeds'] as num?)?.toInt() ?? 0,
      peers: (json['peers'] as num?)?.toInt() ?? 0,
      size: json['size'] as String? ?? '',
      sizeBytes: (json['size_bytes'] as num?)?.toInt() ?? 0,
      dateUploaded: json['date_uploaded'] as String? ?? '',
      dateUploadedUnix: (json['date_uploaded_unix'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$MovieTorrentModelToJson(MovieTorrentModel instance) =>
    <String, dynamic>{
      'url': instance.url,
      'hash': instance.hash,
      'quality': instance.quality,
      'type': instance.type,
      'is_repack': instance.isRepack,
      'video_codec': instance.videoCodec,
      'bit_depth': instance.bitDepth,
      'audio_channels': instance.audioChannels,
      'seeds': instance.seeds,
      'peers': instance.peers,
      'size': instance.size,
      'size_bytes': instance.sizeBytes,
      'date_uploaded': instance.dateUploaded,
      'date_uploaded_unix': instance.dateUploadedUnix,
    };
