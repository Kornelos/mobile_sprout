import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mobile_sprout/providers/settings_provider.dart';
import 'package:provider/provider.dart';

class AddPlantView extends StatelessWidget {
  const AddPlantView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData _theme = Provider.of<SettingsProvider>(context).getTheme();
    return PlatformScaffold(
        backgroundColor: _theme.scaffoldBackgroundColor,
        appBar: PlatformAppBar(
          backgroundColor: _theme.appBarTheme.backgroundColor,
        ),
        body: Center(
            child: Text("add plant view", style: _theme.textTheme.headline6)));
  }
}
