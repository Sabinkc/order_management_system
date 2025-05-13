import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefLoggedinState {
  static const isLoggedinKey = "isLoggedin";
  static const accessTokenkey = "accessToken";
  final logger = Logger();

  static Future<void> saveLoginState(
      bool isLoggedin, String accessToken) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(isLoggedinKey, isLoggedin);
    prefs.setString(accessTokenkey, accessToken);
  
  }

  static Future<bool> getLoginState() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isLoggedinKey) ?? false;
  }

  static Future<String?> getAccessToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(accessTokenkey);
  }

  static Future<void> clearLoginState() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(isLoggedinKey);
    prefs.remove(accessTokenkey);
  }


}
