import 'package:repice_app/core/resources/data_state.dart';
import 'package:repice_app/features/meal/domain/entities/meal_entity.dart';
import 'package:repice_app/features/meal/domain/repository/meal_repository.dart';

class GetMealsByAreaUseCase {
  final MealRepository _mealRepository;

  GetMealsByAreaUseCase(this._mealRepository);

  Future<DataState<List<MealEntity>>> call(String area) {
    return _mealRepository.getMealsByArea(area);
  }
}
