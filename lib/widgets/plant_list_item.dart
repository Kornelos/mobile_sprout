import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:getwidget/components/card/gf_card.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:getwidget/position/gf_position.dart';
import 'package:mobile_sprout/model/plant.dart';
import 'package:mobile_sprout/screens/plant_details_view.dart';

class PlantListItem extends StatefulWidget {
  const PlantListItem({Key? key, required this.plant}) : super(key: key);
  final Plant plant;

  @override
  State<PlantListItem> createState() =>
      _PlantListItemState(plant.getImageBytes(), plant);
}

class _PlantListItemState extends State<PlantListItem> {
  final Future<Uint8List> _plantImageBytes;
  final Plant _plant;

  _PlantListItemState(this._plantImageBytes, this._plant);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: FutureBuilder(
        future: _plantImageBytes,
        builder: (BuildContext ctx, AsyncSnapshot<Uint8List> snapshot) {
          if (snapshot.hasData) {
            return GFCard(
              boxFit: BoxFit.cover,
              titlePosition: GFPosition.start,
              showImage: true,
              image: Image.memory(
                snapshot.data!,
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.contain,
              ),
              title: GFListTile(
                titleText: _plant.nickname,
                subTitleText: _plant.info.binomialName,
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return PlantDetailsView(plant: widget.plant);
        }));
      },
    );
  }
}
