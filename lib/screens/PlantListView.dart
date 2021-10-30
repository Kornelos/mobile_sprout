import 'package:flutter/widgets.dart';
import 'package:mobile_sprout/widgets/PlantListItem.dart';

class PlantListView extends StatelessWidget {
  const PlantListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> plants = ['1', '2', '3'];

    return Container(
        child: ListView.builder(
      itemCount: plants.length,
      itemBuilder: (BuildContext context, int index) {
        return PlantListItem(index: index);
      },
    ));
  }
}
