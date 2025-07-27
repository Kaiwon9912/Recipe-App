import 'package:repice_app/core/resources/data_state.dart';
import 'package:repice_app/features/meal/domain/entities/meal_entity.dart';

import 'package:repice_app/features/meal/domain/repository/meal_repository.dart';

class GetMealDetailUseCase {
  final MealRepository _mealRepository;

  GetMealDetailUseCase(this._mealRepository);

  Future<DataState<MealEntity>> call(String id) {
    return _mealRepository.getMeal(id);
  }
}
