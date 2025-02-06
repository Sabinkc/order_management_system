import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class LanguageProvider extends ChangeNotifier {
  String _selectedLanguage = "English"; // Default selection
  Locale _locale = Locale('en'); // Default locale

  String get selectedLanguage => _selectedLanguage;
  Locale get locale => _locale;

  // Function to change language and notify UI
  void setSelectedLanguage(String language) {
    _selectedLanguage = language;
    _locale = (language == "English") ? Locale('en') : Locale('ja');
    final Logger logger = Logger();
    logger.i(_selectedLanguage);
    notifyListeners(); // Notify UI to update
  }

  // Alternative function to toggle (not necessary if using setSelectedLanguage)
  void toggleLanguage() {
    _locale = (_locale.languageCode == 'en') ? Locale('ja') : Locale('en');
    notifyListeners();
  }
}
