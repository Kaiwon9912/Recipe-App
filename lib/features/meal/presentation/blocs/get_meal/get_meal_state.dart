part of 'get_meal_bloc.dart';

sealed class GetMealState extends Equatable {
  const GetMealState();

  @override
  List<Object> get props => [];
}

final class GetMealInitial extends GetMealState {}

final class GetMealLoading extends GetMealState {}

final class GetMealListSuccess extends GetMealState {
  final List<MealEntity> meals;
  const GetMealListSuccess(this.meals);
  @override
  List<Object> get props => [meals];
}

final class GetMealSuccess extends GetMealState {
  final MealEntity meal;
  const GetMealSuccess(this.meal);
  @override
  List<Object> get props => [meal];
}

final class GetMealError extends GetMealState {
  final DioException? error;
  const GetMealError(this.error);
}
