import 'package:shared_preferences/shared_preferences.dart';

class SettingRepository {
  static const String _darkModeKey = 'darkMode';

  final SharedPreferences _preferences;

  SettingRepository(this._preferences);

  Future<void> setDarkMode(bool isDarkMode) async {
    await _preferences.setBool(_darkModeKey, isDarkMode);
  }

  bool getDarkMode() {
    return _preferences.getBool(_darkModeKey) ?? false;
  }
}
