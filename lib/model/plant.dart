import 'dart:core';
import 'dart:developer';
import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:mobile_sprout/model/hive_types.dart';

import 'hive_types.dart';

part 'plant.g.dart';

@HiveType(typeId: HiveFields.PLANT)
class Plant extends Equatable {
  @HiveField(1)
  final String nickname;
  @HiveField(2)
  final PlantInfo info;
  @HiveField(3)
  final Uint8List? _imageBytes;
  @HiveField(4)
  final String _placeholderPath = 'assets/plant_sprite.png';

  Plant(this.nickname, this.info, this._imageBytes);

  factory Plant.withPlaceholderImage(nickname, info) {
    return Plant(nickname, info, null);
  }

  Future<Uint8List> getImageBytes() async {
    if (_imageBytes != null) {
      return Future.value(_imageBytes);
    } else {
      return loadPlaceholder();
    }
  }

  @override
  List<Object?> get props => [nickname];

  Future<Uint8List> loadPlaceholder() async {
    try {
      ByteData data = await rootBundle.load(_placeholderPath);
      return data.buffer.asUint8List();
    } catch (ex) {
      log(ex.toString());
    }
    return Future.value(Uint8List.fromList(List.empty()));
  }

  Plant createRenamed(String newName){
    return Plant(newName, info, _imageBytes);
  }

}
@HiveType(typeId: HiveFields.PLANT_INFO)
class PlantInfo extends Equatable {
  const PlantInfo(this.name, this.type, this.binomialName, this.description,
      this.sunRequirements, this.sowingMethod, this.mainImagePath);
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String type;
  @HiveField(3)
  final String binomialName;
  @HiveField(4)
  final String description;
  @HiveField(5)
  final String sunRequirements;
  @HiveField(6)
  final String sowingMethod;
  @HiveField(7)
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
