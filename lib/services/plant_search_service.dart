import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class PlantSearchService {
  final http.Client client;

  static final plantSearchUrl = 'http://localhost:8080';

  PlantSearchService(this.client);

  Future<String> getPlantName(XFile image) {
    return Future.value("plant");
  }
}
