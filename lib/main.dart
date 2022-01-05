import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobile_sprout/model/plant.dart';
import 'package:mobile_sprout/providers/humidity_provider.dart';
import 'package:mobile_sprout/providers/tasks_provider.dart';
import 'package:mobile_sprout/providers/plants_provider.dart';
import 'package:mobile_sprout/providers/settings_provider.dart';
import 'package:mobile_sprout/screens/navigation_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await Hive.initFlutter();
  _registerHiveAdapters();
  Box box = await Hive.openBox("inMemory");
  runApp(
    SproutApp(box: box),
  );
}

void _registerHiveAdapters() {
  Hive.registerAdapter(PlantAdapter());
  Hive.registerAdapter(PlantInfoAdapter());
}

class SproutApp extends StatelessWidget {
  final Box box;
  const SproutApp( {Key? key, required this.box}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: SettingsProvider(),
          ),
          ChangeNotifierProvider.value(
            value: HumidityProvider(),
          ),
          ChangeNotifierProvider.value(
            value: TasksProvider(box),
          ),
          ChangeNotifierProvider.value(
            value: PlantsProvider(box),
          )
        ],
        child: MaterialApp(
          home: NavigationScreen(),
          //theme: SproutTheme.light(),
        ));
  }
}
