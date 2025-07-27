import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'package:repice_app/features/meal/data/data_source/meal_api_service.dart';

import 'package:repice_app/features/meal/data/repository/MealRepositoryImpl.dart';
import 'package:repice_app/features/meal/domain/repository/meal_repository.dart';
import 'package:repice_app/features/meal/domain/usecases/get_area.dart';
import 'package:repice_app/features/meal/domain/usecases/get_area_meal.dart';
import 'package:repice_app/features/meal/domain/usecases/get_category.dart';
import 'package:repice_app/features/meal/domain/usecases/get_category_meal.dart';
import 'package:repice_app/features/meal/domain/usecases/get_ingredient_meal.dart';
import 'package:repice_app/features/meal/domain/usecases/get_ingredients.dart';
import 'package:repice_app/features/meal/domain/usecases/get_meal_detail.dart';
import 'package:repice_app/features/meal/domain/usecases/search.dart';
import 'package:repice_app/features/meal/presentation/blocs/get_area/get_area_bloc.dart';
import 'package:repice_app/features/meal/presentation/blocs/get_categories/get_categories_bloc.dart';
import 'package:repice_app/features/meal/presentation/blocs/get_ingredients/get_ingredients_bloc.dart';
import 'package:repice_app/features/meal/presentation/blocs/get_meal/get_meal_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // External
  final dio = Dio();

  sl.registerSingleton<Dio>(dio);

  final mealApiService = MealApiService(dio);
  sl.registerSingleton<MealApiService>(mealApiService);

  final mealRepository = MealRepositoryImpl(mealApiService);
  sl.registerSingleton<MealRepository>(mealRepository);

  //get Meal
  final getMealUseCase = GetMealDetailUseCase(mealRepository);
  sl.registerSingleton<GetMealDetailUseCase>(getMealUseCase);
  // Search meal
  final searchMealUseCase = SearchMealsUseCase(mealRepository);
  sl.registerSingleton<SearchMealsUseCase>(searchMealUseCase);
  //gET MEAL BY CATEGOGY
  final getMealsByCategoryUseCase = GetMealsByCategoryUseCase(mealRepository);
  sl.registerSingleton<GetMealsByCategoryUseCase>(getMealsByCategoryUseCase);
  //Get meal by area
  final getMealsByAreaUseCase = GetMealsByAreaUseCase(mealRepository);
  sl.registerSingleton<GetMealsByAreaUseCase>(getMealsByAreaUseCase);
  // Get meal by Igre
  final getMealsByIngredientUseCase = GetMealsByIngredientUseCase(
    mealRepository,
  );
  sl.registerSingleton<GetMealsByIngredientUseCase>(
    getMealsByIngredientUseCase,
  );
  //Get meal bloc
  sl.registerFactory<GetMealBloc>(
    () => GetMealBloc(
      getMeal: getMealUseCase,
      searchMeals: searchMealUseCase,
      getMealCategory: getMealsByCategoryUseCase,
      getMealsByArea: getMealsByAreaUseCase,
      getMealsByIngredient: getMealsByIngredientUseCase,
    ),
  );

  // get categories

  final getCategoriesUseCase = GetCategoriesUseCase(mealRepository);
  sl.registerSingleton<GetCategoriesUseCase>(getCategoriesUseCase);
  // Get Categories bloc
  sl.registerFactory<GetCategoriesBloc>(
    () => GetCategoriesBloc(getCategories: getCategoriesUseCase),
  );

  //get ingredients

  final getIngredientsUSecase = GetIngredientsUseCase(mealRepository);
  sl.registerSingleton<GetIngredientsUseCase>(getIngredientsUSecase);
  // Get Categories bloc
  sl.registerFactory<GetIngredientsBloc>(
    () => GetIngredientsBloc(getIngrediens: getIngredientsUSecase),
  );
  //get areas
  final getAreaUSecase = GetAreaUseCase(mealRepository);
  sl.registerSingleton<GetAreaUseCase>(getAreaUSecase);
  // Get Categories bloc
  sl.registerFactory<GetAreaBloc>(() => GetAreaBloc(getArea: getAreaUSecase));
}
