import 'package:shared_preferences/shared_preferences.dart';

class SettingsLocalDataSource {
  static const String darkKey = 'isDark';

  Future<bool> getIsDark() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(darkKey) ?? false;
  }

  Future<void> saveIsDark(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(darkKey, value);
  }
}
