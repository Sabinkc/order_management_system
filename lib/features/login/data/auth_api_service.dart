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
      "name": name,
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

  Future forgetPasswordOtp(String email) async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    var request =
        http.Request('POST', Uri.parse(Constants.forgetPasswordOtpUrl));

    request.body = json.encode({
      "email": email,
    });

    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();
      String responseBody = await response.stream.bytesToString();

      logger.i("Response Status Code: ${response.statusCode}");
      logger.i("Response Body: $responseBody");

      Map<String, dynamic> jsonResponse = json.decode(responseBody);
      logger.i("jsonResponse:$jsonResponse");

      if (response.statusCode == 201) {
        return {"success": true, "data": jsonResponse};
      } else {
        return {
          "success": false,
          "message": jsonResponse["message"] ?? "Sending OTP failed"
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

  Future checkForgetPassResetCode(String email, String otp) async {
    logger.i("passed email: $email, passed otp: $otp");
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    var request =
        http.Request('POST', Uri.parse(Constants.forgetPasswordCheckCodeUrl));

    request.body = json.encode({
      "email": email,
      "otp": otp,
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
        return {"success": true, "data": jsonResponse};
      } else {
        return {
          "success": false,
          "message": jsonResponse["message"] ?? "Check OTP failed"
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

    Future resetForgettenPassword(String email, String otp, String newPassword) async {
    // logger.i("passed email: $email, passed otp: $otp");
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    var request =
        http.Request('POST', Uri.parse(Constants.resetForgotternPassUrl));

    request.body = json.encode({
      "email": email,
      "password": newPassword,
      "otp": otp,
      
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
        return {"success": true, "data": jsonResponse};
      } else {
        return {
          "success": false,
          "message": jsonResponse["message"] ?? "Reset password failed"
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

  
  Future deleteMyAccount() async {
    String? token = await SharedPrefLoggedinState.getAccessToken();

    if (token == null) {
      throw "User not authenticated. Please login first.";
    }

    var headers = {
      "Authorization": "Bearer $token",
    };

    var url = Uri.parse(Constants.deleteMyAccountUrl);

    try {
      var response = await http.delete(url, headers: headers);
logger.i("delete account status code: ${response.statusCode}");
      if (response.statusCode == 200) {
        return true;
      } else {
        throw "Failed to delete account";
      }
    } catch (e) {
      logger.i("Error deleting account: $e");
      throw "$e";
    }
  }
}
