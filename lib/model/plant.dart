import 'package:equatable/equatable.dart';

class Plant extends Equatable {
  final String nickname;
  final PlantInfo info;
  final String imagePath = "assets/plant_sprite.png";

  Plant(this.nickname, this.info);

  @override
  List<Object?> get props => [nickname];
}

class PlantInfo extends Equatable {
  const PlantInfo(this.name, this.type, this.binomialName, this.description,
      this.sunRequirements, this.sowingMethod, this.mainImagePath);

  final String name;
  final String type;
  final String binomialName;
  final String description;
  final String sunRequirements;
  final String sowingMethod;
  final String mainImagePath;

  @override
  List<Object?> get props => [name];

  factory PlantInfo.fromJson(Map<String, dynamic> json) {
    return PlantInfo(
        json['name'],
        json['type'],
        json['binomial_name'],
        json['description'],
        json['sun_requirements'],
        json['sowing_method'],
        json['main_image_path']);
  }
}
