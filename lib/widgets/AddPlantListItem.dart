import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile_sprout/screens/add_plant_view.dart';

class AddPlantListItem extends StatelessWidget {
  const AddPlantListItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
          child: Card(
              color: Colors.lightGreen[800],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3.0)),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Stack(
                children: [
                  Center(
                    child: Icon(
                      Icons.add_circle_outline,
                      color: Colors.lightGreen,
                      size: 50,
                    ),
                  ),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        "Add plant",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      )),
                ],
              ))),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return AddPlantView();
        }));
      },
    );
  }
}
