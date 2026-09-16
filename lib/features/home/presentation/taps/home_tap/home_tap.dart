import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/core/utils/app_utils.dart';
import 'package:movies/features/home/presentation/view_model/home_cubit.dart';
import 'package:movies/features/home/presentation/widgets/home_hero_section.dart';
import 'package:movies/features/home/presentation/widgets/movie_section.dart';

class HomeTap extends StatelessWidget {
  const HomeTap({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = HomeCubit.of(context);
    return SafeArea(
      top: false,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const HomeHeroSection(),
            SizedBox(height: context.h(12)),
            MovieSection(
              title: tr.action,
              imageUrls: const [
                'https://xl.movieposterdb.com/26_07/2026/33764258/xl_the-odyssey-movie-poster_81db230a.jpg?v=2',
                'https://xl.movieposterdb.com/26_07/2026/33764258/xl_the-odyssey-movie-poster_81db230a.jpg?v=2',
                'https://xl.movieposterdb.com/26_07/2026/33764258/xl_the-odyssey-movie-poster_81db230a.jpg?v=2',
              ],
              ratings: const [7.7, 8.1, 9.0],
              onSeeMore: () {},
              onItemTap: (index) {},
            ),
            SizedBox(height: context.h(12)),
            MovieSection(
              title: tr.action,
              imageUrls: const [
                'https://xl.movieposterdb.com/26_07/2026/33764258/xl_the-odyssey-movie-poster_81db230a.jpg?v=2',
                'https://xl.movieposterdb.com/26_07/2026/33764258/xl_the-odyssey-movie-poster_81db230a.jpg?v=2',
                'https://xl.movieposterdb.com/26_07/2026/33764258/xl_the-odyssey-movie-poster_81db230a.jpg?v=2',
              ],
              ratings: const [7.7, 8.1, 9.0],
              onSeeMore: () {},
              onItemTap: (index) {},
            ),
            SizedBox(height: context.h(12)),
            MovieSection(
              title: tr.action,
              imageUrls: const [
                'https://xl.movieposterdb.com/26_07/2026/33764258/xl_the-odyssey-movie-poster_81db230a.jpg?v=2',
                'https://xl.movieposterdb.com/26_07/2026/33764258/xl_the-odyssey-movie-poster_81db230a.jpg?v=2',
                'https://xl.movieposterdb.com/26_07/2026/33764258/xl_the-odyssey-movie-poster_81db230a.jpg?v=2',
              ],
              ratings: const [7.7, 8.1, 9.0],
              onSeeMore: () {},
              onItemTap: (index) {},
            ),
          ],
        ),
      ),
    );
  }
}
