import 'package:dio/dio.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'meal_api_service.g.dart';

@RestApi(baseUrl: "https://www.themealdb.com/api/json/v1/1/")
abstract class MealApiService {
  factory MealApiService(Dio dio, {String baseUrl}) = _MealApiService;

  @GET("filter.php")
  Future<HttpResponse> getCategoryMeal(@Query("c") String category);

  @GET("lookup.php")
  Future<HttpResponse> getMeal(@Query("i") String id);

  @GET("search.php")
  Future<HttpResponse> searchMeal(@Query("s") String search);

  @GET("categories.php")
  Future<HttpResponse> getCategories();
  @GET('list.php?a=list')
  Future<HttpResponse> getAreas();

  @GET('list.php?i=list')
  Future<HttpResponse> getIngredients();
  @GET("filter.php")
  Future<HttpResponse> filterByArea(@Query("a") String area);

  @GET("filter.php")
  Future<HttpResponse> filterByIngredient(@Query("i") String ingredient);
}
