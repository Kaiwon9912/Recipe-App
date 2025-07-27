import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:repice_app/config/router/app_router.dart';
import 'package:repice_app/config/theme/app_theme.dart';
import 'package:repice_app/features/meal/domain/entities/meal_entity.dart';
import 'package:repice_app/features/meal/presentation/blocs/get_area/get_area_bloc.dart';

import 'package:repice_app/features/meal/presentation/blocs/get_categories/get_categories_bloc.dart';
import 'package:repice_app/features/meal/presentation/blocs/get_ingredients/get_ingredients_bloc.dart';
import 'package:repice_app/features/meal/presentation/blocs/get_meal/get_meal_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repice_app/injection_container.dart';

Future<void> main() async {
  await initializeDependencies();
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(MealEntityAdapter());
  await Hive.openBox<MealEntity>('favorites');
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<GetMealBloc>()),
        BlocProvider(create: (_) => sl<GetCategoriesBloc>()),
        BlocProvider(create: (_) => sl<GetAreaBloc>()),
        BlocProvider(create: (_) => sl<GetIngredientsBloc>()),
      ],

      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  final _router = router;
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: lightMode,
      routerConfig: _router,
    );
  }
}
