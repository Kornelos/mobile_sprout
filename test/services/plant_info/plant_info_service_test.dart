import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_sprout/model/plant.dart';
import 'package:mobile_sprout/services/plant_info_service.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../utils/plant_info_responses.dart';
import 'plant_info_service_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  test('Should parse correct response', () async {
    //given
    final String searchedPlant = "cabbage";
    final client = MockClient();
    PlantInfoService plantInfoService = PlantInfoService(client);

    //when
    when(client
            .get(Uri.parse(PlantInfoService.getPlantInfoUrl + searchedPlant)))
        .thenAnswer(
            (_) async => http.Response(PlantInfoResponses.cabbageAnswer, 200));
    PlantInfo plantInfoApiResponse =
        await plantInfoService.getPlantInfo("cabbage");

    //then
    expect(plantInfoApiResponse.name, "Cabbage");
  });

  test('Should throw exception on 5xx', () {
    //given
    final String searchedPlant = "cabbage";
    final client = MockClient();
    PlantInfoService plantInfoService = PlantInfoService(client);

    //when
    when(client
            .get(Uri.parse(PlantInfoService.getPlantInfoUrl + searchedPlant)))
        .thenAnswer((_) async => http.Response("", 500));

    //then
    expect(plantInfoService.getPlantInfo(searchedPlant),
        throwsA(isA<Exception>()));
  });
}
