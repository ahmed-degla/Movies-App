import 'package:flutter/material.dart';
import 'package:movies/features/profile/presentation/widgets/movies_grid.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  static const _movies = [
    MoviePreview(
      posterUrl: 'https://picsum.photos/seed/blackwidow/300/450',
      rating: 7.7,
    ),
    MoviePreview(
      posterUrl: 'https://picsum.photos/seed/hobbs/300/450',
      rating: 7.7,
    ),
    MoviePreview(
      posterUrl: 'https://picsum.photos/seed/1917/300/450',
      rating: 7.7,
    ),
    MoviePreview(
      posterUrl: 'https://picsum.photos/seed/avengers/300/450',
      rating: 7.7,
    ),
    MoviePreview(
      posterUrl: 'https://picsum.photos/seed/endgame/300/450',
      rating: 7.7,
    ),
    MoviePreview(
      posterUrl: 'https://picsum.photos/seed/widow2/300/450',
      rating: 7.7,
    ),
    MoviePreview(
      posterUrl: 'https://picsum.photos/seed/panther/300/450',
      rating: 7.7,
    ),
    MoviePreview(
      posterUrl: 'https://picsum.photos/seed/doctor/300/450',
      rating: 7.7,
    ),
    MoviePreview(
      posterUrl: 'https://picsum.photos/seed/who/300/450',
      rating: 7.7,
    ),
    MoviePreview(
      posterUrl: 'https://picsum.photos/seed/guardians/300/450',
      rating: 7.7,
    ),
    MoviePreview(
      posterUrl: 'https://picsum.photos/seed/maleficent/300/450',
      rating: 7.7,
    ),
    MoviePreview(
      posterUrl: 'https://picsum.photos/seed/doctorwho/300/450',
      rating: 7.7,
    ),
  ];

  @override
  Widget build(BuildContext context) => const MoviesGrid(movies: _movies);
}
