import 'package:equatable/equatable.dart';

class Plant extends Equatable {
  const Plant(this.name);

  final String name;

  @override
  List<Object?> get props => [name];

  factory Plant.fromJson(Map<String, dynamic> json) {
    return Plant(json['name']);
  }
}
