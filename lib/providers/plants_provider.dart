import 'package:flutter/widgets.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobile_sprout/model/plant.dart';

class PlantsProvider extends ChangeNotifier {
  static PlantInfo _info = PlantInfo(
    "Cabbage",
    "crops",
    "Brassica oleracea",
    "Cabbage is a member of the Brassica family and related to kale, broccoli, brussels sprouts, and cauliflower. It's dense, layered heads grow on stalks and are surrounded by looser outer leaves. It's leaves can be green, white, or purple in color, and smooth or crinkly in texture. Depending on the variety, the head can be round, oblong, or flat. Cabbage prefers cooler temperatures and is best planted in the spring or fall.",
    "Full Sun",
    "Direct seed indoors, transplant seedlings outside after hardening off.",
    "https://s3.amazonaws.com/openfarm-project/production/media/pictures/attachments/5928732ef9f0b200040000c0.jpg?1495823146",
  );
  static const String PLANTS_KEY = "plants";

  List<Plant> _plants = [
    Plant.withPlaceholderImage("Living Room plant", _info),
    Plant.withPlaceholderImage("Kitchen plant", _info),
    Plant.withPlaceholderImage("My favourite plant", _info),
  ];

  final Box _box;

  PlantsProvider(this._box){
    _plants = _box.get(PLANTS_KEY) != null ? (_box.get(PLANTS_KEY) as List).map((e) => e as Plant).toList()  : _plants;
  }

  List<Plant> getPlants() => _plants;

  Plant? getPlantNamed(String name) {
    var maybePlant = _plants.where((element) => element.nickname == name);
    return maybePlant.isNotEmpty ? maybePlant.first : null;
  }

  void addPlant(Plant plant) {
    _plants.add(plant);
    _persistPlants();
    notifyListeners();
  }

  void updatePlant(Plant original, Plant modified) {
    _plants.remove(original);
    addPlant(modified);
    _persistPlants();
  }

  void deletePlant(Plant plant) {
    _plants.remove(plant);
    _persistPlants();
    notifyListeners();
  }

  void renamePlant(Plant plant, String newName) {
    _plants.remove(plant);
    _plants.add(plant.createRenamed(newName));
    _persistPlants();
    notifyListeners();
  }

  bool plantNamedExists(String name) {
    return _plants.where((element) => element.nickname == name).isNotEmpty;
  }

  void _persistPlants(){
    _box.put(PLANTS_KEY, _plants);
  }
}
