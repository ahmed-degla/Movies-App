import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/core/network/api_result.dart';
import 'package:movies/features/auth/sign_up/domain/use_cases/sign_up_with_email_use_case.dart';
import 'package:movies/generated/assets/assets.gen.dart';

part 'sign_up_states.dart';

@Injectable()
class SignUpCubit extends Cubit<SignUpStates> {
  SignUpCubit(this._signUpWithEmailUseCase) : super(const SignUpInit());

  final SignUpWithEmailUseCase _signUpWithEmailUseCase;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final List<AssetGenImage> avatars = <AssetGenImage>[
    Assets.images.png.avatar1,
    Assets.images.png.avatar2,
    Assets.images.png.avatar3,
    Assets.images.png.avatar4,
    Assets.images.png.avatar5,
    Assets.images.png.avatar6,
    Assets.images.png.avatar7,
    Assets.images.png.avatar8,
    Assets.images.png.avatar9,
  ];
  bool isEnglish = true;
  int selectedAvatarIndex = 0;

  static SignUpCubit of(BuildContext context) =>
      BlocProvider.of<SignUpCubit>(context);

  bool get isStateLoading => state is SignUpLoading;

  void selectAvatar(int index) {
    selectedAvatarIndex = index;
    emit(state);
  }

  void toggleLanguage(bool value) {
    isEnglish = value;
    emit(state);
  }

  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required String name,
    String? phone,
    String? avatar,
  }) async {
    _emit(const SignUpLoading());

    final result = await _signUpWithEmailUseCase.call(
      email: email,
      password: password,
      name: name,
      phone: phone,
      avatar: avatar,
    );

    switch (result) {
      case ApiSuccess():
        _emit(const SignUpSuccess());
      case ApiError(:final message):
        _emit(SignUpError(message: message));
    }
  }

  void _emit(SignUpStates state) {
    if (!isClosed) {
      emit(state);
    }
  }

  @override
  Future<void> close() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    return super.close();
  }
}
