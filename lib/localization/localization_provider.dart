import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationProvider extends ChangeNotifier {
  Locale _locale = Locale('en');

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    if (locale == _locale) return;

    _locale = locale;
    saveLocale(locale);
    Get.updateLocale(locale);
    notifyListeners();
  }

  init() {
    getLocale().then((value) {
      _locale = value;
      Get.updateLocale(_locale);
      notifyListeners();
    });
  }

  saveLocale(Locale locale) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('language', locale.languageCode);
  }

  Future<Locale> getLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String languageCode = prefs.getString('language') ?? 'en';
    return Locale(languageCode);
  }
}
