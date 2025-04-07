import 'dart:convert';

import 'package:order_management_system/common/constants.dart';
import 'package:order_management_system/features/login/data/sharedpref_loginstate.dart';
import 'dart:developer' as logger;
import 'package:http/http.dart' as http;

class PasswordApiService {
  Future<void> changePassword(String oldPassword, String newPassword) async {
    String? token = await SharedPrefLoggedinState.getAccessToken();

    if (token == null) {
      throw "User not authenticated. Please login first.";
    }

    var url = Uri.parse(Constants.changePasswordUrl);

    try {
      // Use http.post or http.patch instead of http.Request
      var response = await http.patch(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
        body: json.encode({
          "password": newPassword,
          "oldPassword": oldPassword,
        }),
      );

      logger.log("Status code: ${response.statusCode}");
      logger.log("Response Body: ${response.body}");

      Map<String, dynamic> jsonResponse = json.decode(response.body);
      logger.log("jsonResponse: $jsonResponse");

      if (response.statusCode == 200 && jsonResponse["success"] == true) {
        logger.log("Password changed successfully");
        return;
      } else {
        String errorMessage = jsonResponse["message"]?.toString() ??
            "Failed to change password. Status code: ${response.statusCode}";
        logger.log(errorMessage);
        throw errorMessage;
      }
    } catch (e) {
      logger.log("Error changing password: $e");
      throw "$e";
    }
  }
}
