import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:repice_app/features/meal/domain/entities/ingredient_entity.dart';

part 'ingredient_model.freezed.dart';
part 'ingredient_model.g.dart';

@freezed
class IngredientModel with _$IngredientModel {
  const factory IngredientModel({
    @JsonKey(name: 'idIngredient') required String id,
    @JsonKey(name: 'strIngredient') required String name,
    @JsonKey(name: 'strDescription') String? description,
    @JsonKey(name: 'strType') String? type,
  }) = _IngredientModel;

  factory IngredientModel.fromJson(Map<String, dynamic> json) =>
      _$IngredientModelFromJson(json);
}

extension IngredientModelX on IngredientModel {
  IngredientEntity toEntity() => IngredientEntity(
    id: id,
    name: name,
    description: description,
    type: type,
  );
}
