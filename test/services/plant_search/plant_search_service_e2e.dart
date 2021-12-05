import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_sprout/services/plant_search_service.dart';

void main() {
  test("Should fetch plant name from online recognition API", () async {
    // given
    PlantSearchService searchService = PlantSearchService(http.Client());

    // when
    PlantNames? plantNames =
        await searchService.getPlantName(XFile("assets/aloes.jpeg"));

    // then
    expect(plantNames.scientificName, "Aloe aristata");
    expect(plantNames.commonNames,
        List<String>.of(["Lace aloe", "Torchplant", "Guinea-fowl aloe"]));
  });
}
