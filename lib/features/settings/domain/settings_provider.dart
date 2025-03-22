import 'package:flutter/material.dart';
import 'package:order_management_system/features/settings/data/profile_api_service.dart';
import 'package:order_management_system/features/settings/data/profile_model.dart';
import 'dart:developer' as logger;

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

  void switchPushNotification() {
    notficationSwitchState = !notficationSwitchState;
    notifyListeners();
  }

  //provider to switch language
  bool languageState = false;
  void switchLanguageState() {
    languageState = !languageState;
    notifyListeners();
  }

//profile Provider
  bool isGetProfileLoading = false;
  ProfileModel profile = ProfileModel(
      name: "",
      email: "",
      emailVerified: true,
      phone: "",
      address: "",
      avatar: "",
      gender: "",
      createdAt: "");
  final profileApiService = ProfileApiService();
  Future getProfile() async {
    isGetProfileLoading = true;
    notifyListeners();
    try {
      final response = await profileApiService.getMyProfile();
      profile = response;
    } catch (e) {
      throw "$e";
    } finally {
      isGetProfileLoading = false;
      notifyListeners();
      logger.log("locations: $profile");
    }
  }
}
