import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/di/injection.dart';
import 'package:movies/features/update_profile/presentation/view_model/update_profile_cubit.dart';
import 'package:movies/features/update_profile/presentation/widgets/update_profile_view.dart';

@RoutePage()
class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) {
      final cubit = getIt<UpdateProfileCubit>();
      unawaited(cubit.loadProfile());
      return cubit;
    },
    child: const UpdateProfileView(),
  );
}
