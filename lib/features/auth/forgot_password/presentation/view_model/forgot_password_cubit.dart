import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/core/network/api_result.dart';
import 'package:movies/features/auth/forgot_password/domain/use_cases/forgot_password_use_case.dart';

part 'forgot_password_states.dart';

@Injectable()
class ForgotPasswordCubit extends Cubit<ForgotPasswordStates> {
  ForgotPasswordCubit(this._forgotPasswordUseCase)
    : super(const ForgotPasswordInit());

  final ForgotPasswordUseCase _forgotPasswordUseCase;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  static ForgotPasswordCubit of(BuildContext context) =>
      BlocProvider.of<ForgotPasswordCubit>(context);

  bool get isStateLoading => state is ForgotPasswordLoading;

  Future<void> sendPasswordResetEmail({required String email}) async {
    _emit(const ForgotPasswordLoading());

    final result = await _forgotPasswordUseCase.call(email: email);

    switch (result) {
      case ApiSuccess():
        _emit(const ForgotPasswordSuccess());
      case ApiError(:final message):
        _emit(ForgotPasswordError(message: message));
    }
  }

  void _emit(ForgotPasswordStates state) {
    if (!isClosed) {
      emit(state);
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    return super.close();
  }
}
