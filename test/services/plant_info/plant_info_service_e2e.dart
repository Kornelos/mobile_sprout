import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_sprout/model/plant.dart';
import 'package:mobile_sprout/services/plant_info_service.dart';
import 'package:http/http.dart' as http;

void main() {
  test("Should fetch plant data from online backend", () async {
    // given
    PlantInfoService plantInfoService = PlantInfoService(http.Client());

    // when
    PlantInfo plantInfo1 = await plantInfoService.getPlantInfo("Cabbage");
    PlantInfo plantInfo2 = await plantInfoService.getPlantInfo("caBBage");
    PlantInfo plantInfo3 = await plantInfoService.getPlantInfo("cabbage");

    // then
    expect(plantInfo1.name, "Cabbage");
    expect(plantInfo2.name, "Cabbage");
    expect(plantInfo3.name, "Cabbage");
  });

  test("Should throw an exception on non existing plant from online backend",
      () async {
    PlantInfoService plantInfoService = PlantInfoService(http.Client());

    expect(plantInfoService.getPlantInfo("fewgwegewdewdcfdg32423"),
        throwsA(isA<Exception>()));
  });
}
