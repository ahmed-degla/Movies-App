import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/core/resources/app_buttons.dart';
import 'package:movies/core/resources/assets_manager.dart';
import 'package:movies/core/resources/strings_manager.dart';
import 'package:movies/core/theme/theme_extension.dart';
import 'package:movies/features/profile/presentation/widgets/pick_avatar_bottom_sheet.dart';
import 'package:movies/features/profile/presentation/widgets/profile_avatar.dart';
import 'package:movies/features/profile/presentation/widgets/update_profile_field_icon.dart';
import 'package:movies/widgets/app_bar.dart';
import 'package:movies/widgets/app_text.dart';
import 'package:movies/widgets/app_text_field.dart';

@RoutePage()
class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  String _selectedAvatar = AssetsManager.profile1;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: 'John Safwat');
    _phoneController = TextEditingController(text: '01200000000');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _pickAvatar() async {
    final avatar = await PickAvatarBottomSheet.show(
      selectedAvatar: _selectedAvatar,
    );

    if (avatar == null || !mounted) {
      return;
    }

    setState(() => _selectedAvatar = avatar);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppAppBar(
      titleWidget: AppText(
        text: StringsManager.pickAvatar,
        color: appColors.primary,
        fontSize: context.sp(16),
      ),
    ),
    body: SafeArea(
      child: Padding(
        padding: context.edgeInsets(horizontal: 16),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: context.h(16)),
                    Center(
                      child: ProfileAvatar(
                        imagePath: _selectedAvatar,
                        size: context.w(150),
                        onTap: () {
                          unawaited(_pickAvatar());
                        },
                      ),
                    ),
                    SizedBox(height: context.h(28)),
                    AppTextField(
                      controller: _nameController,
                      showBorder: false,
                      borderRadius: 16,
                      textStyle: TextStyle(fontSize: context.sp(16)),
                      contentPadding: context.edgeInsets(
                        horizontal: 12,
                        vertical: 18,
                      ),
                      prefixIconConstraints: BoxConstraints(
                        minWidth: context.w(56),
                        maxWidth: context.w(56),
                      ),
                      prefixIcon: const UpdateProfileFieldIcon(
                        assetPath: AssetsManager.user,
                      ),
                    ),
                    SizedBox(height: context.h(16)),
                    AppTextField(
                      controller: _phoneController,
                      showBorder: false,
                      borderRadius: 16,
                      keyboardType: TextInputType.phone,
                      textStyle: TextStyle(fontSize: context.sp(16)),
                      contentPadding: context.edgeInsets(
                        horizontal: 12,
                        vertical: 18,
                      ),
                      prefixIconConstraints: BoxConstraints(
                        minWidth: context.w(56),
                        maxWidth: context.w(56),
                      ),
                      prefixIcon: const UpdateProfileFieldIcon(
                        assetPath: AssetsManager.phone,
                      ),
                    ),
                    SizedBox(height: context.h(16)),
                    AppText(
                      text: StringsManager.resetPassword,
                      fontSize: context.sp(20),
                    ),
                  ],
                ),
              ),
            ),
            AppDangerButton(
              onTap: () {},
              title: StringsManager.deleteAccount,
            ),
            SizedBox(height: context.h(16)),
            AppPrimaryButton(
              onTap: () {},
              title: StringsManager.updateData,
            ),
            SizedBox(height: context.h(24)),
          ],
        ),
      ),
    ),
  );
}
