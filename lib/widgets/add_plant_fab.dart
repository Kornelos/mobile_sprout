import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:getwidget/components/card/gf_card.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:mobile_sprout/screens/add_plant_view.dart';

class AddPlantFAB extends StatelessWidget {
  const AddPlantFAB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.lightGreen,
      child: Icon(
        Icons.add,
        color: Colors.white,
        size: 40,
      ),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return AddPlantView();
        }));
      },
    );
  }
}
