import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile_sprout/model/plant.dart';
import 'package:mobile_sprout/screens/plant_details_screen.dart';
import 'package:mobile_sprout/widgets/image_from_plant.dart';

class PlantListItem extends StatefulWidget {
  const PlantListItem({Key? key, required this.plant}) : super(key: key);
  final Plant plant;

  @override
  State<PlantListItem> createState() => _PlantListItemState();
}

class _PlantListItemState extends State<PlantListItem> {
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
            ImageFromPlant(plant: widget.plant.getImageBytes()),
            Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  widget.plant.nickname,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                )),
          ],
        ),
      )),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return PlantDetailsView(plant: widget.plant);
        }));
      },
    );
  }
}
