import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mobile_sprout/screens/plant_details_screen.dart';
import 'package:mobile_sprout/screens/plant_list_view.dart';

class PlantListItem extends StatelessWidget {
  const PlantListItem({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    // todo: update layout
    return GestureDetector(
      child: Container(
          child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.0)),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Stack(
          children: [
            Image.asset(
              "assets/aloes.jpeg",
              fit: BoxFit.contain,
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  "Plant name",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                )),
          ],
        ),
      )),
      onTap: () {
        Navigator.push(
            context,
            platformPageRoute(
                context: context,
                builder: (context) {
                  return PlantDetailsView();
                }));
      },
    );
  }
}
