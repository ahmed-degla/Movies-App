import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/core/di/injection.dart';
import 'package:movies/core/firebase_service/firebase_auth_service.dart';
import 'package:movies/core/models/user_model.dart';
import 'package:movies/core/theme/theme_extension.dart';
import 'package:movies/core/utils/app_utils.dart';
import 'package:movies/features/home/domain/entity/movie_entity.dart';
import 'package:movies/features/profile/presentation/widgets/profile_avatar.dart';
import 'package:movies/features/profile/presentation/widgets/profile_stat_item.dart';
import 'package:movies/generated/assets/assets.gen.dart';
import 'package:movies/widgets/app_button.dart';
import 'package:movies/widgets/app_text.dart';

class ProfileOverview extends StatelessWidget {
  const ProfileOverview({
    required this.watchlistStream,
    required this.historyStream,
    required this.onEditProfile,
    required this.onSignOut,
    super.key,
  });

  final Stream<List<MovieEntity>> watchlistStream;
  final Stream<List<MovieEntity>> historyStream;
  final VoidCallback onEditProfile;
  final VoidCallback onSignOut;

  @override
  Widget build(BuildContext context) {
    final strings = tr;
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ProfileIdentity(),
            SizedBox(width: context.w(16)),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: context.h(16)),
                child: Row(
                  children: [
                    Expanded(
                      child: StreamBuilder<List<MovieEntity>>(
                        stream: watchlistStream,
                        builder: (context, snapshot) => ProfileStatItem(
                          value: '${snapshot.data?.length ?? 0}',
                          label: strings.wishList,
                        ),
                      ),
                    ),
                    Expanded(
                      child: StreamBuilder<List<MovieEntity>>(
                        stream: historyStream,
                        builder: (context, snapshot) => ProfileStatItem(
                          value: '${snapshot.data?.length ?? 0}',
                          label: strings.history,
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
              child: AppButton(
                onTap: onEditProfile,
                child: AppText(
                  text: strings.editProfile,
                  fontSize: context.sp(16),
                ),
              ),
            ),
            SizedBox(width: context.w(12)),
            Expanded(
              child: AppButton(
                onTap: onSignOut,
                backgroundColor: appColors.secondary,
                child: Assets.images.svg.exit.svg(height: context.h(18)),
              ),
            ),
          ],
        ),
        SizedBox(height: context.h(20)),
      ],
    );
  }
}

class ProfileIdentity extends StatefulWidget {
  const ProfileIdentity({super.key});

  @override
  State<ProfileIdentity> createState() => _ProfileIdentityState();
}

class _ProfileIdentityState extends State<ProfileIdentity> {
  late final Stream<UserModel?> _profileStream;

  @override
  void initState() {
    super.initState();
    _profileStream = getIt.get<FirebaseAuthService>().currentUserDataStream();
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<UserModel?>(
    stream: _profileStream,
    builder: (context, snapshot) {
      final authUser = getIt.get<FirebaseAuthService>().currentUser;
      final profile = snapshot.data;
      return Column(
        children: [
          ProfileAvatar(
            imagePath:
                profile?.avatar ??
                profile?.image ??
                Assets.images.png.profileImage1.path,
          ),
          SizedBox(height: context.h(12)),
          AppText(
            text: profile?.name ?? authUser?.displayName ?? '',
            fontSize: context.sp(20),
            fontWeight: .w700,
          ),
        ],
      );
    },
  );
}
