import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile_sprout/providers/settings_provider.dart';
import 'package:provider/provider.dart';

class TasksView extends StatelessWidget {
  const TasksView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData _theme = Provider.of<SettingsProvider>(context).getTheme();

    return Container(
        color: _theme.scaffoldBackgroundColor,
        child: Text(
          "tasks list view",
          style: _theme.textTheme.headline6,
        ));
  }
}
