import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  //provider to add profile data
  String userName = "John Doe";
  String userEmail = "johndoe@gmail.com";

  void addProfileData(String name, String email) {
    userName = name;
    userEmail = email;
    notifyListeners();
  }

  //provider to switch push notification
  bool notficationSwitchState = true;

  void switchPushNotification(){
    notficationSwitchState = !notficationSwitchState;
    notifyListeners();
  }

  //provider to switch language
  bool languageState = false;
  void switchLanguageState(){
    languageState = !languageState;
    notifyListeners();
  }
}
