import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mobile_sprout/screens/AddPlantView.dart';
import 'package:mobile_sprout/screens/TasksView.dart';

import 'PlantListView.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selectedIndex = 0;
  static const List<Widget> _presentedWidgets = [
    PlantListView(),
    AddPlantView(),
    TasksView(),
  ];

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(),
      body: Center(
        child: _presentedWidgets.elementAt(_selectedIndex),
      ),
      bottomNavBar: PlatformNavBar(
        items: [
          BottomNavigationBarItem(
              label: 'Your plants', icon: const Icon(Icons.list)),
          BottomNavigationBarItem(
              label: 'Add plant', icon: const Icon(Icons.add)),
          BottomNavigationBarItem(
              label: 'Tasks', icon: const Icon(Icons.task)),
        ],
        currentIndex: _selectedIndex,
        itemChanged: (idx) => setState(() {
          _selectedIndex = idx;
        }),
      ),
    );
  }
}
