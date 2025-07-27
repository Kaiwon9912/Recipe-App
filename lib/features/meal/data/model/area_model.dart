import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:repice_app/features/meal/domain/entities/area_entity.dart';

part 'area_model.freezed.dart';
part 'area_model.g.dart';

@freezed
class AreaModel with _$AreaModel {
  const factory AreaModel({@JsonKey(name: 'strArea') required String name}) =
      _AreaModel;

  factory AreaModel.fromJson(Map<String, dynamic> json) =>
      _$AreaModelFromJson(json);
}

extension AreaModelX on AreaModel {
  AreaEntity toEntity() => AreaEntity(name: name);
}
