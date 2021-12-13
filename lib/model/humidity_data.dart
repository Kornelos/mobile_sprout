import 'package:equatable/equatable.dart';

class HumidityData {
  final List<HumidityDataPoint> humidityDataPoints;

  HumidityData(this.humidityDataPoints);

  factory HumidityData.fromJson(Map<String, dynamic> json) {
    List casted = json["hmi_data"] as List;
    return HumidityData(casted.map((j) => HumidityDataPoint.fromJson(j)).toList());
  }
}

class HumidityDataPoint extends Equatable {
  final DateTime datetime;
  final int humidity;

  HumidityDataPoint(this.datetime, this.humidity);

  @override
  List<Object> get props => [datetime, humidity];

  factory HumidityDataPoint.fromJson(Map<String, dynamic> json) =>
      HumidityDataPoint(DateTime.parse(json['dt']), json['hmi']);
}
