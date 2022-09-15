import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'dark.theme.dart';
import 'light.theme.dart';

class AppThemes {
  static final light = lightTheme;
  static ThemeData dark = darkTheme;

  final _storage = GetStorage();
  final themeKey = "isDarkMode";

  ThemeMode getThemeMode() {
    return isDarkModeSaved() ? ThemeMode.dark : ThemeMode.light;
  }

  bool isDarkModeSaved() {
    return _storage.read(themeKey) ?? false;
  }

  void saveThemeMode({required bool isDarkMode}) {
    _storage.write(themeKey, isDarkMode);
  }

  void changeThemeMode() {
    Get.changeThemeMode(isDarkModeSaved() ? ThemeMode.light : ThemeMode.dark);
    saveThemeMode(isDarkMode: !isDarkModeSaved());
  }
}
