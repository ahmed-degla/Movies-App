import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/di/injection.dart';
import 'package:movies/core/firebase_service/firebase_auth_service.dart';
import 'package:movies/core/general_cubit/general_cubit.dart';
import 'package:movies/firebase_options.dart';
import 'package:movies/my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  configureDependencies();
  await getIt.get<FirebaseAuthService>().initializeGoogleSignIn();
  final generalCubit = getIt.get<GeneralCubit>();
  await generalCubit.init();

  runApp(BlocProvider.value(value: generalCubit, child: const MyApp()));
}
