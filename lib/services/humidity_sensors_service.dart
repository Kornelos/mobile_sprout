import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_sprout/model/humidity_data.dart';

abstract class HumiditySensorsService {
  Future<HumidityData> getHumidityDataForPlant(String plantName);

  void registerSensorForPlant(String sensorId, String plantName);
}

/* Idea is that humidity sensors are not connected directly to the app, but
* there is an orchestrating device (possibly raspberry pi or other IoT device)
* which collects and sends data to app over HTTP protocol. This solution
* allows to collect and view live data even if mobile is not in sensor proximity. */
class LocalHumiditySensorsService implements HumiditySensorsService {
  static final sensorOrchestratorUrl =
      "http://10.0.2.2:8000/"; // AVD uses 10.0.2.2 as an alias to your host loopback interface
  final http.Client httpClient;
  final Map<String, String> plantToSensor = Map<String, String>();

  LocalHumiditySensorsService(this.httpClient);

  @override
  Future<HumidityData> getHumidityDataForPlant(String plantName) async {
    if (!plantToSensor.containsKey(plantName)) {
      registerSensorForPlant(plantName, plantName);
    }
    String requestUrl = sensorOrchestratorUrl + plantToSensor[plantName]!;
    final response = await httpClient.get(Uri.parse(requestUrl));
    return HumidityData.fromJson(jsonDecode(response.body));
  }

  @override
  void registerSensorForPlant(String sensorId, String plantName) {
    plantToSensor[plantName] = sensorId;
  }
}
