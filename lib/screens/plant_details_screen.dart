import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mobile_sprout/model/plant.dart';
import 'package:mobile_sprout/providers/settings_provider.dart';
import 'package:provider/provider.dart';

class PlantDetailsView extends StatelessWidget {
  const PlantDetailsView({Key? key, required this.plant}) : super(key: key);

  final Plant plant;

  @override
  Widget build(BuildContext context) {
    ThemeData _theme = Provider.of<SettingsProvider>(context).getTheme();
    return PlatformScaffold(
      backgroundColor: _theme.scaffoldBackgroundColor,
      appBar: PlatformAppBar(
        backgroundColor: _theme.appBarTheme.backgroundColor,
        trailingActions: [Icon(Icons.info)], //todo change to platform icon?
      ),
      body: ListView(
          //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            PlantNameAndPicture(
              theme: _theme,
              plant: plant,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text("Change schedule"),
                ),
                TextButton(onPressed: () {}, child: Text("Change photo")),
              ],
            ),
            Text("Upcoming", style: _theme.textTheme.headline2),
            UpcomingActions(),
            Text("State", style: _theme.textTheme.headline2),
            SensorData(),
            Text("Care", style: _theme.textTheme.headline2),
            Text("some long long text"),
          ]),
    );
  }
}

class SensorData extends StatelessWidget {
  const SensorData({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("data from humidity sensor");
  }
}

class UpcomingActions extends StatelessWidget {
  const UpcomingActions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text("Watering: 2 days"),
        Text("Fertilize: 12 days"),
      ],
    );
  }
}

class PlantNameAndPicture extends StatelessWidget {
  final ThemeData theme;
  final Plant plant;

  const PlantNameAndPicture({
    Key? key,
    required this.theme,
    required this.plant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(plant.nickname, style: theme.textTheme.headline1),
          Image.asset(
            'assets/aloes.jpeg',
            scale: 2,
          ),
        ],
      ),
    );
  }
}
