import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/core/theme/theme_extension.dart';
import 'package:movies/core/utils/app_utils.dart';
import 'package:movies/features/home/presentation/view_model/home_cubit.dart';
import 'package:movies/generated/assets/assets.gen.dart';
import 'package:movies/widgets/app/movie_card.dart';
import 'package:movies/widgets/app_progress_indicator.dart';
import 'package:movies/widgets/app_text_field.dart';

class SearchTap extends StatelessWidget {
  const SearchTap({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<HomeCubit, HomeStates>(
    builder: (context, state) {
      final cubit = HomeCubit.of(context);

      return SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.w(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ValueListenableBuilder<TextEditingValue>(
                valueListenable: cubit.searchController,
                builder: (context, value, child) => AppTextField(
                  controller: cubit.searchController,
                  onChanged: cubit.onSearchChanged,
                  hintText: tr.search,
                  suffixIcon: value.text.isNotEmpty
                      ? InkWell(
                          onTap: cubit.resetFilters,
                          child: Icon(Icons.clear, color: appColors.primary),
                        )
                      : null,
                ),
              ),
              SizedBox(height: context.h(20)),

              Builder(
                builder: (context) {
                  if (state is HomeLoading) {
                    return const Expanded(
                      child: Center(child: AppProgressIndicator()),
                    );
                  }
                  if (cubit.searchResults.isEmpty) {
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
                      padding: EdgeInsets.zero,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: context.w(20),
                        mainAxisSpacing: context.h(8),
                        childAspectRatio: .65,
                      ),
                      itemCount: cubit.searchResults.length,
                      itemBuilder: (context, index) {
                        final movie = cubit.searchResults[index];

                        return MovieCard(movie: movie);
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}
