import 'package:repice_app/core/resources/data_state.dart';
import 'package:repice_app/features/meal/domain/entities/area_entity.dart';

import 'package:repice_app/features/meal/domain/repository/meal_repository.dart';

class GetAreaUseCase {
  final MealRepository _mealRepository;

  GetAreaUseCase(this._mealRepository);

  Future<DataState<List<AreaEntity>>> call() {
    return _mealRepository.getAreas();
  }
}
