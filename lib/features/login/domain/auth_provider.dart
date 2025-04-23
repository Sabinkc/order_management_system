import 'package:flutter/material.dart';
import 'dart:developer' as logger;
import 'package:order_management_system/features/login/data/auth_api_service.dart';
import 'package:order_management_system/features/login/data/google_signin_api_service.dart';
import 'package:order_management_system/features/login/domain/device_info_helper.dart';
import 'package:order_management_system/features/signup/data/email_verification_api_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthApiService apiService = AuthApiService();
  final GoogleSignInApiService googleSignInApiService =
      GoogleSignInApiService();
  bool isLoading = false;
  bool isLogoutLoading = false;
  bool isSignupLoading = false;
  bool isLoginWithGoogleLoading = false;
  // final logger = Logger();

  Future<Map<String, dynamic>> login(String email, String password) async {
    isLoading = true;
    notifyListeners();
    String device = await DeviceInfoHelper.getDeviceName();
    logger.log("Device: $device");
    final response = await apiService.login(email, password, device);
    isLoading = false;
    notifyListeners();
    return response; // Returning full response to handle errors in UI
  }

  Future<Map<String, dynamic>> signup(
      String name, String email, String password) async {
    isSignupLoading = true;
    notifyListeners();
    String device = await DeviceInfoHelper.getDeviceName();
    logger.log("Device: $device");
    final response = await apiService.signup(name, email, password, device);
    isSignupLoading = false;
    notifyListeners();
    return response; // Returning full response to handle errors in UI
  }

  Future loginWithGoogle(BuildContext context) async {
    isLoginWithGoogleLoading = true;
    notifyListeners();
    await googleSignInApiService.signIn(context);
    isLoginWithGoogleLoading = false;
    notifyListeners();

    // Returning full response to handle errors in UI
  }

  Future logout() async {
    isLogoutLoading = true;
    notifyListeners();
    final logoutResponse = await apiService.logout();
    isLoading = false;
    notifyListeners();
    return logoutResponse;
  }

  final EmailVerificationApiService emailVerificationApiService =
      EmailVerificationApiService();
  bool isSendOtpLoading = false;
  Future sendOtp() async {
    isSendOtpLoading = true;
    notifyListeners();
    try {
      await emailVerificationApiService.sendEmailOtp();
    } catch (e) {
      rethrow;
    } finally {
      isSendOtpLoading = false;
      notifyListeners();
    }
  }

  bool isVerifyEmailLoading = false;
  Future verifyEmail(String otp) async {
    isVerifyEmailLoading = true;
    notifyListeners();
    try {
      final response = await emailVerificationApiService.verifyEmail(otp);
      // logger.log("authprovider response: $response");
      return response;
    } catch (e) {
      logger.log("auth error: $e");
      rethrow;
    } finally {
      isVerifyEmailLoading = false;
      notifyListeners();
    }
  }
}
