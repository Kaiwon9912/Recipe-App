import 'package:repice_app/core/resources/data_state.dart';
import 'package:repice_app/features/meal/data/model/mealModel.dart';
import 'package:repice_app/features/meal/domain/entities/area_entity.dart';
import 'package:repice_app/features/meal/domain/entities/category_entity.dart';
import 'package:repice_app/features/meal/domain/entities/ingredient_entity.dart';
import 'package:repice_app/features/meal/domain/entities/meal_entity.dart';
import 'package:repice_app/features/meal/presentation/blocs/get_meal/get_meal_bloc.dart';

abstract class MealRepository {
  Future<DataState<MealEntity>> getMeal(String id);
  Future<DataState<List<MealEntity>>> searchMeals(String search);
  Future<DataState<List<CategoryEntity>>> getCategories();
  Future<DataState<List<IngredientEntity>>> getIngredients();
  Future<DataState<List<AreaEntity>>> getAreas();
  Future<DataState<List<MealEntity>>> getMealsByCategory(String category);
  Future<DataState<List<MealEntity>>> getMealsByArea(String category);
  Future<DataState<List<MealEntity>>> getMealsByIngredient(String category);
}
