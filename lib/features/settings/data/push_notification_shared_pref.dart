import 'package:shared_preferences/shared_preferences.dart';

class PushNotificationSharedPref {
  static Future<void> setNotificationOptIn(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notifications_enabled', value); // ✅ Ensure this key
  }

  static Future<bool> getNotificationOptIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('notifications_enabled') ?? false;
  }
}
