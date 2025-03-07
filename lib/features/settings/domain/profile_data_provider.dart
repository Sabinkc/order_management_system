import 'package:flutter/material.dart';

class ProfileDataProvider extends ChangeNotifier {
  String userName = "John Doe";
  String userEmail = "johndoe@gmail.com";

  void addProfileData(String name, String email) {
    userName = name;
    userEmail = email;
    notifyListeners();
  }
}
