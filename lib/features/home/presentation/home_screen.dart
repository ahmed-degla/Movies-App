import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/di/injection.dart';
import 'package:movies/core/firebase_service/firebase_auth_service.dart';
import 'package:movies/features/home/presentation/taps/explore_tap/explore_tap.dart';
import 'package:movies/features/home/presentation/taps/home_tap/home_tap.dart';
import 'package:movies/features/home/presentation/taps/search_tap/search_tap.dart';
import 'package:movies/features/home/presentation/view_model/home_cubit.dart';
import 'package:movies/features/home/presentation/widgets/nav_bar.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) => getIt.get<HomeCubit>(),
    child: Scaffold(
      body: BlocBuilder<HomeCubit, HomeStates>(
        buildWhen: (p, c) => c is HomeTapIndexUpdated,
        builder: (context, state) => [
          const HomeTap(),
          const SearchTap(),
          const ExploreTap(),
          const SizedBox(height: 100),
        ][state.selectedTapIndex],
      ),
      bottomNavigationBar: const BottomNavBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: getIt.get<FirebaseAuthService>().signOut,
        child: const Icon(Icons.add),
      ),

    ),
  );
}
