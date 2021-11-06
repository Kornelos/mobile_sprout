import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_sprout/services/plant_info_api_response.dart';

class PlantInfoService {

  final http.Client httpClient;

  static final apiUrl = "https://openfarm.cc/api/v1/crops/?filter=";

  PlantInfoService(this.httpClient);


  Future<PlantInfoApiResponse> getPlantInfo(String name) async{
    final response = await httpClient.get(Uri.parse(apiUrl + name));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return  PlantInfoApiResponse.fromJson(jsonDecode(response.body)['data'][0]);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to get plant info for $name');
    }  }

}