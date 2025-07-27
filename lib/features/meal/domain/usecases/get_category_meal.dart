import 'package:repice_app/core/resources/data_state.dart';
import 'package:repice_app/features/meal/domain/entities/meal_entity.dart';
import 'package:repice_app/features/meal/domain/repository/meal_repository.dart';

class GetMealsByCategoryUseCase {
  final MealRepository _mealRepository;

  GetMealsByCategoryUseCase(this._mealRepository);

  Future<DataState<List<MealEntity>>> call(String category) {
    return _mealRepository.getMealsByCategory(category);
  }
}
