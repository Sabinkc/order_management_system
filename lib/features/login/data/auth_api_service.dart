import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:logger/logger.dart';
import 'package:order_management_system/common/constants.dart';

import 'package:order_management_system/features/login/data/sharedpref_loginstate.dart';

class AuthApiService {
  final logger = Logger();

  /// **Login Function**
  Future<Map<String, dynamic>> signup(
     String name, String email, String password, String device) async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    var request = http.Request('POST', Uri.parse(Constants.signupUrl));

    request.body = json.encode({
      "name":name,
      "email": email,
      "password": password,
      "device": device,
    });

    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();
      String responseBody = await response.stream.bytesToString();

      logger.i("Response Status Code: ${response.statusCode}");
      logger.i("Response Body: $responseBody");

      Map<String, dynamic> jsonResponse = json.decode(responseBody);
      logger.i("jsonResponse:$jsonResponse");

      if (response.statusCode == 200) {
        // Extract access token
        String? token = jsonResponse["accessToken"];

        if (token != null) {
          // ✅ Save login state and token
          await SharedPrefLoggedinState.saveLoginState(true, token);
          logger.i("Access Token Saved: $token");
        }

        return {"success": true, "data": jsonResponse};
      } else {
        return {
          "success": false,
          "message": jsonResponse["message"] ?? "Signup failed"
        };
      }
    } catch (e) {
      logger.e("Login Error: $e");
      return {
        "success": false,
        "message": "Something went wrong. Please try again."
      };
    }
  }
  
    Future<Map<String, dynamic>> login(
      String email, String password, String device) async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    var request = http.Request('POST', Uri.parse(Constants.loginUrl));

    request.body = json.encode({
      "email": email,
      "password": password,
      "device": device,
    });

    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();
      String responseBody = await response.stream.bytesToString();

      logger.i("Response Status Code: ${response.statusCode}");
      logger.i("Response Body: $responseBody");

      Map<String, dynamic> jsonResponse = json.decode(responseBody);
      logger.i("jsonResponse:$jsonResponse");

      if (response.statusCode == 200) {
        // Extract access token
        String? token = jsonResponse["accessToken"];

        if (token != null) {
          // ✅ Save login state and token
          await SharedPrefLoggedinState.saveLoginState(true, token);
          logger.i("Access Token Saved: $token");
        }

        return {"success": true, "data": jsonResponse};
      } else {
        return {
          "success": false,
          "message": jsonResponse["message"] ?? "Login failed"
        };
      }
    } catch (e) {
      logger.e("Login Error: $e");
      return {
        "success": false,
        "message": "Something went wrong. Please try again."
      };
    }
  }
  


  /// **Logout Function**
  Future<bool> logout() async {
    String? accessToken = await SharedPrefLoggedinState.getAccessToken();

    if (accessToken == null) {
      logger.i("No access token found. User might not be logged in.");
      return false;
    }

    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };

    var request = http.Request('POST', Uri.parse(Constants.logoutUrl));

    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();
      String responseBody = await response.stream.bytesToString();
      logger.i("Logout Response: $responseBody");

      if (response.statusCode == 204) {
        // ✅ Clear saved login state
        await SharedPrefLoggedinState.clearLoginState();
        logger.i("User logged out, token cleared.");
        return true;
      } else {
        logger.e("Logout failed with status: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      logger.e("Logout error: $e");
      return false;
    }
  }

  /// **Check if user is logged in**
  Future<bool> isUserLoggedIn() async {
    return await SharedPrefLoggedinState.getLoginState();
  }
}
