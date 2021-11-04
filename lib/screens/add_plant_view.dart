import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mobile_sprout/utils/sprout_theme.dart';

class AddPlantView extends StatelessWidget {
  const AddPlantView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = SproutTheme.dark();
    return PlatformScaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: PlatformAppBar(
          backgroundColor: theme.appBarTheme.backgroundColor,
        ),
        body: Center(
            child: Text("add plant view", style: theme.textTheme.headline6)));
  }
}
