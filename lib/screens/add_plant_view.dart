import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile_sprout/providers/settings_provider.dart';
import 'package:provider/provider.dart';

class AddPlantView extends StatelessWidget {
  const AddPlantView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData _theme = Provider.of<SettingsProvider>(context).getTheme();
    return Scaffold(
        backgroundColor: _theme.scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: _theme.appBarTheme.backgroundColor,
          iconTheme: _theme.iconTheme,
        ),
        body: ListView(
          children: [
            Text(
              "Add new plant",
              textAlign: TextAlign.center,
              style: _theme.textTheme.headline1,
            ),
            Padding(
                padding: EdgeInsets.all(16),
                child: TextField(
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
                    onPressed: () => {},
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
                    onPressed: () => {},
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
                onPressed: () => {},
                icon: Icon(
                  Icons.photo_library_sharp,
                ),
                label: Text(
                  'Search',
                ),
              ),
            ),
          ],
        ));
  }
}
