import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  static const String _themeKey = 'themeMode';

  ThemeProvider() {
    _loadThemeFromPreferences();
  }

  ThemeMode get themeMode => _themeMode;

  void toggleTheme(bool isDarkMode) {
    _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    _saveThemeToPreferences();
    notifyListeners();
  }

  void _saveThemeToPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(_themeKey, _themeMode == ThemeMode.dark);
  }

  void _loadThemeFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkMode = prefs.getBool(_themeKey) ?? false;
    _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
