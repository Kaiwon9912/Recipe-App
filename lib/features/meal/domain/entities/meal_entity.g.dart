// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MealEntityAdapter extends TypeAdapter<MealEntity> {
  @override
  final int typeId = 2;

  @override
  MealEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MealEntity(
      id: fields[0] as String,
      name: fields[1] as String,
      category: fields[2] as String?,
      area: fields[3] as String?,
      instructions: fields[4] as String?,
      thumbnail: fields[5] as String?,
      youtubeUrl: fields[6] as String?,
      ingredients: (fields[7] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, MealEntity obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.category)
      ..writeByte(3)
      ..write(obj.area)
      ..writeByte(4)
      ..write(obj.instructions)
      ..writeByte(5)
      ..write(obj.thumbnail)
      ..writeByte(6)
      ..write(obj.youtubeUrl)
      ..writeByte(7)
      ..write(obj.ingredients);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MealEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
