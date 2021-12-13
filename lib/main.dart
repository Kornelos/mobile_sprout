import 'package:flutter/material.dart';
import 'package:mobile_sprout/providers/humidity_provider.dart';
import 'package:mobile_sprout/providers/plants_provider.dart';
import 'package:mobile_sprout/providers/settings_provider.dart';
import 'package:mobile_sprout/screens/navigation_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  runApp(
    SproutApp(),
  );
}

class SproutApp extends StatelessWidget {
  const SproutApp({Key? key}) : super(key: key);

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
            value: PlantsProvider(),
          )
        ],
        child: MaterialApp(
          home: NavigationScreen(),
          //theme: SproutTheme.light(),
        ));
  }
}
