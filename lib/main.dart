import 'package:flutter/material.dart';
import 'package:mobile_sprout/providers/humidity_provider.dart';
import 'package:mobile_sprout/providers/tasks_provider.dart';
import 'package:mobile_sprout/providers/plants_provider.dart';
import 'package:mobile_sprout/providers/settings_provider.dart';
import 'package:mobile_sprout/providers/user_provider.dart';
import 'package:mobile_sprout/screens/navigation_screen.dart';
import 'package:mobile_sprout/screens/sign_in_view.dart';
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
            value: TasksProvider(),
          ),
          ChangeNotifierProvider.value(
            value: PlantsProvider(),
          ),
          ChangeNotifierProvider.value(value: UserProvider()),
        ],
        child: MaterialApp(
          home: LoginOrNavigation(),
          //theme: SproutTheme.light(),
        ));
  }
}

class LoginOrNavigation extends StatelessWidget {
  const LoginOrNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData _theme = Provider.of<SettingsProvider>(context).getTheme();
    UserProvider userProvider = Provider.of<UserProvider>(context);

    return userProvider.getUser() == null ? SignInView() : NavigationScreen();
  }
}
