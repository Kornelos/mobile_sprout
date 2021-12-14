import 'package:flutter/widgets.dart';
import 'package:mobile_sprout/model/plant.dart';
import 'package:mobile_sprout/providers/plants_provider.dart';
import 'package:mobile_sprout/widgets/add_plant_list_item.dart';
import 'package:mobile_sprout/widgets/plant_list_item.dart';
import 'package:provider/provider.dart';

class PlantListView extends StatelessWidget {
  const PlantListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Plant> _plants = Provider.of<PlantsProvider>(context).getPlants();

    return Container(
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 256,
              childAspectRatio: 1,
              crossAxisSpacing: 5,
              mainAxisSpacing: 20),
          itemCount: _plants.length + 1,
          itemBuilder: (BuildContext ctx, index) {
            return listItem(index, _plants);
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
