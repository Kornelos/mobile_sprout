import 'dart:async';
import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_sprout/services/plant_info_api_response.dart';
import 'package:mobile_sprout/services/plant_info_service.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../utils/plant_info_responses.dart';
import 'plant_info_service_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  test('Should parse correct response', () async {
    //given
    final String searchedPlant = "cabbage";
    final client = MockClient();
    PlantInfoService plantInfoService = PlantInfoService(client);


    //when
    when(client.get(Uri.parse(PlantInfoService.apiUrl + searchedPlant)))
        .thenAnswer(
            (_) async => http.Response(PlantInfoResponses.cabbageAnswer1, 200));
    PlantInfoApiResponse plantInfoApiResponse = await plantInfoService
        .getPlantInfo("cabbage");

    //then
    expect(plantInfoApiResponse.id, "542e9dce63313600020f1300");
    expect(plantInfoApiResponse.attributes.name, "Cabbage");
    expect(plantInfoApiResponse.attributes.description,
        "Cabbage is a member of the Brassica family and related to kale, broccoli, brussels sprouts, and cauliflower. It's dense, layered heads grow on stalks and are surrounded by looser outer leaves. It's leaves can be green, white, or purple in color, and smooth or crinkly in texture. Depending on the variety, the head can be round, oblong, or flat. Cabbage prefers cooler temperatures and is best planted in the spring or fall."
    );
  });

  test('Should parse correct response with null fields', () async {
    //given
    final String searchedPlant = "cabbage";
    final client = MockClient();
    PlantInfoService plantInfoService = PlantInfoService(client);

    //when
    when(client.get(Uri.parse(PlantInfoService.apiUrl + searchedPlant)))
        .thenAnswer(
            (_) async => http.Response(PlantInfoResponses.cabbageAnswer2, 200));

    PlantInfoApiResponse plantInfoApiResponse =
    await plantInfoService.getPlantInfo("cabbage");

    //then
    expect(plantInfoApiResponse.id, "54afdeff31666300029d0900");
    expect(plantInfoApiResponse.attributes.name, "cabbage");
    expect(plantInfoApiResponse.attributes.description, null);
    expect(plantInfoApiResponse.attributes.sunRequirements, null);
  });

  test('Should throw exception on 5xx', () {
    //given
    final String searchedPlant = "cabbage";
    final client = MockClient();
    PlantInfoService plantInfoService = PlantInfoService(client);

    //when
    when(client.get(Uri.parse(PlantInfoService.apiUrl + searchedPlant)))
        .thenAnswer(
            (_) async => http.Response("", 500));

    //then
    expect(plantInfoService.getPlantInfo(searchedPlant),
        throwsA(isA<Exception>()));
  });
}