import 'dart:io';

import 'package:dio/dio.dart';

import 'package:repice_app/core/resources/data_state.dart';
import 'package:repice_app/features/meal/data/data_source/meal_api_service.dart';
import 'package:repice_app/features/meal/data/model/area_model.dart';
import 'package:repice_app/features/meal/data/model/categoryModel.dart';
import 'package:repice_app/features/meal/data/model/ingredient_model.dart';
import 'package:repice_app/features/meal/data/model/mealModel.dart';
import 'package:repice_app/features/meal/domain/entities/area_entity.dart';
import 'package:repice_app/features/meal/domain/entities/category_entity.dart';
import 'package:repice_app/features/meal/domain/entities/ingredient_entity.dart';
import 'package:repice_app/features/meal/domain/entities/meal_entity.dart';
import 'package:repice_app/features/meal/domain/repository/meal_repository.dart';

class MealRepositoryImpl implements MealRepository {
  final MealApiService _mealApiService;

  MealRepositoryImpl(this._mealApiService);

  @override
  Future<DataState<List<MealEntity>>> getMealsByCategory(
    String category,
  ) async {
    try {
      final httpResponse = await _mealApiService.getCategoryMeal(category);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final List<MealEntity> meals = (httpResponse.data['meals'] as List)
            .map((e) => MealModel.fromJson(e).toEntity())
            .toList();
        return DataSuccess(meals);
      } else {
        return DataFailed(
          DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions,
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<MealEntity>>> getMealsByArea(String area) async {
    try {
      final httpResponse = await _mealApiService.filterByArea(area);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final List<MealEntity> meals = (httpResponse.data['meals'] as List)
            .map((e) => MealModel.fromJson(e).toEntity())
            .toList();
        return DataSuccess(meals);
      } else {
        return DataFailed(
          DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions,
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<MealEntity>>> getMealsByIngredient(
    String ingredient,
  ) async {
    try {
      final httpResponse = await _mealApiService.filterByIngredient(ingredient);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final List<MealEntity> meals = (httpResponse.data['meals'] as List)
            .map((e) => MealModel.fromJson(e).toEntity())
            .toList();
        return DataSuccess(meals);
      } else {
        return DataFailed(
          DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions,
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<MealEntity>> getMeal(String id) async {
    try {
      final httpResponse = await _mealApiService.getMeal(id);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final meal = MealModel.fromJson(
          httpResponse.data['meals'][0],
        ).toEntity();
        return DataSuccess(meal);
      } else {
        return DataFailed(
          DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions,
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<MealEntity>>> searchMeals(String search) async {
    try {
      final httpResponse = await _mealApiService.searchMeal(search);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final List<MealEntity> meals = (httpResponse.data['meals'] as List)
            .map((e) => MealModel.fromJson(e).toEntity())
            .toList();
        return DataSuccess(meals);
      } else {
        return DataFailed(
          DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions,
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<CategoryEntity>>> getCategories() async {
    try {
      final httpResponse = await _mealApiService.getCategories();

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final List<CategoryEntity> categories =
            (httpResponse.data['categories'] as List)
                .map((e) => CategoryModel.fromJson(e).toEntity())
                .toList();

        return DataSuccess(categories);
      } else {
        return DataFailed(
          DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions,
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<AreaEntity>>> getAreas() async {
    try {
      final httpResponse = await _mealApiService.getAreas();

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final List<AreaEntity> areas = (httpResponse.data['meals'] as List)
            .map((e) => AreaModel.fromJson(e).toEntity())
            .toList();

        return DataSuccess(areas);
      } else {
        return DataFailed(
          DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions,
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<IngredientEntity>>> getIngredients() async {
    try {
      final httpResponse = await _mealApiService.getIngredients();

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final List<IngredientEntity> ingredients =
            (httpResponse.data['meals'] as List)
                .map((e) => IngredientModel.fromJson(e).toEntity())
                .toList();

        return DataSuccess(ingredients);
      } else {
        return DataFailed(
          DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions,
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
