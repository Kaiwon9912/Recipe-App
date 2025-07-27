import 'package:equatable/equatable.dart';

class AreaEntity extends Equatable {
  final String name;

  const AreaEntity({required this.name});

  @override
  // TODO: implement props
  List<Object?> get props => [name];
}
