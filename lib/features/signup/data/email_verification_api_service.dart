import 'dart:convert';

import 'package:order_management_system/common/constants.dart';
import 'package:order_management_system/features/login/data/sharedpref_loginstate.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as logger;

class EmailVerificationApiService {
  Future sendEmailOtp() async {
    // Get the saved token from SharedPreferences
    String? token = await SharedPrefLoggedinState.getAccessToken();

    // If no token is found, return an error
    if (token == null) {
      throw Exception("User not authenticated. Please log in first.");
    }

    // Headers with Authorization token
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token', // Adding token in the header
    };

    // Constructing the URL to fetch image by filename
    var url = Uri.parse(Constants.resendEmailVerificationUrl);

    var request = http.Request('POST', url);
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      logger.log("Response Status Code: ${response.statusCode}");
      // final responeBody = jsonDecode(response.toString());
      // logger.log("$responeBody");

      if (response.statusCode == 200) {
        // Getting image data as bytes

        logger.log("OTP sent");
      } else {
        throw "Failed to send OTP";
      }
    } catch (e) {
      logger.log("Send OTP Error: $e");
      throw "Failed to send OTP";
    }
  }

  // Future verifyEmail(String otp) async {
  //   logger.log("email service Otp: $otp");
  //   // Get the saved token from SharedPreferences
  //   String? token = await SharedPrefLoggedinState.getAccessToken();

  //   // If no token is found, return an error
  //   if (token == null) {
  //     throw Exception("User not authenticated. Please log in first.");
  //   }

  //   // Headers with Authorization token
  //   var headers = {
  //     'Accept': 'application/json',
  //     'Authorization': 'Bearer $token', // Adding token in the header
  //   };

  //   // Constructing the URL to fetch image by filename
  //   var url = Uri.parse(Constants.verifyEmailUrl);

  //   var request = http.Request('POST', url);
  //   request.body = json.encode({
  //     "otp": otp,
  //   });
  //   request.headers.addAll(headers);

  //   try {
  //     http.StreamedResponse response = await request.send();

  //     logger.log("Response Status Code: ${response.statusCode}");

  //     final responseBody = await response.stream.bytesToString();
  //     logger.log("Response Body: $responseBody");
  //     final jsonResponse = jsonDecode(responseBody);

  //     if (response.statusCode == 200) {
  //       logger.log("Email Verified");

  //       return jsonResponse;
  //       // Getting image data as bytes
  //     } else {
  //       logger.log("Email verification failed:");
  //       return jsonResponse;
  //     }
  //   } catch (e) {
  //     logger.log("Email verification Error: $e");
  //     throw "Failed to verify email";
  //   }
  // }

  Future<Map<String, dynamic>> verifyEmail(String otp) async {
    logger.log("email service Otp: $otp");

    String? token = await SharedPrefLoggedinState.getAccessToken();
    if (token == null) {
      throw Exception("User not authenticated. Please log in first.");
    }

    // Ensure headers include Content-Type
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json', // ← REQUIRED for JSON APIs
      'Authorization': 'Bearer $token',
    };

    var url = Uri.parse(Constants.verifyEmailUrl);

    try {
      // Use http.post instead of http.Request for simpler debugging
      final response = await http.post(
        url,
        headers: headers,
        body: json.encode({
          "otp": otp.trim(), // Trim whitespace (in case of invisible chars)
        }),
      );

      logger.log("Response Status: ${response.statusCode}");
      logger.log("Response Body: ${response.body}");

      final jsonResponse = json.decode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200) {
        return {"success": true, "message": "Email verified Successfully!"};
      } else {
        // Forward the server's error message
        return {
          "success": false,
          "message": jsonResponse["message"] ?? "Failed to verify email",
        };
      }
    } catch (e) {
      logger.log("Email verification Error: $e");
      return {
        "success": false,
        "message": "Network error. Please try again.",
      };
    }
  }
}
