import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_sprout/providers/settings_provider.dart';
import 'package:mobile_sprout/utils/sprout_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test('Should start with light theme initial value', () {
    //given
    SharedPreferences.setMockInitialValues({});
    SettingsProvider provider = SettingsProvider();

    //when
    ThemeData theme = provider.getTheme();

    //then
    expect(SproutTheme.light(), theme);
  });
  test('Should set theme persisted in shared preferences', () async {
    //given
    SharedPreferences.setMockInitialValues({SettingsProvider.isDarkKey: false});
    SharedPreferences pref = await SharedPreferences.getInstance();

    //when
    expect(pref.getBool(SettingsProvider.isDarkKey), false);
    SettingsProvider provider = SettingsProvider();

    //then
    ThemeData theme = provider.getTheme();
    expect(SproutTheme.light(), theme);
  });
}
