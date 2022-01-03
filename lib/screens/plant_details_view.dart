import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_sprout/model/task.dart';
import 'package:mobile_sprout/model/plant.dart';
import 'package:mobile_sprout/providers/tasks_provider.dart';
import 'package:mobile_sprout/providers/plants_provider.dart';
import 'package:mobile_sprout/providers/settings_provider.dart';
import 'package:mobile_sprout/screens/plant_list_view.dart';
import 'package:mobile_sprout/screens/tasks_view.dart';
import 'package:mobile_sprout/widgets/add_task_form.dart';
import 'package:mobile_sprout/widgets/image_from_plant.dart';
import 'package:mobile_sprout/widgets/rename_plant_form.dart';
import 'package:mobile_sprout/widgets/sensor_data.dart';
import 'package:mobile_sprout/widgets/time_series_chart.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

class PlantDetailsView extends StatelessWidget {
  const PlantDetailsView({Key? key, required this.plant}) : super(key: key);

  final Plant plant;

  @override
  Widget build(BuildContext context) {
    ThemeData _theme = Provider.of<SettingsProvider>(context).getTheme();
    return Scaffold(
      backgroundColor: _theme.scaffoldBackgroundColor,
      appBar: AppBar(
        iconTheme: _theme.iconTheme,
        backgroundColor: _theme.appBarTheme.backgroundColor,
        actions: [
          IconButton(
            icon: Icon(Icons.more_horiz),
            onPressed: () {
              showMaterialModalBottomSheet(
                context: context,
                expand: false,
                backgroundColor: Colors.transparent,
                builder: (context) => PlantDetailsModal(
                  plant: plant,
                ),
              );
            },
          )
        ],
      ),
      body: ListView(children: [
        PlantNameAndPicture(
          theme: _theme,
          plant: plant,
        ),
        Text("Upcoming tasks", style: _theme.textTheme.headline2),
        UpcomingActions(
          relatedPlant: plant.nickname,
          theme: _theme,
        ),
        Text("State", style: _theme.textTheme.headline2),
        SensorData(plantName: plant.nickname),
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

class UpcomingActions extends StatelessWidget {
  final String relatedPlant;
  final ThemeData theme;

  const UpcomingActions({
    Key? key,
    required this.relatedPlant,
    required this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TasksProvider notificationProvider = Provider.of<TasksProvider>(context);
    List tasks = notificationProvider.notifications
        .where((element) => element.relatedPlant == relatedPlant)
        .toList();

    return Container(
      height: 50,
      width: 200,
      child: tasks.isNotEmpty
          ? ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: tasks.length,
              itemBuilder: (BuildContext context, int index) {
                Task task = tasks[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1)),
                    ),
                    onPressed: () {},
                    color: Colors.white,
                    child: Text(
                        "${task.type.toString().split('.')[1]} ${task.getRelativeDateString()}"),
                  ),
                );
              },
            )
          : Text(
              "No upcoming tasks for $relatedPlant.",
              style: theme.textTheme.bodyText2,
            ),
    );
/*
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
    Text("Watering: 2 days"),
    Text("Fertilize: 12 days"),
    ],
    */
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
          ImageFromPlant(
            plant: plant.getImageBytes(),
          ),
        ],
      ),
    );
  }
}

class PlantDetailsModal extends StatelessWidget {
  final Plant plant;

  const PlantDetailsModal({Key? key, required this.plant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PlantsProvider _plantsProvider = Provider.of<PlantsProvider>(context);

    return Material(
        child: SafeArea(
      top: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text('Rename plant'),
            leading: Icon(Icons.edit),
            onTap: () {
              Navigator.of(context).pop();
              showDialog(
                  context: context,
                  builder: (context) {
                    return RenamePlantForm(relatedPlant: plant);
                  });
            },
          ),
          ListTile(
            title: Text('Change schedule'),
            leading: Icon(Icons.calendar_today),
            onTap: () {
              Navigator.of(context).pop();
              showDialog(
                  context: context,
                  builder: (context) {
                    return TaskForm(relatedPlantName: plant.nickname);
                  });
              //Navigator.of(context).pop();
            },
          ),
          ListTile(
            title: Text('Change photo'),
            leading: Icon(Icons.photo_camera),
            onTap: () {
              selectNewPhoto(context);
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            title: Text(
              'Delete plant',
              style: TextStyle(color: Colors.red),
            ),
            leading: Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onTap: () {
              Navigator.of(context).pop();
              _plantsProvider.deletePlant(plant);
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    ));
  }

  void selectNewPhoto(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    final PlantsProvider plantsProvider =
        Provider.of<PlantsProvider>(context, listen: false);
    XFile? pic = await _picker.pickImage(source: ImageSource.gallery);
    var bytes = await pic!.readAsBytes();
    var modified = Plant(plant.nickname, plant.info, bytes);
    plantsProvider.updatePlant(plant, modified);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => PlantDetailsView(plant: modified)));
  }
}
