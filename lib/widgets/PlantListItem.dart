import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile_sprout/model/plant.dart';
import 'package:mobile_sprout/screens/plant_details_screen.dart';

class PlantListItem extends StatelessWidget {
  const PlantListItem({Key? key, required this.plant}) : super(key: key);

  final Plant plant;

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
              "assets/plant_sprite.png",
              fit: BoxFit.contain,
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  plant.nickname,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                )),
          ],
        ),
      )),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return PlantDetailsView(plant: plant);
        }));
      },
    );
  }
}
