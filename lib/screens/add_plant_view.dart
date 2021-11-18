import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_sprout/providers/plants_provider.dart';
import 'package:mobile_sprout/providers/settings_provider.dart';
import 'package:mobile_sprout/services/plant_search_service.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class AddPlantView extends StatefulWidget {
  const AddPlantView({Key? key}) : super(key: key);

  @override
  State<AddPlantView> createState() => _AddPlantViewState();
}

class _AddPlantViewState extends State<AddPlantView> {
  final _plantSearchService = PlantSearchService(http.Client());
  final ImagePicker _picker = ImagePicker();
  var textController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    ThemeData _theme = Provider.of<SettingsProvider>(context).getTheme();
    PlantsProvider plantsProvider = Provider.of<PlantsProvider>(context);
    return Scaffold(
        backgroundColor: _theme.scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: _theme.appBarTheme.backgroundColor,
          iconTheme: _theme.iconTheme,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Add new plant",
              textAlign: TextAlign.center,
              style: _theme.textTheme.headline1,
            ),
            Padding(
                padding: EdgeInsets.all(16),
                child: TextField(
                  controller: textController,
                  decoration: InputDecoration(labelText: "Plant species name"),
                )),
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton.icon(
                    style: TextButton.styleFrom(
                      textStyle: TextStyle(color: Colors.white),
                      backgroundColor: Colors.lightGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                    ),
                    onPressed: () => _getImageFromPicker(ImageSource.camera),
                    icon: Icon(
                      Icons.camera_alt,
                    ),
                    label: Text(
                      'From camera',
                    ),
                  ),
                  const SizedBox(width: 16),
                  TextButton.icon(
                    style: TextButton.styleFrom(
                      textStyle: TextStyle(color: Colors.white),
                      backgroundColor: Colors.lightGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                    ),
                    onPressed: () => _getImageFromPicker(ImageSource.gallery),
                    icon: Icon(
                      Icons.photo_library_sharp,
                    ),
                    label: Text(
                      'From gallery',
                    ),
                  ),
                ]),
            Padding(
              padding: EdgeInsets.all(16),
              child: TextButton.icon(
                style: TextButton.styleFrom(
                  textStyle: TextStyle(color: Colors.white),
                  backgroundColor: Colors.lightGreen,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                ),
                onPressed: () => _addPlantAndGoBack(plantsProvider),
                icon: Icon(
                  Icons.zoom_in,
                ),
                label: Text(
                  'Search & Add',
                ),
              ),
            ),
          ],
        ));
  }

  void _getImageFromPicker(ImageSource source) async {
    XFile? pic = await _picker.pickImage(source: source);
    if (pic != null) {
      var name = await _plantSearchService.getPlantName(pic);
      textController.text = name;
    } else {
      //  todo: add error alert
    }
  }

  void _addPlantAndGoBack(PlantsProvider plantsProvider){
    plantsProvider.addPlantMock();
    Navigator.pop(context);
  }
}
