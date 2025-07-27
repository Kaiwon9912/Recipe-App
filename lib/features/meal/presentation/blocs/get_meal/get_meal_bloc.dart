import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import 'package:repice_app/core/resources/data_state.dart';
import 'package:repice_app/features/meal/domain/entities/meal_entity.dart';
import 'package:repice_app/features/meal/domain/usecases/get_area_meal.dart';
import 'package:repice_app/features/meal/domain/usecases/get_category_meal.dart';
import 'package:repice_app/features/meal/domain/usecases/get_ingredient_meal.dart';
import 'package:repice_app/features/meal/domain/usecases/get_meal_detail.dart';
import 'package:repice_app/features/meal/domain/usecases/search.dart';

part 'get_meal_event.dart';
part 'get_meal_state.dart';

class GetMealBloc extends Bloc<GetMealEvent, GetMealState> {
  final SearchMealsUseCase searchMeals;
  final GetMealDetailUseCase getMeal;
  final GetMealsByCategoryUseCase getMealCategory;
  final GetMealsByAreaUseCase getMealsByArea;
  final GetMealsByIngredientUseCase getMealsByIngredient;
  GetMealBloc({
    required this.searchMeals,
    required this.getMeal,
    required this.getMealCategory,
    required this.getMealsByArea,
    required this.getMealsByIngredient,
  }) : super(GetMealInitial()) {
    on<GetDetail>(_onGetMealDetail);
    on<SearchMeals>(_onSearchMeals);
    on<GetMealsByCategory>(_onGetMealByCategory);
    on<GetMealsByArea>(_onGetMealByArea);
    on<GetMealsByIngredient>(_onGetMealByIngredient);
  }

  Future<void> _onGetMealDetail(
    GetDetail event,
    Emitter<GetMealState> emit,
  ) async {
    final dataState = await getMeal(event.mealId);
    if (dataState is DataSuccess && dataState.data != null) {
      emit(GetMealSuccess(dataState.data!));
    }
    if (dataState is DataFailed) {
      emit(GetMealError(dataState.error!));
    }
  }

  Future<void> _onSearchMeals(
    SearchMeals event,
    Emitter<GetMealState> emit,
  ) async {
    final dataState = await searchMeals(event.query);
    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(GetMealListSuccess(dataState.data!));
    }
    if (dataState is DataFailed) {
      emit(GetMealError(dataState.error!));
    }
  }

  Future<void> _onGetMealByCategory(
    GetMealsByCategory event,
    Emitter<GetMealState> emit,
  ) async {
    final dataState = await searchMeals(event.category);
    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(GetMealListSuccess(dataState.data!));
    }
    if (dataState is DataFailed) {
      emit(GetMealError(dataState.error!));
    }
  }

  Future<void> _onGetMealByArea(
    GetMealsByArea event,
    Emitter<GetMealState> emit,
  ) async {
    emit(GetMealLoading());
    final result = await getMealsByArea(event.area);

    if (result is DataSuccess && result.data != null) {
      emit(GetMealListSuccess(result.data!));
    } else if (result is DataFailed) {
      emit(GetMealError(result.error!));
    }
  }

  Future<void> _onGetMealByIngredient(
    GetMealsByIngredient event,
    Emitter<GetMealState> emit,
  ) async {
    emit(GetMealLoading());
    final result = await getMealsByIngredient(event.ingredient);

    if (result is DataSuccess && result.data != null) {
      emit(GetMealListSuccess(result.data!));
    } else if (result is DataFailed) {
      emit(GetMealError(result.error!));
    }
  }
}
