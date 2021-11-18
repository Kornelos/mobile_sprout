import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile_sprout/providers/settings_provider.dart';
import 'package:mobile_sprout/screens/add_plant_view.dart';
import 'package:mobile_sprout/screens/profile_view.dart';
import 'package:mobile_sprout/screens/tasks_view.dart';
import 'package:provider/provider.dart';

import 'plant_list_view.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selectedIndex = 0;
  static const List<Widget> _presentedWidgets = [
    PlantListView(),
    TasksView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    ThemeData _theme = Provider.of<SettingsProvider>(context).getTheme();
    return Scaffold(
      backgroundColor: _theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: _theme.appBarTheme.backgroundColor,
      ),
      body: Center(
        child: _presentedWidgets.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: _theme.bottomAppBarColor,
        selectedItemColor: Colors.lightGreen[800],
        unselectedItemColor: Colors.lightGreen,
        items: [
          //todo: items colors in dark mode
          BottomNavigationBarItem(
              label: 'Your plants', icon: const Icon(Icons.list)),
          BottomNavigationBarItem(label: 'Tasks', icon: const Icon(Icons.task)),
          BottomNavigationBarItem(
              label: 'Profile & Settings', icon: const Icon(Icons.person)),
        ],
        currentIndex: _selectedIndex,
        onTap: (idx) => setState(() {
          _selectedIndex = idx;
        }),
      ),
    );
  }
}
