import 'package:hive/hive.dart';

part 'meal_entity.g.dart'; // để Hive sinh file này

@HiveType(typeId: 2)
class MealEntity {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String? category;

  @HiveField(3)
  final String? area;

  @HiveField(4)
  final String? instructions;

  @HiveField(5)
  final String? thumbnail;

  @HiveField(6)
  final String? youtubeUrl;

  @HiveField(7)
  final List<String> ingredients;

  const MealEntity({
    required this.id,
    required this.name,
    this.category,
    this.area,
    this.instructions,
    this.thumbnail,
    this.youtubeUrl,
    required this.ingredients,
  });
}
