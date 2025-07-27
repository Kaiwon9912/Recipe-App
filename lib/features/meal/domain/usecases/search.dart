import 'package:repice_app/core/resources/data_state.dart';
import 'package:repice_app/features/meal/domain/entities/meal_entity.dart';
import 'package:repice_app/features/meal/domain/repository/meal_repository.dart';

class SearchMealsUseCase {
  final MealRepository _mealRepository;

  SearchMealsUseCase(this._mealRepository);

  Future<DataState<List<MealEntity>>> call(String query) {
    return _mealRepository.searchMeals(query);
  }
}
