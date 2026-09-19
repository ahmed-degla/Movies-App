import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies/core/resources/app_buttons.dart';
import 'package:movies/core/resources/assets_manager.dart';
import 'package:movies/core/resources/strings_manager.dart';
import 'package:movies/core/routing/app_router.gr.dart';
import 'package:movies/features/profile/presentation/widgets/history_view.dart';
import 'package:movies/features/profile/presentation/widgets/profile_avatar.dart';
import 'package:movies/features/profile/presentation/widgets/profile_stat_item.dart';
import 'package:movies/features/profile/presentation/widgets/profile_tab_item.dart';
import 'package:movies/features/profile/presentation/widgets/watch_list_view.dart';
import 'package:movies/widgets/app_text.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _pageController.addListener(_onPageScrolled);
  }

  bool get _isHistory => _currentPage == 1;

  void _onPageScrolled() {
    final page = _pageController.page;
    if (page == null) {
      return;
    }

    final index = page.round();
    if (index != _currentPage) {
      setState(() => _currentPage = index);
    }
  }

  @override
  void dispose() {
    _pageController
      ..removeListener(_onPageScrolled)
      ..dispose();
    super.dispose();
  }

  void _onTabSelected(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Column(
        children: [
          Padding(
            padding: context.edgeInsets(
              horizontal: 16,
              top: _isHistory ? 8 : 24,
            ),
            child: Column(
              children: [
                AnimatedSize(
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeOutCubic,
                  child: _isHistory
                      ? const SizedBox.shrink()
                      : Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    const ProfileAvatar(
                                      imagePath: AssetsManager.profile1,
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
                                    child: const Row(
                                      children: [
                                        Expanded(
                                          child: ProfileStatItem(
                                            value: '12',
                                            label: StringsManager.wishList,
                                          ),
                                        ),
                                        Expanded(
                                          child: ProfileStatItem(
                                            value: '10',
                                            label: StringsManager.history,
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
                                    onTap: () {
                                      unawaited(
                                        context.router.push(
                                          const UpdateProfileRoute(),
                                        ),
                                      );
                                    },
                                    title: StringsManager.editProfile,
                                  ),
                                ),
                                SizedBox(width: context.w(12)),
                                Expanded(
                                  child: AppDangerButton(
                                    onTap: () {},
                                    child: SvgPicture.asset(
                                      AssetsManager.exit,
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
                        iconPath: AssetsManager.watchList,
                        isSelected: _currentPage == 0,
                        onTap: () => _onTabSelected(0),
                      ),
                    ),
                    Expanded(
                      child: ProfileTabItem(
                        label: StringsManager.history,
                        iconPath: AssetsManager.history,
                        isSelected: _currentPage == 1,
                        onTap: () => _onTabSelected(1),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              children: const [
                WatchListView(),
                HistoryView(),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
