import 'package:flutter/widgets.dart';
import 'package:mobile_sprout/model/humidity_data.dart';
import 'package:mobile_sprout/services/humidity_sensors_service.dart';
import 'package:http/http.dart' as http;

class HumidityProvider extends ChangeNotifier {
  final Map<String, HumidityData> plantToHumidityData =
      Map<String, HumidityData>();
  final HumiditySensorsService sensorsService =
      LocalHumiditySensorsService(http.Client());

  HumidityData? getDataForPlant(String name) {
    queryForDataUpdateFor(name).whenComplete(() => notifyListeners());
    return plantToHumidityData[name];
  }

  Future<void> queryForDataUpdateFor(String name) async {
    plantToHumidityData[name] =
        await sensorsService.getHumidityDataForPlant(name);
  }
}
