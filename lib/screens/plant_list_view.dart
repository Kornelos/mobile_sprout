import 'package:flutter/widgets.dart';
import 'package:mobile_sprout/widgets/AddPlantListItem.dart';
import 'package:mobile_sprout/widgets/PlantListItem.dart';

class PlantListView extends StatelessWidget {
  const PlantListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> plants = ['1', '2', '3', '4', '5', '6', '7'];

    return Container(
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 256,
              childAspectRatio: 1,
              crossAxisSpacing: 5,
              mainAxisSpacing: 20),
          itemCount: plants.length,
          itemBuilder: (BuildContext ctx, index) {
            return listItem(index);
          }),
    );
  }

  listItem(int index) {
    if (index == 0) {
      return AddPlantListItem();
    } else {
      return PlantListItem(index: index);
    }
  }
}
