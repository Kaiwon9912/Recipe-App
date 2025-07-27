// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ingredient_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$IngredientModelImpl _$$IngredientModelImplFromJson(
        Map<String, dynamic> json) =>
    _$IngredientModelImpl(
      id: json['idIngredient'] as String,
      name: json['strIngredient'] as String,
      description: json['strDescription'] as String?,
      type: json['strType'] as String?,
    );

Map<String, dynamic> _$$IngredientModelImplToJson(
        _$IngredientModelImpl instance) =>
    <String, dynamic>{
      'idIngredient': instance.id,
      'strIngredient': instance.name,
      'strDescription': instance.description,
      'strType': instance.type,
    };
