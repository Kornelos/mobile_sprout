import 'package:flutter/widgets.dart';

class PlantListItem extends StatelessWidget {
  const PlantListItem({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        child: Center(
          child: Text('Entry $index'),
        ));
  }
}
