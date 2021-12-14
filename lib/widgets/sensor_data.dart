import 'package:flutter/material.dart';
import 'package:mobile_sprout/model/humidity_data.dart';
import 'package:mobile_sprout/providers/humidity_provider.dart';
import 'package:mobile_sprout/widgets/time_series_chart.dart';
import 'package:provider/provider.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class SensorData extends StatelessWidget {
  final plantName;

  const SensorData({
    Key? key,
    required this.plantName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var humidityData =
        Provider.of<HumidityProvider>(context).getDataForPlant(plantName);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
              "current humidity value: ${humidityData?.humidityDataPoints.last.humidity ?? "-"}%"),
          SizedBox(
            width: 200,
            height: 100,
            child: SimpleTimeSeriesChart([
              new charts.Series<HumidityDataPoint, DateTime>(
                id: 'Humidity',
                colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
                domainFn: (HumidityDataPoint data, _) => data.datetime,
                measureFn: (HumidityDataPoint data, _) => data.humidity,
                data: humidityData?.humidityDataPoints ?? [],
              )
            ]),
          )
        ],
      ),
    );
  }
}
