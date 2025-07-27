import 'package:repice_app/core/resources/data_state.dart';
import 'package:repice_app/features/meal/domain/entities/category_entity.dart';
import 'package:repice_app/features/meal/domain/repository/meal_repository.dart';

class GetCategoriesUseCase {
  final MealRepository _mealRepository;

  GetCategoriesUseCase(this._mealRepository);

  Future<DataState<List<CategoryEntity>>> call() {
    return _mealRepository.getCategories();
  }
}
