import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_in_states.dart';

class SignInCubit extends Cubit<SignInStates> {
  SignInCubit() : super(SignInInit());

  static SignInCubit of(context) => BlocProvider.of(context);

  bool get isStateLoading => state is SignInLoading;

  void _emit(SignInStates state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
