part of 'get_ingredients_bloc.dart';

sealed class GetIngredientsState extends Equatable {
  const GetIngredientsState();

  @override
  List<Object> get props => [];
}

final class GetIngredientsInitial extends GetIngredientsState {}

final class GetIngredientsLoading extends GetIngredientsState {}

final class GetIngredientsSuccess extends GetIngredientsState {
  final List<IngredientEntity> ingredients;
  const GetIngredientsSuccess(this.ingredients);
  @override
  List<Object> get props => [ingredients];
}

final class GetIngredientsError extends GetIngredientsState {
  final DioException? error;
  const GetIngredientsError(this.error);
}
