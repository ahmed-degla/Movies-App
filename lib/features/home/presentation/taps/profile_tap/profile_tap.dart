import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/core/di/injection.dart';
import 'package:movies/core/firebase_service/firebase_auth_service.dart';
import 'package:movies/core/routing/app_router.gr.dart';
import 'package:movies/core/theme/theme_extension.dart';
import 'package:movies/core/utils/localized_error_message.dart';
import 'package:movies/features/home/presentation/taps/profile_tap/widgets/history_view.dart';
import 'package:movies/features/home/presentation/taps/profile_tap/widgets/watch_list_view.dart';
import 'package:movies/features/home/presentation/view_model/home_cubit.dart';
import 'package:movies/features/home/presentation/widgets/profile_overview.dart';
import 'package:movies/features/home/presentation/widgets/profile_tabs.dart';
import 'package:movies/widgets/app_snack_bar.dart';

class ProfileTap extends StatelessWidget {
  const ProfileTap({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<HomeCubit, HomeStates>(
    builder: (context, state) {
      final cubit = HomeCubit.of(context);
      final isHistory = cubit.selectedProfileTabIndex == 1;
      return Ink(
        color: appColors.fill,
        child: SafeArea(
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
                          : ProfileOverview(
                              watchlistStream: cubit.watchlistStream(),
                              historyStream: cubit.historyStream(),
                              onEditProfile: () => context.router.push(
                                const UpdateProfileRoute(),
                              ),
                              onSignOut: () async {
                                try {
                                  await getIt
                                      .get<FirebaseAuthService>()
                                      .signOut();
                                  if (context.mounted) {
                                    await context.router.replaceAll([
                                      const SignInRoute(),
                                    ]);
                                  }
                                } on Object catch (error) {
                                  if (context.mounted) {
                                    AppSnackBar.show(
                                      message: localizedErrorMessage(
                                        context,
                                        error.toString(),
                                      ),
                                      type: AppSnackBarType.error,
                                    );
                                  }
                                }
                              },
                            ),
                    ),
                    ProfileTabs(
                      isHistorySelected: isHistory,
                      onWatchlistSelected: () => cubit.changeProfileTab(0),
                      onHistorySelected: () => cubit.changeProfileTab(1),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Ink(
                  color: appColors.background,

                  child: IndexedStack(
                    index: cubit.selectedProfileTabIndex,
                    children: const [WatchListView(), HistoryView()],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
