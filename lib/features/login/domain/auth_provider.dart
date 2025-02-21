import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:order_management_system/features/login/data/auth_api_service.dart';
import 'package:order_management_system/features/login/data/google_signin_api_service.dart';
import 'package:order_management_system/features/login/domain/device_info_helper.dart';

class AuthProvider extends ChangeNotifier {
  final AuthApiService apiService = AuthApiService();
  final GoogleSignInApiService googleSignInApiService = GoogleSignInApiService();
  bool isLoading = false;
  bool isLogoutLoading = false;
  bool isSignupLoading = false;
  bool isLoginWithGoogleLoading = false;
  final logger = Logger();

  Future<Map<String, dynamic>> login(String email, String password) async {
    isLoading = true;
    notifyListeners();

    String device = await DeviceInfoHelper.getDeviceName();
    logger.i("Device: $device");

    final response = await apiService.login(email, password, device);

    isLoading = false;
    notifyListeners();

    return response; // Returning full response to handle errors in UI
  }

  Future<Map<String, dynamic>> signup(String name, String email, String password) async {
    isSignupLoading = true;
    notifyListeners();

    String device = await DeviceInfoHelper.getDeviceName();
    logger.i("Device: $device");

    final response = await apiService.signup(name, email, password, device);

    isSignupLoading = false;
    notifyListeners();

    return response; // Returning full response to handle errors in UI
  }


  Future<Map<String, dynamic>> loginWithGoogle(BuildContext context) async {
    isLoginWithGoogleLoading= true;
    notifyListeners();


    final response = await googleSignInApiService.signIn(context);

    isLoginWithGoogleLoading = false;
    notifyListeners();

    return response; // Returning full response to handle errors in UI
  }

  Future logout() async {
    isLogoutLoading = true;
    notifyListeners();
    final logoutResponse = await apiService.logout();
    isLoading = false;
    notifyListeners();
    return logoutResponse;
  }
}
