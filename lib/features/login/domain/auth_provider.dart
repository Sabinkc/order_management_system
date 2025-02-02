import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:order_management_system/features/login/data/auth_api_service.dart';
import 'package:order_management_system/features/login/domain/device_info_helper.dart';

class AuthProvider extends ChangeNotifier {
  final AuthApiService apiService = AuthApiService();
  bool isLoading = false;
  bool isLogoutLoading = false;
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

  Future logout() async {
    isLogoutLoading = true;
    notifyListeners();
    final logoutResponse = await apiService.logout();
    isLoading = false;
    notifyListeners();
    return logoutResponse;
  }
}
