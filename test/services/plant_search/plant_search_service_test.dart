import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_sprout/services/plant_search_service.dart';
import 'package:mockito/mockito.dart';

import '../plant_info/plant_info_service_test.mocks.dart';

void main() {
  test("Should parse correct response", () async {
    // given
    final client = MockClient();
    PlantSearchService searchService = PlantSearchService(client);
    var imageData = await XFile("assets/aloes.jpeg").readAsBytes();

    // when
    when(client.post(Uri.parse(PlantSearchService.plantSearchUrl),
            body: imageData))
        .thenAnswer((_) async => http.Response(
            '{"scientificNameWithoutAuthor":"Aloe aristata", "commonNames":["Lace aloe","Torchplant","Guinea-fowl aloe"]}',
            200));
    PlantNames? plantNames =
        await searchService.getPlantName(XFile("assets/aloes.jpeg"));

    // then
    expect(plantNames.scientificName, "Aloe aristata");
    expect(plantNames.commonNames,
        List<String>.of(["Lace aloe", "Torchplant", "Guinea-fowl aloe"]));
  });

  test('Should throw exception on 5xx', () async {
    //given
    final client = MockClient();
    PlantSearchService searchService = PlantSearchService(client);
    var imageData = await XFile("assets/aloes.jpeg").readAsBytes();

    //when
    when(client.post(Uri.parse(PlantSearchService.plantSearchUrl),
            body: imageData))
        .thenAnswer((_) async => http.Response("", 500));

    //then
    expect(searchService.getPlantName(XFile("assets/aloes.jpeg")),
        throwsA(isA<Exception>()));
  });
}
