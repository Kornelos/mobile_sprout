import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobile_sprout/model/plant.dart';
import 'package:mobile_sprout/model/task.dart';

class HiveConfig {
  // can't use enum for this as it must be compile-time const
  static const int PLANT = 1;
  static const int PLANT_INFO = 2;
  static const TASK = 3;
  static const TASK_TYPE = 4;

  static void registerHiveAdapters() {
    Hive.registerAdapter(PlantAdapter());
    Hive.registerAdapter(PlantInfoAdapter());
    Hive.registerAdapter(TaskAdapter());
    Hive.registerAdapter(TaskTypeAdapter());
  }
}
