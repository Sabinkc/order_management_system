import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:order_management_system/features/settings/data/information_model.dart';
import 'package:order_management_system/features/settings/data/information_api_service.dart';
import 'package:order_management_system/features/settings/data/password_api_service.dart';
import 'package:order_management_system/features/settings/data/profile_api_service.dart';
import 'package:order_management_system/features/settings/data/profile_model.dart';
import 'package:order_management_system/features/settings/data/push_notification_shared_pref.dart';
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
  bool notficationSwitchState = false;

  Future<void> initializeNotificationState() async {
    notficationSwitchState =
        await PushNotificationSharedPref.getNotificationOptIn();
    notifyListeners();
  }

  void switchPushNotification(bool value) {
    notficationSwitchState = value;
    notifyListeners();
  }

  //provider to switch language
  bool languageState = false;
  void switchLanguageState() {
    languageState = !languageState;
    notifyListeners();
  }

  //provider to hande gender dropdon

  String selectedGender = "N/A";

  void switchSelectedGender(String gender) {
    selectedGender = gender;
    notifyListeners();
  }

  void resetSelectedGender() {
    selectedGender = profile.gender;
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
      // logger.log("profile: $profile");
    }
  }

  bool isUpdateProfileLoading = false;
  Future updateProfile(BuildContext context, String name, String email,
      String phone, String gender, String address) async {
    isUpdateProfileLoading = true;
    notifyListeners();
    try {
      await profileApiService.updateProfile(
        context: context,
        currentProfile: profile,
        name: name,
        email: email,
        phone: phone,
        gender: gender,
        address: address,
      );
    } catch (e) {
      throw "$e";
    } finally {
      isUpdateProfileLoading = false;
      notifyListeners();
      // logger.log("profile: $profile");
    }
  }

//provider to create avatar
  bool isUpdateAvatarLoading = false;
  File? selectedAvatar;

  Future<void> updateProfileAvatar(File imageFile) async {
    isUpdateAvatarLoading = true;
    selectedAvatar = imageFile;
    notifyListeners();

    try {
      await profileApiService.updateProfileAvatar(imageFile: imageFile);
      // Optionally update the profile data in your provider if needed
      notifyListeners();
    } catch (e) {
      selectedAvatar = null; // Reset on failure
      notifyListeners();
      rethrow; // Preserve the original error stack
    } finally {
      isUpdateAvatarLoading = false;
      notifyListeners();
    }
  }

  Uint8List? avatarBytes;

// Uint8List? get avatarBytes => _avatarBytes;
  bool isAvatarLoading = false;
  Future<void> loadProfileAvatar() async {
    isAvatarLoading = true;
    notifyListeners();
    try {
      avatarBytes = await profileApiService.getProfileAvatar();
    } catch (e) {
      avatarBytes = null;
      rethrow; // Re-throw to handle in UI
    } finally {
      isAvatarLoading = false;
      notifyListeners();
    }
  }

  bool isDeleteAvatarLoading = false;
  Future removeAvatar() async {
    isDeleteAvatarLoading = true;
    notifyListeners();
    try {
      await profileApiService.removeMyAvatar();
      avatarBytes = null;
      notifyListeners();
    } catch (e) {
      rethrow;
    } finally {
      isDeleteAvatarLoading = false;
      notifyListeners();
    }
  }

  PasswordApiService passswordApiService = PasswordApiService();
  //provider to change password
  bool isPasswordResetting = false;
  Future changePassword(String oldPassword, String newPassword) async {
    isPasswordResetting = true;
    notifyListeners();
    try {
      await passswordApiService.changePassword(oldPassword, newPassword);
      notifyListeners();
    } catch (e) {
      rethrow;
    } finally {
      isPasswordResetting = false;
      notifyListeners();
    }
  }

  // Add this in your provider or settings model
  bool _receiveNotifications = true;

  bool get receiveNotifications => _receiveNotifications;

  void toggleNotificationPermission(bool value) {
    _receiveNotifications = value;
    notifyListeners();
  }

  bool isFaqLoading = false;
  List<FaqModel> faqs = [];
  final informationApiService = InformationApiService();

  Future fetchFaq() async {
    isFaqLoading = true;
    notifyListeners();

    try {
      final response = await informationApiService.getFaq();
      faqs = response;
      logger.log("faqs: $faqs");
    } catch (e) {
      logger.log("$e");
      throw "$e";
    } finally {
      isFaqLoading = false;
      notifyListeners();
    }
  }

  bool isPolicyLoading = false;
  List<PrivacyPolicyModel> privacyPolicies = [];

  Future fetchPolicies() async {
    isPolicyLoading = true;
    notifyListeners();

    try {
      final response = await informationApiService.getPrivacyPolicy();
      privacyPolicies = response;
      logger.log("privacy Policies: $privacyPolicies");
    } catch (e) {
      // logger.log("$e");
      throw "$e";
    } finally {
      isPolicyLoading = false;
      notifyListeners();
    }
  }

  bool isTermsLoading = false;
  List<TermsOfConditionModel> termsAndConditions = [];

  Future fetchTermsAndConditions() async {
    isTermsLoading = true;
    notifyListeners();

    try {
      final response = await informationApiService.getTermsAndConditions();
      termsAndConditions = response;
      logger.log("Terms & Conditions: $termsAndConditions");
    } catch (e) {
      // logger.log("$e");
      throw "$e";
    } finally {
      isTermsLoading = false;
      notifyListeners();
    }
  }

  bool isContactsLoading = false;
  List<ContactAndSupportModel> contacts = [];

  Future fetchContacts() async {
    isContactsLoading = true;
    notifyListeners();

    try {
      final response = await informationApiService.getContact();
      contacts = response;
      logger.log("Contacts: $contacts");
    } catch (e) {
      // logger.log("$e");
      throw "$e";
    } finally {
      isContactsLoading = false;
      notifyListeners();
    }
  }
}
