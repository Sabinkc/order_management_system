// import 'package:flutter/material.dart';
// import 'package:order_management_system/features/login/data/api_service.dart';

// class AuthProvider with ChangeNotifier {
//   final ApiService _apiService = ApiService();
//   bool _isLoading = false;

//   bool get isLoading => _isLoading;

//   Future<String?> login({
//     required String email,
//     required String password,
//     required String deviceName,
//   }) async {
//     _isLoading = true;
//     notifyListeners();

//     final response = await _apiService.login(
//       email: email,
//       password: password,
//       deviceName: deviceName,
//     );

//     _isLoading = false;
//     notifyListeners();

//     if (response["success"]) {
//       return null; // Successful login
//     } else {
//       return response["error"]; // Error message
//     }
//   }
// }
