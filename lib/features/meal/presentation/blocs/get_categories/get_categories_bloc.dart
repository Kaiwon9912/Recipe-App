import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import 'package:repice_app/core/resources/data_state.dart';
import 'package:repice_app/features/meal/domain/entities/category_entity.dart';

import 'package:repice_app/features/meal/domain/usecases/get_category.dart';

part 'get_categories_event.dart';
part 'get_categories_state.dart';

class GetCategoriesBloc extends Bloc<GetCategoriesEvent, GetCategoriesState> {
  final GetCategoriesUseCase getCategories;
  GetCategoriesBloc({required this.getCategories})
    : super(GetCategoriesInitial()) {
    on<GetCategories>(_onLoadCategories);
  }

  Future<void> _onLoadCategories(
    GetCategories event,
    Emitter<GetCategoriesState> emit,
  ) async {
    emit(GetCategoriesLoading());

    final dataState = await getCategories();

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(GetCategoriesSuccess(dataState.data!));
    } else if (dataState is DataFailed) {
      emit(GetCategoriesError(dataState.error!));
    }
  }
}
