import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/features/home/domain/entity/movie_entity.dart';
import 'package:movies/features/home/presentation/view_model/home_cubit.dart';
import 'package:movies/features/profile/presentation/widgets/movies_grid.dart';
import 'package:movies/widgets/app_text.dart';

class WatchListView extends StatelessWidget {
  const WatchListView({super.key});

  @override
  Widget build(BuildContext context) => StreamBuilder<List<MovieEntity>>(
    stream: context.read<HomeCubit>().watchlistStream(),
    builder: (context, snapshot) {
      if (snapshot.hasError) {
        return Center(child: AppText(text: snapshot.error.toString()));
      }

      return MoviesGrid(
        movies: [
          for (final movie in snapshot.data ?? const [])
            MoviePreview.fromMovie(movie),
        ],
      );
    },
  );
}
