import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/meal_entity.dart';

part 'mealModel.freezed.dart';
part 'mealModel.g.dart';

@freezed
class MealModel with _$MealModel {
  const MealModel._();
  const factory MealModel({
    @JsonKey(name: 'idMeal') required String id,
    @JsonKey(name: 'strMeal') required String name,
    @JsonKey(name: 'strCategory') String? category,
    @JsonKey(name: 'strArea') String? area,
    @JsonKey(name: 'strInstructions') String? instructions,
    @JsonKey(name: 'strMealThumb') String? thumbnail,
    @JsonKey(name: 'strYoutube') String? youtubeUrl,

    String? strIngredient1,
    String? strIngredient2,
    String? strIngredient3,
    String? strIngredient4,
    String? strIngredient5,
    String? strIngredient6,
    String? strIngredient7,
    String? strIngredient8,
    String? strIngredient9,
    String? strIngredient10,
    String? strIngredient11,
    String? strIngredient12,
    String? strIngredient13,
    String? strIngredient14,
    String? strIngredient15,
    String? strIngredient16,
    String? strIngredient17,
    String? strIngredient18,
    String? strIngredient19,
    String? strIngredient20,

    String? strMeasure1,
    String? strMeasure2,
    String? strMeasure3,
    String? strMeasure4,
    String? strMeasure5,
    String? strMeasure6,
    String? strMeasure7,
    String? strMeasure8,
    String? strMeasure9,
    String? strMeasure10,
    String? strMeasure11,
    String? strMeasure12,
    String? strMeasure13,
    String? strMeasure14,
    String? strMeasure15,
    String? strMeasure16,
    String? strMeasure17,
    String? strMeasure18,
    String? strMeasure19,
    String? strMeasure20,
  }) = _MealModel;

  factory MealModel.fromJson(Map<String, dynamic> json) =>
      _$MealModelFromJson(json);

  MealEntity toEntity() {
    final ingredients = <String>[];
    final data = toJson();

    for (int i = 1; i <= 20; i++) {
      final ingredient = data['strIngredient$i'] as String?;
      final measure = data['strMeasure$i'] as String?;

      if (ingredient != null && ingredient.trim().isNotEmpty) {
        ingredients.add(
          measure != null && measure.trim().isNotEmpty
              ? '$ingredient - $measure'
              : ingredient,
        );
      }
    }

    return MealEntity(
      id: id,
      name: name,
      category: category,
      area: area,
      instructions: instructions,
      thumbnail: thumbnail,
      youtubeUrl: youtubeUrl,
      ingredients: ingredients,
    );
  }
}
