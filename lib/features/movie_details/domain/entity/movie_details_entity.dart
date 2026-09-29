import 'package:movies/features/home/domain/entity/movie_entity.dart';
import 'package:movies/features/movie_details/domain/entity/cast_entity.dart';
import 'package:movies/features/movie_details/domain/entity/torrent_entity.dart';

class MovieDetailsEntity {
  const MovieDetailsEntity({
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

  final int id;
  final String url;
  final String imdbCode;
  final String title;
  final String titleEnglish;
  final String titleLong;
  final String slug;
  final int year;
  final num rating;
  final int runtime;
  final List<String> genres;
  final int likeCount;
  final String descriptionIntro;
  final String descriptionFull;
  final String ytTrailerCode;
  final String language;
  final String mpaRating;
  final String backgroundImage;
  final String backgroundImageOriginal;
  final String smallCoverImage;
  final String mediumCoverImage;
  final String largeCoverImage;
  final List<String> screenshots;
  final List<CastEntity> cast;
  final List<TorrentEntity> torrents;

  MovieEntity toMovieEntity() => MovieEntity(
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
