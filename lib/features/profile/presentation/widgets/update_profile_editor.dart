import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/core/utils/app_utils.dart';
import 'package:movies/features/profile/presentation/widgets/profile_avatar.dart';
import 'package:movies/features/profile/presentation/widgets/reset_password_action.dart';
import 'package:movies/features/profile/presentation/widgets/update_profile_field_icon.dart';
import 'package:movies/generated/assets/assets.gen.dart';
import 'package:movies/widgets/app_text_field.dart';

class UpdateProfileEditor extends StatelessWidget {
  const UpdateProfileEditor({
    required this.nameController,
    required this.phoneController,
    required this.selectedAvatar,
    required this.onPickAvatar,
    required this.isEnabled,
    required this.validateName,
    required this.validatePhone,
    super.key,
  });

  final TextEditingController nameController;
  final TextEditingController phoneController;
  final String selectedAvatar;
  final VoidCallback? onPickAvatar;
  final bool isEnabled;
  final FormFieldValidator<String> validateName;
  final FormFieldValidator<String> validatePhone;

  @override
  Widget build(BuildContext context) {
    final strings = tr;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: context.h(16)),
        Center(
          child: ProfileAvatar(
            imagePath: selectedAvatar,
            size: context.w(150),
            onTap: isEnabled ? onPickAvatar : null,
          ),
        ),
        SizedBox(height: context.h(28)),
        AppTextField(
          controller: nameController,
          hintText: strings.name,
          validator: validateName,
          showBorder: false,
          borderRadius: 16,
          textStyle: TextStyle(fontSize: context.sp(16)),
          contentPadding: context.edgeInsets(horizontal: 12, vertical: 18),
          prefixIconConstraints: BoxConstraints(
            minWidth: context.w(56),
            maxWidth: context.w(56),
          ),
          prefixIcon: UpdateProfileFieldIcon(
            assetPath: Assets.images.svg.user.path,
          ),
        ),
        SizedBox(height: context.h(16)),
        AppTextField(
          controller: phoneController,
          hintText: strings.phoneNumber,
          validator: validatePhone,
          showBorder: false,
          borderRadius: 16,
          keyboardType: TextInputType.phone,
          textStyle: TextStyle(fontSize: context.sp(16)),
          contentPadding: context.edgeInsets(horizontal: 12, vertical: 18),
          prefixIconConstraints: BoxConstraints(
            minWidth: context.w(56),
            maxWidth: context.w(56),
          ),
          prefixIcon: UpdateProfileFieldIcon(
            assetPath: Assets.images.svg.phone.path,
          ),
        ),
        SizedBox(height: context.h(16)),
        ResetPasswordAction(isEnabled: isEnabled),
      ],
    );
  }
}
