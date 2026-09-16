import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/core/theme/theme_extension.dart';
import 'package:movies/features/home/presentation/view_model/home_cubit.dart';
import 'package:movies/generated/assets/assets.gen.dart';
class HomeHeroSection extends StatelessWidget {
  const HomeHeroSection({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final cubit = HomeCubit.of(context);
    return Stack(
      children: [
        Container(
          height: context.h(664),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                Assets.images.png.movieBg.path,
              ),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                appColors.background.withValues(alpha: .6),
                BlendMode.darken,
              ),
            ),
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
                itemCount: 10,
                itemBuilder: (
                    BuildContext context,
                    int index,
                    int realIndex,
                    ) {
                  return Assets.images.png.movieCover.image();
                },
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
  }
}