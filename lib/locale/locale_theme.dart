import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static SharedPreferences? _preferences;

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static bool? getBool(String key) {
    return _preferences?.getBool(key);
  }

  static Future<void> setBool(String key, bool value) async {
    await _preferences?.setBool(key, value);
  }
}
