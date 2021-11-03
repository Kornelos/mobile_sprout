import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mobile_sprout/screens/NavigationScreen.dart';

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
    PlatformApp(home: NavigationScreen()),
  );
}
