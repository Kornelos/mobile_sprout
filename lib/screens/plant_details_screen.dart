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
            Text("Information", style: _theme.textTheme.headline2),
            PlantInfo(plant: plant, theme: _theme),
          ]),
    );
  }
}

class PlantInfo extends StatelessWidget {
  final Plant plant;
  final ThemeData theme;

  const PlantInfo({
    Key? key,
    required this.plant,
    required this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            Text(
              "Type",
              style: theme.textTheme.headline2,
            ),
            Padding(padding: EdgeInsets.all(4.0)),
            Text(
              plant.info.type,
              style: theme.textTheme.bodyText1,
            ),
            Padding(padding: EdgeInsets.all(8.0)),
            Text(
              "Description",
              style: theme.textTheme.headline2,
            ),
            Padding(padding: EdgeInsets.all(4.0)),
            Text(
              plant.info.description,
              style: theme.textTheme.bodyText1,
            ),
            Padding(padding: EdgeInsets.all(8.0)),
            Text(
              "Sun requirements",
              style: theme.textTheme.headline2,
            ),
            Padding(padding: EdgeInsets.all(4.0)),
            Text(
              plant.info.sunRequirements,
              style: theme.textTheme.bodyText1,
            ),
            Padding(padding: EdgeInsets.all(8.0)),
            Text(
              "Sowing Method",
              style: theme.textTheme.headline2,
            ),
            Padding(padding: EdgeInsets.all(4.0)),
            Text(
              plant.info.sowingMethod,
              style: theme.textTheme.bodyText1,
            ),
            Padding(padding: EdgeInsets.all(8.0)),
            Text(
              "Example Picture",
              style: theme.textTheme.headline2,
            ),
            Image.network(
              plant.info.mainImagePath,
              scale: 3,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
            ),
          ],
        ));
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
          Column(
            children: [
              Text(plant.nickname,
                  textAlign: TextAlign.left, style: theme.textTheme.headline3),
              Text(plant.info.name,
                  textAlign: TextAlign.left, style: theme.textTheme.headline4),
              Text(plant.info.binomialName,
                  textAlign: TextAlign.left,
                  style: theme.textTheme.headline5!
                      .apply(fontStyle: FontStyle.italic)),
            ],
          ),
          // this will show user picture
          Image.asset(
            'assets/aloes.jpeg',
            scale: 2,
          ),

        ],
      ),
    );
  }
}
