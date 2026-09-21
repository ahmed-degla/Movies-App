import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

class SplashState {
  const SplashState({this.isReady = false});

  final bool isReady;
}

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(const SplashState()) {
    unawaited(_waitForSplash());
  }

  Future<void> _waitForSplash() async {
    await Future<void>.delayed(const Duration(seconds: 3));
    if (!isClosed) {
      emit(const SplashState(isReady: true));
    }
  }
}
