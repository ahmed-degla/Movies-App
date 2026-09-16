import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/core/theme/theme_extension.dart';
import 'package:movies/features/home/presentation/view_model/home_cubit.dart';
import 'package:movies/generated/assets/assets.gen.dart';
import 'package:movies/widgets/app/movie_card.dart';
import 'package:movies/widgets/app_network_image.dart';

class HomeHeroSection extends StatelessWidget {
  const HomeHeroSection({super.key});

  @override
  Widget build(BuildContext _) => BlocBuilder<HomeCubit, HomeStates>(
    builder: (context, state) {
      final cubit = HomeCubit.of(context);

      return Stack(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            switchInCurve: Curves.easeIn,
            switchOutCurve: Curves.easeOut,
            child: AppNetWorkImage(
              key: ValueKey(
                cubit
                    .movies[cubit.currentCarouselIndex]
                    .backgroundImageOriginal,
              ),
              imageUrl: cubit
                  .movies[cubit.currentCarouselIndex]
                  .backgroundImageOriginal,

              height: context.h(664),
              color: appColors.background.withValues(alpha: .6),
              colorBlendMode: BlendMode.darken,
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                Assets.images.png.avaliableNow.image(
                  height: context.h(94),
                  width: context.w(268),
                ),
                SizedBox(height: context.h(12)),
                CarouselSlider.builder(
                  options: CarouselOptions(
                    height: context.h(352),
                    enlargeFactor: .2,
                    enlargeCenterPage: true,
                    viewportFraction: .6,
                    onPageChanged: (index, _) {
                      cubit.changeCarouselIndex(index);
                    },
                  ),
                  itemCount: cubit.movies.length,
                  itemBuilder: (context, index, _) => MovieCard(
                    imageUrl: cubit.movies[index].largeCoverImage,
                    rating: cubit.movies[index].rating,
                  ),
                ),
                SizedBox(height: context.h(12)),
                Assets.images.png.watchNow.image(
                  height: context.h(164),
                  width: context.w(354),
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}
