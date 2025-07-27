part of 'get_area_bloc.dart';

sealed class GetAreaState extends Equatable {
  const GetAreaState();

  @override
  List<Object> get props => [];
}

final class GetAreaInitial extends GetAreaState {}

final class GetAreaLoading extends GetAreaState {}

final class GetAreaSuccess extends GetAreaState {
  final List<AreaEntity> areas;
  const GetAreaSuccess(this.areas);
  @override
  List<Object> get props => [areas];
}

final class GetAreaError extends GetAreaState {
  final DioException? error;
  const GetAreaError(this.error);
}
