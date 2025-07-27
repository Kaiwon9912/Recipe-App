class IngredientEntity {
  final String id;
  final String name;
  final String? description;
  final String? type;

  const IngredientEntity({
    required this.id,
    required this.name,
    this.description,
    this.type,
  });
}
