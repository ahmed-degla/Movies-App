import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/core/theme/theme_extension.dart';
import 'package:movies/core/utils/app_utils.dart';
import 'package:movies/core/utils/localized_error_message.dart';
import 'package:movies/features/home/domain/entity/movie_entity.dart';
import 'package:movies/features/home/domain/entity/movies_page_entity.dart';
import 'package:movies/features/home/presentation/view_model/home_cubit.dart';
import 'package:movies/generated/assets/assets.gen.dart';
import 'package:movies/widgets/app/movie_card.dart';
import 'package:movies/widgets/app_paginated_scroll.dart';
import 'package:movies/widgets/app_progress_indicator.dart';
import 'package:movies/widgets/app_snack_bar.dart';
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
                    child: AppPaginatedScroll<MovieEntity>(
                      items: cubit.searchResults,
                      initialPage: AppPaginatedPage<MovieEntity>(
                        items: cubit.searchResults,
                        totalCount: cubit.searchMovieCount,
                        pageSize: cubit.searchPageSize,
                        pageNumber: cubit.currentSearchPage,
                      ),
                      getPaginatedItems: (page) async =>
                          _toPaginatedPage(await cubit.fetchSearchPage(page)),
                      onRefresh: () async =>
                          _toPaginatedPage(await cubit.fetchSearchPage(1)),
                      onPageChanged: (page, items) =>
                          cubit.updateSearchPage(_toMoviesPage(page), items),
                      onError: (context, error, _) => AppSnackBar.show(
                        message: localizedErrorMessage(
                          context,
                          error.toString(),
                        ),
                        type: AppSnackBarType.error,
                      ),
                      builder: (context, movies) => GridView.builder(
                        padding: EdgeInsets.zero,
                        physics: const AlwaysScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: context.w(20),
                          mainAxisSpacing: context.h(8),
                          childAspectRatio: .65,
                        ),
                        itemCount: movies.length,
                        itemBuilder: (context, index) =>
                            MovieCard(movie: movies[index]),
                      ),
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

  AppPaginatedPage<MovieEntity> _toPaginatedPage(MoviesPageEntity page) =>
      AppPaginatedPage<MovieEntity>(
        items: page.movies,
        totalCount: page.totalCount,
        pageSize: page.limit,
        pageNumber: page.pageNumber,
      );

  MoviesPageEntity _toMoviesPage(AppPaginatedPage<MovieEntity> page) =>
      MoviesPageEntity(
        movies: page.items,
        totalCount: page.totalCount,
        limit: page.pageSize,
        pageNumber: page.pageNumber,
      );
}
