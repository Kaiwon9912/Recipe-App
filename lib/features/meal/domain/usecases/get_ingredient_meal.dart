import 'package:repice_app/core/resources/data_state.dart';
import 'package:repice_app/features/meal/domain/entities/meal_entity.dart';
import 'package:repice_app/features/meal/domain/repository/meal_repository.dart';

class GetMealsByIngredientUseCase {
  final MealRepository _mealRepository;

  GetMealsByIngredientUseCase(this._mealRepository);

  Future<DataState<List<MealEntity>>> call(String ingredient) {
    return _mealRepository.getMealsByIngredient(ingredient);
  }
}
