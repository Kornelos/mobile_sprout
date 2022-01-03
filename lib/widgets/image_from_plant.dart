import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ImageFromPlant extends StatefulWidget {
  final Future<Uint8List> plant;

  const ImageFromPlant({
    Key? key,
    required this.plant,
  }) : super(key: key);

  @override
  State<ImageFromPlant> createState() => _ImageFromPlantState(plant);
}

class _ImageFromPlantState extends State<ImageFromPlant> {
  final Future<Uint8List> _imageBytes;

  _ImageFromPlantState(this._imageBytes);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _imageBytes,
        builder: (BuildContext context, AsyncSnapshot<Uint8List> snapshot) {
          if (snapshot.hasData) {
            return SizedBox(
              width: 200,
              height: 200,
              child: Image.memory(
                snapshot.data!,
                width: 200,
                height: 200,
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
