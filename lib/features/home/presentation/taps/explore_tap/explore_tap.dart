import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/core/theme/theme_extension.dart';
import 'package:movies/features/home/presentation/view_model/home_cubit.dart';
import 'package:movies/generated/assets/assets.gen.dart';
import 'package:movies/widgets/app/movie_card.dart';
import 'package:movies/widgets/app_progress_indicator.dart';
import 'package:movies/widgets/app_text.dart';

class ExploreTap extends StatelessWidget {
  const ExploreTap({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<HomeCubit, HomeStates>(
    builder: (context, state) {
      final cubit = HomeCubit.of(context);

      return SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: context.h(48),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: context.w(16)),
                itemCount: cubit.genres.length,
                separatorBuilder: (_, _) => SizedBox(width: context.w(8)),
                itemBuilder: (context, index) {
                  final genre = cubit.genres[index];
                  final isSelected = cubit.selectedGenre == genre;

                  return ChoiceChip(
                    backgroundColor: appColors.background,
                    selectedColor: appColors.primary,
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(context.r(24)),
                      side: BorderSide(
                        color: appColors.primary,
                        width: context.w(2),
                      ),
                    ),

                    label: AppText(
                      text: genre,
                      fontSize: context.sp(20),
                      fontWeight: FontWeight.w700,
                      color: isSelected
                          ? appColors.background
                          : appColors.primary,
                    ),
                    selected: isSelected,
                    onSelected: (_) {
                      unawaited(cubit.onGenreSelected(genre));
                    },
                  );
                },
              ),
            ),

            SizedBox(height: context.h(24)),

            Builder(
              builder: (context) {
                if (state is HomeLoading) {
                  return const Expanded(
                    child: Center(child: AppProgressIndicator()),
                  );
                }
                if (cubit.filteredMovies.isEmpty) {
                  return Expanded(
                    child: Center(
                      child: Assets.images.png.empty.image(
                        height: context.h(200),
                        width: context.w(200),
                      ),
                    ),
                  );
                }
                return Expanded(
                  child: GridView.builder(
                    padding: EdgeInsets.symmetric(horizontal: context.w(16)),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: context.w(20),
                      mainAxisSpacing: context.h(8),
                      childAspectRatio: .65,
                    ),
                    itemCount: cubit.filteredMovies.length,
                    itemBuilder: (context, index) {
                      final movie = cubit.filteredMovies[index];

                      return MovieCard(movie: movie);
                    },
                  ),
                );
              },
            ),
          ],
        ),
      );
    },
  );
}
