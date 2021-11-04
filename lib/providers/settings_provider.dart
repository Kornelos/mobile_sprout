import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_sprout/utils/sprout_theme.dart';

class SettingsProvider extends ChangeNotifier {
  ThemeData _appTheme = SproutTheme.light();

  void changeTheme() {
    if (isDarkTheme()) {
      _appTheme = SproutTheme.light();
    } else {
      _appTheme = SproutTheme.dark();
    }
    notifyListeners();
  }

  bool isDarkTheme() {
    return _appTheme == SproutTheme.dark();
  }

  ThemeData getTheme() => _appTheme;
}
