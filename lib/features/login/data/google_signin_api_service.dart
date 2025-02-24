import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:order_management_system/common/common_color.dart';
import 'dart:developer' as logger;
import 'package:order_management_system/common/constants.dart';
import 'package:order_management_system/features/dashboard/presentation/screens/landing_screen.dart';
import 'package:order_management_system/features/login/data/sharedpref_loginstate.dart';
import 'package:order_management_system/features/login/domain/auth_provider.dart';
import 'package:order_management_system/features/login/domain/device_info_helper.dart';
import 'package:provider/provider.dart';

class GoogleSignInApiService {
  static final _googleSignIn = GoogleSignIn();
  static Future<GoogleSignInAccount?> login() async {
    try {
      var user = await _googleSignIn.signIn();
      return user;
    } catch (e) {
      return null;
    }
  }

  static Future<GoogleSignInAccount?> logout() async {
    try {
      var user = await _googleSignIn.disconnect();

      return user;
    } catch (e) {
      return null;
    }
  }

  Future signIn(BuildContext context) async {
    logger.log("Attempting to sign in with Google...");
    final user = await GoogleSignInApiService.login();
    if (user == null) {
      logger.log("Google Sign-In failed");
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: CommonColor.snackbarColor,
            content: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 10,
              children: [
                Icon(
                  Icons.warning_rounded,
                  color: CommonColor.whiteColor,
                  size: 30,
                ),
                Text(
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  "SignIn Failed!",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            )),
            duration: Duration(seconds: 1),
          ),
        );
      }
    } else {
      logger.log("Google Sign-In successful. User: ${user.displayName}");
      final GoogleSignInApiService googleSignInApiService =
          GoogleSignInApiService();

      // Call the backend API after successful Google Sign-In
      var result = await googleSignInApiService.loginWithGoogle(user);

      if (result["success"]) {
        logger.log("API Login successful. Navigating to DashboardScreen...");
        if (context.mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LandingScreen()),
          );
        }
      } else {
        logger.log("API Login failed: ${result["message"]}");
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: CommonColor.snackbarColor,
              content: Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 10,
                children: [
                  Icon(
                    Icons.warning_rounded,
                    color: CommonColor.whiteColor,
                    size: 30,
                  ),
                  Text(
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    "${result["message"]}",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              )),
              duration: Duration(seconds: 1),
            ),
          );
        }
      }
    }
  }

  Future logOut(BuildContext context) async {
    logger.log("Logging out...");
    await GoogleSignInApiService.logout();
    logger.log("Logout successful. Navigating back.");
  }

  Future<Map<String, dynamic>> loginWithGoogle(
      GoogleSignInAccount googleUser) async {
    try {
      logger.log("Preparing data for API call...");
      // Get user's details
      String email = googleUser.email;
      String displayName = googleUser.displayName ?? "Unknown User";
      String googleId = googleUser.id;
      String photoUrl = googleUser.photoUrl ??
          "https://static.vecteezy.com/system/resources/previews/005/544/718/original/profile-icon-design-free-vector.jpg";
      String device = await DeviceInfoHelper.getDeviceName();
      logger.log("Device: $device");

      // Define headers
      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };

      // Prepare request body
      var body = json.encode({
        "email": email,
        "displayName": displayName,
        "id": googleId,
        "photoUrl": photoUrl,
        "device": device
      });

      logger.log("Request Body: $body");

      // Send POST request
      var request = http.Request(
        'POST',
        Uri.parse(Constants.googleLoginUrl),
      );
      request.body = body;
      request.headers.addAll(headers);

      logger.log("Sending POST request to API...");
      http.StreamedResponse response = await request.send();
      String responseBody = await response.stream.bytesToString();

      // Log response status and body
      logger.log("Response Status Code: ${response.statusCode}");
      logger.log("Response Body: $responseBody");

      // Parse the response body
      Map<String, dynamic> jsonResponse = json.decode(responseBody);

      // Check response status and return accordingly
      if (response.statusCode == 200) {
        logger.log("API Login success");
        String? token = jsonResponse["accessToken"];

        if (token != null) {
          // ✅ Save login state and token
          await SharedPrefLoggedinState.saveLoginState(true, token);
          logger.log("Access Token Saved: $token");
        }

        return {"success": true, "data": jsonResponse};
      } else {
        logger.log("API Login failed: ${jsonResponse["message"]}");
        return {
          "success": false,
          "message": jsonResponse["message"] ?? "Login failed"
        };
      }
    } catch (e) {
      logger.log("Error occurred during API Login: $e");
      return {
        "success": false,
        "message": "Something went wrong. Please try again."
      };
    }
  }
}
