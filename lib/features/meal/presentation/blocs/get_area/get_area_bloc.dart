import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:repice_app/core/resources/data_state.dart';
import 'package:repice_app/features/meal/domain/entities/area_entity.dart';
import 'package:repice_app/features/meal/domain/usecases/get_area.dart';

part 'get_area_event.dart';
part 'get_area_state.dart';

class GetAreaBloc extends Bloc<GetAreaEvent, GetAreaState> {
  GetAreaUseCase getArea;
  GetAreaBloc({required this.getArea}) : super(GetAreaInitial()) {
    on<GetArea>(_onLoadAreas);
  }

  Future<void> _onLoadAreas(GetArea event, Emitter<GetAreaState> emit) async {
    emit(GetAreaLoading());

    final dataState = await getArea();

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(GetAreaSuccess(dataState.data!));
    } else if (dataState is DataFailed) {
      emit(GetAreaError(dataState.error!));
    }
  }
}
