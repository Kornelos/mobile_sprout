import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PlantSearchService {
  final http.Client client;

  static final plantSearchUrl =
      'https://europe-central2-sprout-331812.cloudfunctions.net/plant-image-search';

  PlantSearchService(this.client);

  Future<PlantNames> getPlantName(XFile image) async {
    final response = await client.post(Uri.parse(plantSearchUrl),
        body: await image.readAsBytes());
    if (response.statusCode == 200) {
      return PlantNames.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception. (to decide if empty info should be returned)
      throw Exception('Failed to get plant name');
    }
  }
}

class PlantNames {
  final String scientificName;
  final List<String> commonNames;

  PlantNames(this.scientificName, this.commonNames);

  factory PlantNames.fromJson(Map<String, dynamic> json) => PlantNames(
      json['scientificNameWithoutAuthor'], json['commonNames'].cast<String>());
}
