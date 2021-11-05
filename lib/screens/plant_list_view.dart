import 'package:flutter/widgets.dart';
import 'package:mobile_sprout/model/plant.dart';
import 'package:mobile_sprout/widgets/AddPlantListItem.dart';
import 'package:mobile_sprout/widgets/PlantListItem.dart';

class PlantListView extends StatelessWidget {
  const PlantListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Plant> plants = [
      Plant("plant 1"),
      Plant("plant 2"),
      Plant("plant 3"),
    ];

    return Container(
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 256,
              childAspectRatio: 1,
              crossAxisSpacing: 5,
              mainAxisSpacing: 20),
          itemCount: plants.length + 1,
          itemBuilder: (BuildContext ctx, index) {
            return listItem(index, plants);
          }),
    );
  }

  listItem(int index, List<Plant> plants) {
    if (index == 0) {
      return AddPlantListItem();
    } else {
      return PlantListItem(plant: plants[index - 1]);
    }
  }
}
