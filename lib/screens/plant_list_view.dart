import 'package:flutter/widgets.dart';
import 'package:mobile_sprout/model/plant.dart';
import 'package:mobile_sprout/providers/plants_provider.dart';
import 'package:mobile_sprout/widgets/AddPlantListItem.dart';
import 'package:mobile_sprout/widgets/PlantListItem.dart';
import 'package:provider/provider.dart';

class PlantListView extends StatelessWidget {
  const PlantListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // PlantInfo info = PlantInfo(
    //   "Cabbage",
    //   "crops",
    //   "Brassica oleracea",
    //   "Cabbage is a member of the Brassica family and related to kale, broccoli, brussels sprouts, and cauliflower. It's dense, layered heads grow on stalks and are surrounded by looser outer leaves. It's leaves can be green, white, or purple in color, and smooth or crinkly in texture. Depending on the variety, the head can be round, oblong, or flat. Cabbage prefers cooler temperatures and is best planted in the spring or fall.",
    //   "Full Sun",
    //   "Direct seed indoors, transplant seedlings outside after hardening off.",
    //   "https://s3.amazonaws.com/openfarm-project/production/media/pictures/attachments/5928732ef9f0b200040000c0.jpg?1495823146",
    // );
    // final List<Plant> plants = [
    //   Plant("Living Room plant", info),
    //   Plant("Kitchen plant", info),
    //   Plant("My favourite plant", info),
    // ];

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
