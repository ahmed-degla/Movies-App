import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/features/home/presentation/view_model/home_cubit.dart';
import 'package:movies/features/home/presentation/taps/home_tap/home_tap.dart';
import 'package:movies/features/home/presentation/widgets/nav_bar.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) => HomeCubit(),
    child: Scaffold(
      body: BlocBuilder<HomeCubit, HomeStates>(
        buildWhen: (p, c) => c is HomeTapIndexUpdated,
        builder: (context, state) => [
          const HomeTap(),
          const SizedBox(height: 100),
          const SizedBox(height: 100),
          const SizedBox(height: 100),
        ][state.selectedTapIndex],
      ),
      bottomNavigationBar: const BottomNavBar(),
    ),
  );
}
