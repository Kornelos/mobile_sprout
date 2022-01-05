import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_sprout/model/humidity_data.dart';
import 'package:mobile_sprout/services/humidity_sensors_service.dart';
import 'package:http/http.dart' as http;

void main() {
  test('Should parse correct response', () async {
    //given
    final String plantName = "my_awesome_plant";
    HumiditySensorsService humiditySensorsService =
        LocalHumiditySensorsService(http.Client());

    //when
    HumidityData humidityData =
        await humiditySensorsService.getHumidityDataForPlant(plantName);

    //then
    expect(humidityData.humidityDataPoints.length, 4);
    expect(humidityData.humidityDataPoints.first.datetime,
        DateTime(2021, 12, 13, 19));
  });
}

String deviceResponse() => """
{
"sensor_id" : "some_sensor",
"hmi_data": [
{"hmi": 50, "dt": "2021-12-13T19:00:00" },
{"hmi": 45, "dt": "2021-12-13T20:00:00" },
{"hmi": 43, "dt": "2021-12-13T21:00:00" },
{"hmi": 99, "dt": "2021-12-13T22:00:00" }
]
}
""";
