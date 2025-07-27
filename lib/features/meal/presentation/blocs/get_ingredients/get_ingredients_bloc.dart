import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:repice_app/core/resources/data_state.dart';
import 'package:repice_app/features/meal/domain/entities/ingredient_entity.dart';
import 'package:repice_app/features/meal/domain/usecases/get_ingredients.dart';
import 'package:repice_app/features/meal/presentation/blocs/get_categories/get_categories_bloc.dart';

part 'get_ingredients_event.dart';
part 'get_ingredients_state.dart';

class GetIngredientsBloc
    extends Bloc<GetIngredientsEvent, GetIngredientsState> {
  GetIngredientsUseCase getIngrediens;
  GetIngredientsBloc({required this.getIngrediens})
    : super(GetIngredientsInitial()) {
    on<GetIngredients>(_onLoadIngredients);
  }

  Future<void> _onLoadIngredients(
    GetIngredients event,
    Emitter<GetIngredientsState> emit,
  ) async {
    emit(GetIngredientsLoading());

    final dataState = await getIngrediens();

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(GetIngredientsSuccess(dataState.data!));
    } else if (dataState is DataFailed) {
      emit(GetIngredientsError(dataState.error!));
    }
  }
}
