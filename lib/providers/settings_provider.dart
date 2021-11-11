import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_sprout/utils/sprout_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  static final String isDarkKey = "IS_DARK";
  ThemeData _appTheme = SproutTheme.light();

  SettingsProvider._internal(this._appTheme);

  factory SettingsProvider() {
    SettingsProvider provider = SettingsProvider._internal(SproutTheme.light());
    provider._setThemeOrDefault();
    return provider;
  }

  void changeTheme() {
    if (_appTheme == SproutTheme.dark()) {
      _appTheme = SproutTheme.light();
    } else {
      _appTheme = SproutTheme.dark();
    }
    _persistChange();
    notifyListeners();
  }

  Future<void> _persistChange() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (isDarkTheme()) {
      prefs.setBool(isDarkKey, true);
    } else {
      prefs.setBool(isDarkKey, false);
    }
  }

  bool isDarkTheme() {
    return _appTheme == SproutTheme.dark();
  }

  ThemeData getTheme() {
    return _appTheme;
  }

  void _setThemeOrDefault() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(isDarkKey) && prefs.getBool(isDarkKey) != null) {
      _appTheme =
          prefs.getBool(isDarkKey)! ? SproutTheme.dark() : SproutTheme.light();
    } else {
      // defaults to light
      _appTheme = SproutTheme.light();
    }
    notifyListeners();
  }
}
