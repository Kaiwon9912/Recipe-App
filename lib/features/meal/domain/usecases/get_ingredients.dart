import 'package:repice_app/core/resources/data_state.dart';
import 'package:repice_app/features/meal/domain/entities/category_entity.dart';
import 'package:repice_app/features/meal/domain/entities/ingredient_entity.dart';
import 'package:repice_app/features/meal/domain/repository/meal_repository.dart';

class GetIngredientsUseCase {
  final MealRepository _mealRepository;

  GetIngredientsUseCase(this._mealRepository);

  Future<DataState<List<IngredientEntity>>> call() {
    return _mealRepository.getIngredients();
  }
}
