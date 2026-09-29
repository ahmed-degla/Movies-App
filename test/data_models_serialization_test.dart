import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies/core/models/user_model.dart';
import 'package:movies/features/home/data/model/movie_model.dart';
import 'package:movies/features/home/data/model/movies_param.dart';
import 'package:movies/features/home/data/model/movies_response_model.dart';
import 'package:movies/features/movie_details/data/model/cast_model.dart';
import 'package:movies/features/movie_details/data/model/movie_details_model.dart';
import 'package:movies/features/movie_details/data/model/movie_details_params.dart';
import 'package:movies/features/movie_details/data/model/torrent_model.dart';

void main() {
  group('JSON data models', () {
    test('movie model maps API field names and numeric IDs', () {
      final movie = MovieModel.fromJson({
        'id': 78812,
        'title': 'Movie',
        'description_full': 'Description',
        'rating': 7.5,
        'genres': ['Drama'],
        'background_image': 'https://example.test/background.jpg',
        'background_image_original': 'https://example.test/original.jpg',
        'small_cover_image': 'https://example.test/small.jpg',
        'medium_cover_image': 'https://example.test/medium.jpg',
        'large_cover_image': 'https://example.test/large.jpg',
      });

      expect(movie.id, 78812);
      expect(movie.toJson()['id'], 78812);
      expect(movie.backgroundImage, 'https://example.test/background.jpg');
      expect(movie.description, 'Description');
      expect(movie.toEntity().id, '78812');
    });

    test('movies response maps complete API data and ignores @meta', () {
      final response = MoviesResponseModel.fromJson({
        'status': 'ok',
        'status_message': 'Query was successful',
        'data': {
          'movie_count': 1,
          'limit': 20,
          'page_number': 1,
          'movies': [
            {
              'id': 78812,
              'url': 'https://example.test/movie',
              'imdb_code': 'tt1234567',
              'title': 'Movie',
              'title_english': 'Movie',
              'title_long': 'Movie (2026)',
              'slug': 'movie-2026',
              'year': 2026,
              'rating': 7.5,
              'runtime': 100,
              'genres': ['Drama'],
              'summary': 'Summary',
              'description_full': 'Description',
              'synopsis': 'Synopsis',
              'yt_trailer_code': 'trailer',
              'language': 'en',
              'mpa_rating': 'PG',
              'background_image': 'https://example.test/background.jpg',
              'background_image_original':
                  'https://example.test/background-original.jpg',
              'small_cover_image': 'https://example.test/small.jpg',
              'medium_cover_image': 'https://example.test/medium.jpg',
              'large_cover_image': 'https://example.test/large.jpg',
              'state': 'ok',
              'torrents': [
                {
                  'url': 'https://example.test/torrent',
                  'hash': 'hash',
                  'quality': '720p',
                  'type': 'bluray',
                  'is_repack': '0',
                  'video_codec': 'x264',
                  'bit_depth': '8',
                  'audio_channels': '2.0',
                  'seeds': 10,
                  'peers': 2,
                  'size': '1 GB',
                  'size_bytes': 1000000,
                  'date_uploaded': '2026-09-29 12:00:00',
                  'date_uploaded_unix': 1790683200,
                },
              ],
              'date_uploaded': '2026-09-29 12:00:00',
              'date_uploaded_unix': 1790683200,
            },
          ],
        },
        '@meta': {'api_version': 2, 'execution_time': 0.01},
      });

      final movie = response.data.movies.single;
      expect(response.data.movieCount, 1);
      expect(response.data.limit, 20);
      expect(response.data.pageNumber, 1);
      expect(movie.imdbCode, 'tt1234567');
      expect(movie.description, 'Description');
      expect(movie.torrents.single.isRepack, '0');
      expect(movie.torrents.single.dateUploadedUnix, 1790683200);
      expect(response.toJson().containsKey('@meta'), isFalse);
      expect(response.toJson()['data'], isA<Map<String, dynamic>>());
    });

    test('nested movie details decode screenshots, cast, and torrents', () {
      final movie = MovieDetailsModel.fromJson({
        'id': 78812,
        'url': 'https://example.test/movie',
        'imdb_code': 123,
        'title': 'Movie',
        'title_english': 'Movie',
        'title_long': 'Movie (2026)',
        'slug': 'movie',
        'year': 2026,
        'rating': 7.5,
        'runtime': 100,
        'genres': ['Drama'],
        'like_count': 2,
        'description_intro': 'Intro',
        'description_full': 'Description',
        'yt_trailer_code': '',
        'language': 'en',
        'mpa_rating': '',
        'background_image': 'https://example.test/background.jpg',
        'background_image_original': 'https://example.test/original.jpg',
        'small_cover_image': 'https://example.test/small.jpg',
        'medium_cover_image': 'https://example.test/medium.jpg',
        'large_cover_image': 'https://example.test/large.jpg',
        'large_screenshot_image1': 'https://example.test/screenshot.jpg',
        'cast': [
          {'name': 'Actor', 'character_name': 'Character', 'imdb_code': 456},
        ],
        'torrents': [
          {
            'url': 'https://example.test/torrent',
            'hash': 'hash',
            'quality': '1080p',
            'type': 'web',
            'seeds': 10,
            'peers': 2,
            'size': '1 GB',
            'size_bytes': 1000000,
            'bit_depth': 10,
            'audio_channels': 2,
          },
        ],
      });

      expect(movie.imdbCode, '123');
      expect(movie.screenshots, ['https://example.test/screenshot.jpg']);
      expect(movie.cast.single.imdbCode, '456');
      expect(movie.torrents.single.bitDepth, '10');
      expect(movie.toEntity().toMovieEntity().id, '78812');
    });

    test('parameter models serialize API query keys', () {
      expect(
        const GetMoviesParams(minimumRating: 7, queryTerm: 'film').toJson(),
        {'minimum_rating': 7, 'query_term': 'film'},
      );
      expect(const GetMovieDetailsParams(movieId: 78812).toJson(), {
        'movie_id': 78812,
        'with_images': true,
        'with_cast': true,
      });
    });

    test('user model preserves Firestore timestamp values', () {
      final createdAt = Timestamp.fromDate(DateTime.utc(2026, 9, 29));
      final user = UserModel.fromFirestore({
        'uid': 'user-id',
        'email': 'user@example.test',
        'name': 'User',
        'phone': '+15551234567',
        'createdAt': createdAt,
      });

      expect(user.phone, '+15551234567');
      expect(user.createdAt, createdAt);
      expect(user.toFirestore()['createdAt'], createdAt);
    });

    test('user model reads legacy phoneNumber Firestore field', () {
      final user = UserModel.fromFirestore({
        'uid': 'user-id',
        'email': 'user@example.test',
        'name': 'User',
        'phoneNumber': '+15551234567',
      });

      expect(user.phone, '+15551234567');
    });
  });

  test('cast and torrent models support direct JSON round trips', () {
    const cast = CastModel(
      name: 'Actor',
      characterName: 'Character',
      imdbCode: '123',
    );
    const torrent = TorrentModel(
      url: 'https://example.test/torrent',
      hash: 'hash',
      quality: '1080p',
      type: 'web',
      seeds: 1,
      peers: 2,
      size: '1 GB',
      sizeBytes: 100,
      bitDepth: '10',
    );

    expect(CastModel.fromJson(cast.toJson()).characterName, 'Character');
    expect(TorrentModel.fromJson(torrent.toJson()).sizeBytes, 100);
  });
}
