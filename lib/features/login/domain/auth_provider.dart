import 'package:flutter/material.dart';
import 'package:order_management_system/features/login/data/api_service.dart';
import 'package:order_management_system/features/login/domain/device_info_helper.dart';

class AuthProvider extends ChangeNotifier {
  final ApiService apiService = ApiService();
  bool isLoading = false;

  Future<bool> login(String email, String password) async {
    isLoading = true;
    notifyListeners();
    String device = await DeviceInfoHelper.getDeviceName();

    bool success = await apiService.login(email, password, device);

    isLoading = false;
    notifyListeners();

    return success;
  }
}
