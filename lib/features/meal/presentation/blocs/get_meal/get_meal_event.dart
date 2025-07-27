part of 'get_meal_bloc.dart';

sealed class GetMealEvent extends Equatable {
  const GetMealEvent();

  @override
  List<Object> get props => [];
}

class GetDetail extends GetMealEvent {
  final String mealId;
  const GetDetail(this.mealId);

  @override
  List<Object> get props => [mealId];
}

class SearchMeals extends GetMealEvent {
  final String query;
  const SearchMeals(this.query);
}

class GetMealsByCategory extends GetMealEvent {
  final String category;
  const GetMealsByCategory(this.category);
}

class GetMealsByArea extends GetMealEvent {
  final String area;

  const GetMealsByArea(this.area);
}

class GetMealsByIngredient extends GetMealEvent {
  final String ingredient;

  const GetMealsByIngredient(this.ingredient);
}
