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

    var request = http.Request('GET', url);
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      // logger.log("Response Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        // Getting image data as bytes
        
        // return success;
      } else {
        throw Exception('Failed to send OTP');
      }
    } catch (e) {
      logger.log("Send OTP Error: $e");
      throw Exception('Failed to send OTP');
    }
  }
}