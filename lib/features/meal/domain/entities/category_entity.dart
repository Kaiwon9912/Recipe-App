import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final String idCategory;
  final String name;
  final String strCategoryThumb;
  final String strCategoryDescription;

  const CategoryEntity({
    required this.idCategory,
    required this.name,
    required this.strCategoryThumb,
    required this.strCategoryDescription,
  });
  factory CategoryEntity.empty() => CategoryEntity(
    idCategory: '',
    name: '',
    strCategoryThumb: '',
    strCategoryDescription: '',
  );

  @override
  List<Object?> get props => [
    idCategory,
    name,
    strCategoryThumb,
    strCategoryDescription,
  ];
}
