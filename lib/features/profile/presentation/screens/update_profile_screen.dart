import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/core/di/injection.dart';
import 'package:movies/core/firebase_service/firebase_auth_service.dart';
import 'package:movies/core/routing/app_router.gr.dart';
import 'package:movies/core/theme/theme_extension.dart';
import 'package:movies/core/utils/app_utils.dart';
import 'package:movies/core/utils/localized_error_message.dart';
import 'package:movies/features/profile/presentation/widgets/pick_avatar_bottom_sheet.dart';
import 'package:movies/features/profile/presentation/widgets/profile_avatar.dart';
import 'package:movies/features/profile/presentation/widgets/update_profile_actions.dart';
import 'package:movies/features/profile/presentation/widgets/update_profile_editor.dart';
import 'package:movies/generated/assets/assets.gen.dart';
import 'package:movies/widgets/app_bar.dart';
import 'package:movies/widgets/app_snack_bar.dart';
import 'package:movies/widgets/app_text.dart';

@RoutePage()
class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  String _selectedAvatar = Assets.images.png.profileImage1.path;
  bool _isLoadingProfile = true;
  bool _isSaving = false;
  bool _isDeleting = false;

  @override
  void initState() {
    super.initState();
    final user = getIt.get<FirebaseAuthService>().currentUser;
    _nameController = TextEditingController(text: user?.displayName ?? '');
    _phoneController = TextEditingController();
    unawaited(_loadProfile());
  }

  Future<void> _loadProfile() async {
    try {
      final profile = await getIt
          .get<FirebaseAuthService>()
          .getCurrentUserData();
      if (!mounted) return;

      setState(() {
        if (profile != null) {
          final user = getIt.get<FirebaseAuthService>().currentUser;
          _nameController.text = profile.name.isNotEmpty
              ? profile.name
              : user?.displayName ?? '';
          _phoneController.text = profile.phone?.isNotEmpty == true
              ? profile.phone!
              : user?.phoneNumber ?? '';
          final profileAvatar = profile.avatar ?? profile.image;
          if (profileAvatar != null) {
            final normalizedAvatar = ProfileAvatar.resolveImagePath(
              profileAvatar,
            );
            if (PickAvatarBottomSheet.avatars.contains(normalizedAvatar)) {
              _selectedAvatar = normalizedAvatar;
            }
          }
        }
        _isLoadingProfile = false;
      });
    } on Object catch (error) {
      if (!mounted) return;
      setState(() => _isLoadingProfile = false);
      _showMessage(
        localizedErrorMessage(context, error.toString()),
        type: AppSnackBarType.error,
      );
    }
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

  String? _validateName(String? value) {
    final name = value?.trim() ?? '';
    if (name.isEmpty) return tr.pleaseEnterName;
    if (name.length < 2) return tr.pleaseEnterName;
    return null;
  }

  String? _validatePhone(String? value) {
    final phone = value?.trim() ?? '';
    if (!RegExp(r'^\+?[0-9]{8,15}$').hasMatch(phone)) {
      return tr.pleaseEnterPhone;
    }
    return null;
  }

  Future<void> _saveProfile() async {
    if (_isLoadingProfile || !_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);
    try {
      await getIt.get<FirebaseAuthService>().updateProfile(
        name: _nameController.text,
        phone: _phoneController.text,
        avatar: _selectedAvatar,
      );
      if (!mounted) return;
      _showMessage(
        tr.profileUpdatedSuccessfully,
        type: AppSnackBarType.success,
      );
      await context.router.maybePop();
    } on Object catch (error) {
      if (mounted) {
        _showMessage(
          localizedErrorMessage(context, error.toString()),
          type: AppSnackBarType.error,
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  Future<void> _deleteAccount() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(tr.deleteAccountConfirmTitle),
        content: Text(tr.deleteAccountConfirmMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(tr.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(tr.confirm),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;

    final authService = getIt.get<FirebaseAuthService>();
    final user = authService.currentUser;
    final requiresPassword = user?.providerData.any(
      (provider) => provider.providerId == EmailAuthProvider.PROVIDER_ID,
    );
    String? password;
    if (requiresPassword == true) {
      password = await _promptForPassword();
      if (password == null || password.isEmpty || !mounted) return;
    }

    setState(() => _isDeleting = true);
    try {
      await authService.reauthenticateCurrentUser(password: password);
      await authService.deleteAccount();
      if (!mounted) return;
      await context.router.replaceAll([const SignInRoute()]);
    } on FirebaseAuthException catch (error) {
      if (mounted) {
        _showMessage(
          localizedErrorMessage(context, error.code),
          type: AppSnackBarType.error,
        );
      }
    } on Object catch (error) {
      if (mounted) {
        _showMessage(
          localizedErrorMessage(context, error.toString()),
          type: AppSnackBarType.error,
        );
      }
    } finally {
      if (mounted) setState(() => _isDeleting = false);
    }
  }

  Future<String?> _promptForPassword() async {
    final passwordController = TextEditingController();
    try {
      return await showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(tr.deleteAccountConfirmTitle),
          content: TextField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(hintText: tr.password),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(tr.cancel),
            ),
            TextButton(
              onPressed: () =>
                  Navigator.of(context).pop(passwordController.text),
              child: Text(tr.confirm),
            ),
          ],
        ),
      );
    } finally {
      passwordController.dispose();
    }
  }

  void _showMessage(
    String message, {
    AppSnackBarType type = AppSnackBarType.info,
  }) {
    AppSnackBar.show(message: message, type: type);
  }

  @override
  Widget build(BuildContext context) {
    final strings = tr;

    return Scaffold(
      appBar: AppAppBar(
        titleWidget: AppText(
          text: strings.editProfile,
          color: appColors.primary,
          fontSize: context.sp(16),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: context.edgeInsets(horizontal: 16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        UpdateProfileEditor(
                          nameController: _nameController,
                          phoneController: _phoneController,
                          selectedAvatar: _selectedAvatar,
                          onPickAvatar: () => unawaited(_pickAvatar()),
                          isEnabled:
                              !_isLoadingProfile && !_isSaving && !_isDeleting,
                          validateName: _validateName,
                          validatePhone: _validatePhone,
                        ),
                      ],
                    ),
                  ),
                ),
                UpdateProfileActions(
                  isEnabled: !_isLoadingProfile && !_isSaving && !_isDeleting,
                  isDeleting: _isDeleting,
                  isSaving: _isSaving,
                  onDelete: _deleteAccount,
                  onSave: _saveProfile,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
