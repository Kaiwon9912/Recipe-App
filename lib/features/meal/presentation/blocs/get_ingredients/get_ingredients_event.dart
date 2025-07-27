part of 'get_ingredients_bloc.dart';

sealed class GetIngredientsEvent extends Equatable {
  const GetIngredientsEvent();

  @override
  List<Object> get props => [];
}

class GetIngredients extends GetIngredientsEvent {}
