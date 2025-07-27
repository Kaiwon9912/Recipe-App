import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:repice_app/features/home/presentation/screen/home_screen.dart';
import 'package:repice_app/features/home/presentation/screen/intro_screen.dart';
import 'package:repice_app/features/meal/domain/entities/meal_entity.dart';
import 'package:repice_app/features/meal/presentation/blocs/get_meal/get_meal_bloc.dart';
import 'package:repice_app/features/meal/presentation/screens/meal_detail_screen.dart';
import 'package:repice_app/features/meal/presentation/screens/saved_screen.dart';
import 'package:repice_app/features/meal/presentation/screens/search_screen.dart';
import 'package:repice_app/features/profile/presentation/screen/profile_screen.dart';
import 'package:repice_app/main_scaffold.dart';

final router = GoRouter(
  initialLocation: '/intro',
  routes: [
    GoRoute(path: '/intro', builder: (context, state) => const IntroScreen()),
    ShellRoute(
      builder: (context, state, child) {
        return MainScaffold(child: child);
      },
      routes: [
        GoRoute(path: '/', builder: (context, state) => const HomeScreen()),

        GoRoute(
          path: '/search',
          builder: (context, state) {
            context.read<GetMealBloc>();
            return const SearchScreen();
          },
        ),
        GoRoute(
          path: '/detail',
          builder: (context, state) {
            final meal = state.extra as MealEntity;
            return MealDetailScreen(meal: meal);
          },
        ),
        GoRoute(
          path: '/saved',
          builder: (context, state) => const SavedScreen(),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfileScreen(),
        ),
      ],
    ),
  ],
);
