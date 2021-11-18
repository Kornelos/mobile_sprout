import 'package:flutter/material.dart';
import 'package:mobile_sprout/providers/settings_provider.dart';
import 'package:mobile_sprout/screens/navigation_screen.dart';
import 'package:mobile_sprout/utils/sprout_theme.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  // WidgetsFlutterBinding.ensureInitialized();
  //
  // // Obtain a list of the available cameras on the device.
  // final cameras = await availableCameras();
  //
  // // Get a specific camera from the list of available cameras.
  // final firstCamera = cameras.first;

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
          )
        ],
        child: MaterialApp(
          home: NavigationScreen(),
          //theme: SproutTheme.light(),
        ));
  }
}
