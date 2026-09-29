import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/core/utils/localized_error_message.dart';
import 'package:movies/features/home/presentation/view_model/home_cubit.dart';
import 'package:movies/features/home/presentation/widgets/home_hero_section.dart';
import 'package:movies/features/home/presentation/widgets/movie_section.dart';
import 'package:movies/widgets/app_progress_indicator.dart';
import 'package:movies/widgets/app_text.dart';

class HomeTap extends StatelessWidget {
  const HomeTap({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = HomeCubit.of(context);
    return SafeArea(
      top: false,
      child: BlocBuilder<HomeCubit, HomeStates>(
        buildWhen: (previous, current) =>
            current is HomeLoaded ||
            current is HomeLoading ||
            current is HomeFailed,
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(child: AppProgressIndicator());
          }
          if (state is HomeFailed) {
            return Center(
              child: AppText(
                text: localizedErrorMessage(context, state.message),
              ),
            );
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                const HomeHeroSection(),
                SizedBox(height: context.h(12)),
                for (final genre in cubit.genres) ...[
                  MovieSection(
                    movies: cubit.moviesForGenre(genre),
                    onSeeMore: () => cubit.openExploreForGenre(genre),
                    title: genre,
                  ),
                  SizedBox(height: context.h(12)),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
