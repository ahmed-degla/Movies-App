import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/di/injection.dart';

import 'core/general_cubit/general_cubit.dart';
import 'my_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();

  runApp(
    BlocProvider.value(value: GeneralCubit.instance, child: const MyApp()),
  );
}
