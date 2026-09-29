import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/core/resources/app_buttons.dart';
import 'package:movies/core/resources/strings_manager.dart';
import 'package:movies/core/routing/app_router.gr.dart';
import 'package:movies/features/home/presentation/view_model/home_cubit.dart';
import 'package:movies/features/profile/presentation/widgets/history_view.dart';
import 'package:movies/features/profile/presentation/widgets/profile_avatar.dart';
import 'package:movies/features/profile/presentation/widgets/profile_stat_item.dart';
import 'package:movies/features/profile/presentation/widgets/profile_tab_item.dart';
import 'package:movies/features/profile/presentation/widgets/watch_list_view.dart';
import 'package:movies/generated/assets/assets.gen.dart';
import 'package:movies/widgets/app_text.dart';

class ProfileTap extends StatelessWidget {
  const ProfileTap({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<HomeCubit, HomeStates>(
        builder: (context, state) {
          final cubit = HomeCubit.of(context);
          final isHistory = cubit.selectedProfileTabIndex == 1;

          return SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: context.edgeInsets(
                    horizontal: 16,
                    top: isHistory ? 8 : 24,
                  ),
                  child: Column(
                    children: [
                      AnimatedSize(
                        duration: const Duration(milliseconds: 220),
                        curve: Curves.easeOutCubic,
                        child: isHistory
                            ? const SizedBox.shrink()
                            : Column(
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        children: [
                                          ProfileAvatar(
                                            image: Assets.images.png.profile1,
                                          ),
                                          SizedBox(height: context.h(12)),
                                          AppText(
                                            text: 'John Safwat',
                                            fontSize: context.sp(20),
                                            fontWeight: .w700,
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: context.w(16)),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            top: context.h(16),
                                          ),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: StreamBuilder(
                                                  stream: cubit.watchlistStream(),
                                                  builder: (context, snapshot) =>
                                                      ProfileStatItem(
                                                    value:
                                                        '${snapshot.data?.length ?? 0}',
                                                    label: StringsManager.wishList,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: StreamBuilder(
                                                  stream: cubit.historyStream(),
                                                  builder: (context, snapshot) =>
                                                      ProfileStatItem(
                                                    value:
                                                        '${snapshot.data?.length ?? 0}',
                                                    label: StringsManager.history,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: context.h(20)),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: AppPrimaryButton(
                                          onTap: () => context.router.push(
                                            const UpdateProfileRoute(),
                                          ),
                                          title: StringsManager.editProfile,
                                        ),
                                      ),
                                      SizedBox(width: context.w(12)),
                                      Expanded(
                                        child: AppDangerButton(
                                          onTap: () {},
                                          child: Assets.images.svg.exit.svg(
                                            height: context.h(18),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: context.h(20)),
                                ],
                              ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ProfileTabItem(
                              label: StringsManager.watchList,
                              icon: Assets.images.svg.watchList,
                              isSelected: !isHistory,
                              onTap: () => cubit.changeProfileTab(0),
                            ),
                          ),
                          Expanded(
                            child: ProfileTabItem(
                              label: StringsManager.history,
                              icon: Assets.images.svg.history,
                              isSelected: isHistory,
                              onTap: () => cubit.changeProfileTab(1),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: IndexedStack(
                    index: cubit.selectedProfileTabIndex,
                    children: const [WatchListView(), HistoryView()],
                  ),
                ),
              ],
            ),
          );
        },
      );
}
