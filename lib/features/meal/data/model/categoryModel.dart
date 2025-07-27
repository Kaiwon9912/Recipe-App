import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:repice_app/features/meal/domain/entities/category_entity.dart';

part 'categoryModel.freezed.dart';
part 'categoryModel.g.dart';

@freezed
class CategoryModel with _$CategoryModel {
  const factory CategoryModel({
    required String idCategory,
    required String strCategory,
    required String strCategoryThumb,
    required String strCategoryDescription,
  }) = _CategoryModel;

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);
}

extension CategoryModelX on CategoryModel {
  CategoryEntity toEntity() => CategoryEntity(
    idCategory: idCategory,
    name: strCategory,
    strCategoryThumb: strCategoryThumb,
    strCategoryDescription: strCategoryDescription,
  );
}
