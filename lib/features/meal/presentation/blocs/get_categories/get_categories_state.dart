part of 'get_categories_bloc.dart';

sealed class GetCategoriesState extends Equatable {
  const GetCategoriesState();

  @override
  List<Object> get props => [];
}

final class GetCategoriesInitial extends GetCategoriesState {}

final class GetCategoriesLoading extends GetCategoriesState {}

final class GetCategoriesSuccess extends GetCategoriesState {
  final List<CategoryEntity> categories;
  const GetCategoriesSuccess(this.categories);
  @override
  List<Object> get props => [categories];
}

final class GetCategoriesError extends GetCategoriesState {
  final DioException? error;
  const GetCategoriesError(this.error);
}
