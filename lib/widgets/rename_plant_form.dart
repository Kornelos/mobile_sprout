import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_sprout/model/plant.dart';
import 'package:mobile_sprout/model/task.dart';
import 'package:mobile_sprout/providers/plants_provider.dart';
import 'package:mobile_sprout/providers/tasks_provider.dart';
import 'package:mobile_sprout/providers/settings_provider.dart';
import 'package:mobile_sprout/screens/plant_details_view.dart';
import 'package:provider/provider.dart';

class RenamePlantForm extends StatefulWidget {
  const RenamePlantForm({Key? key, required this.relatedPlant})
      : super(key: key);
  final Plant relatedPlant;

  @override
  State<RenamePlantForm> createState() => _RenamePlantFormState(relatedPlant);
}

class _RenamePlantFormState extends State<RenamePlantForm> {
  var _nicknameTextController = new TextEditingController();
  final Plant _relatedPlant;

  _RenamePlantFormState(this._relatedPlant);

  @override
  Widget build(BuildContext context) {
    PlantsProvider _plantsProvider = Provider.of<PlantsProvider>(context);
    return AlertDialog(
      title: Text("Rename plant"),
      content: Container(
        width: double.maxFinite,
        height: 200,
        child: TextField(
          controller: _nicknameTextController,
          decoration: InputDecoration(hintText: "Unique nickname"),
        ),
      ),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              Navigator.pop(context);
              if (_plantsProvider
                  .plantNamedExists(_nicknameTextController.text)) {
                Fluttertoast.showToast(
                    msg:
                        "Plant named ${_nicknameTextController.text} already exists.");
              } else {
                _plantsProvider.renamePlant(
                    _relatedPlant, _nicknameTextController.text);
              }
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (ctx) => PlantDetailsView(
                          plant: _plantsProvider
                              .getPlantNamed(_nicknameTextController.text)!)));
            },
            child: Text(
              "Rename",
            ))
      ],
    );
  }
}
