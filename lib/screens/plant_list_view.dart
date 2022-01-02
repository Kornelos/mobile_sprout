import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile_sprout/model/plant.dart';
import 'package:mobile_sprout/providers/plants_provider.dart';
import 'package:mobile_sprout/providers/settings_provider.dart';
import 'package:mobile_sprout/widgets/add_plant_fab.dart';
import 'package:mobile_sprout/widgets/plant_list_item.dart';
import 'package:provider/provider.dart';

class PlantListView extends StatelessWidget {
  const PlantListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData _theme = Provider.of<SettingsProvider>(context).getTheme();
    List<Plant> _plants = Provider.of<PlantsProvider>(context).getPlants();

    return Container(
      child: Scaffold(
          body: _plants.isNotEmpty
              ? GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 400,
                      childAspectRatio: 1.25,
                      crossAxisSpacing: 1,
                      mainAxisSpacing: 1),
                  itemCount: _plants.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return listItem(index, _plants);
                  })
              : Center(
                child: Text(
                    "You don't have any plants, add some!",
                    style: _theme.textTheme.headline3,
                  ),
              ),
          floatingActionButton: AddPlantFAB()),
    );
  }

  listItem(int index, List<Plant> plants) {
    return PlantListItem(plant: plants[index]);
  }
}
