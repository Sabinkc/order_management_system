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
      final response = await http
          .patch(
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
          )
          .timeout(const Duration(seconds: 30));

      logger.log("Status code: ${response.statusCode}");
      logger.log("Response Body: ${response.body}");

      final jsonResponse = json.decode(response.body) as Map<String, dynamic>;
      logger.log("jsonResponse: $jsonResponse");

      if (response.statusCode == 200 && jsonResponse["success"] == true) {
        return; // Success case
      }

      // Handle API error responses
      final errorMessage = _parseErrorMessage(jsonResponse);
      throw errorMessage;
    } on FormatException {
      throw "Invalid server response";
    } on http.ClientException catch (e) {
      throw "Network error: ${e.message}";
    } catch (e) {
      logger.log("Unexpected error: $e");
      rethrow; // Preserve the original error
    }
  }

  String _parseErrorMessage(Map<String, dynamic> jsonResponse) {
    final message = jsonResponse["message"];

    if (message == null) return "Unknown error occurred";
    if (message is String) return message;
    if (message is Map<String, dynamic>) {
      final firstError = message.entries.firstWhere(
        (entry) => entry.value != null,
        orElse: () => const MapEntry('error', 'Unknown error'),
      );

      if (firstError.value is List) {
        return (firstError.value as List).first?.toString() ?? firstError.key;
      }
      return firstError.value?.toString() ?? firstError.key;
    }

    return "Failed to change password";
  }
}
