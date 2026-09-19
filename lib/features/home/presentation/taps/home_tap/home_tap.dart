import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/core/utils/app_utils.dart';
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
      child: BlocConsumer<HomeCubit, HomeStates>(
        buildWhen: (previous, current) => current is HomeLoaded,
        listener: (context, state) {},
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(child: AppProgressIndicator());
          }
          if (state is HomeFailed) {
            return Center(child: AppText(text: state.message));
          }
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const HomeHeroSection(),
                SizedBox(height: context.h(12)),
                MovieSection(
                  movies: cubit.getRandomMovies(),
                  onSeeMore: () {},
                  title: tr.action,
                ),
                SizedBox(height: context.h(12)),
                MovieSection(
                  movies: cubit.getRandomMovies(),
                  onSeeMore: () {},
                  title: tr.action,
                ),
                SizedBox(height: context.h(12)),
                MovieSection(
                  movies: cubit.getRandomMovies(),
                  onSeeMore: () {},
                  title: tr.action,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
