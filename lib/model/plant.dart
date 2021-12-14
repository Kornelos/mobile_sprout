import 'dart:core';
import 'dart:developer';
import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';

class Plant extends Equatable {
  final String nickname;
  final PlantInfo info;
  final Uint8List? _imageBytes;
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
