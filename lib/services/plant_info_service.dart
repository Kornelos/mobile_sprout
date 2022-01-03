import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_sprout/model/plant.dart';

class PlantInfoService {
  final http.Client httpClient;

  static final getPlantInfoUrl =
      "https://europe-central2-sprout-331812.cloudfunctions.net/plant-info?name=";

  PlantInfoService(this.httpClient);

  Future<PlantInfo> getPlantInfo(String name) async {
    final response = await httpClient.get(Uri.parse(getPlantInfoUrl + name)).timeout(Duration(seconds: 5));
    if (response.statusCode == 200) {
      return PlantInfo.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception. (to decide if empty info should be returned)
      throw Exception('Failed to get plant info for $name');
    }
  }
}
