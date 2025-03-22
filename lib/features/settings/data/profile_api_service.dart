import 'dart:convert';
import 'package:order_management_system/common/constants.dart';
import 'package:order_management_system/features/login/data/sharedpref_loginstate.dart';
import 'package:order_management_system/features/settings/data/profile_model.dart';
import 'dart:developer' as logger;
import 'package:http/http.dart' as http;

class ProfileApiService {
  Future<ProfileModel> getMyProfile() async {
    // Retrieve the access token
    String? token = await SharedPrefLoggedinState.getAccessToken();
    if (token == null) {
      throw "User not authenticated. Please login first.";
    }

    // Prepare headers for the request
    var headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    // Construct the URL for the profile endpoint
    var url = Uri.parse(Constants.getMyProfileUrl);
    var request = http.Request("GET", url);
    request.headers.addAll(headers);

    try {
      // Send the request and wait for the response
      http.StreamedResponse response = await request.send();
      String responseBody = await response.stream.bytesToString();
      logger.log("Status code: ${response.statusCode}");

      // Decode the JSON response
      Map<String, dynamic> jsonResponse = json.decode(responseBody);

      // Check if the request was successful
      if (response.statusCode == 200 && jsonResponse["success"] == true) {
        // Extract the profile data from the response
        Map<String, dynamic> profileJson = jsonResponse["profile"];

        // Map the JSON data to a ProfileModel object
        ProfileModel profile = ProfileModel(
          name: profileJson["name"] ?? "Unknown",
          email: profileJson["email"] ?? "N/A",
          emailVerified: profileJson["emailVerified"] ?? false,
          phone: profileJson["phone"] ?? "N/A",
          address: profileJson["address"] ?? "N/A",
          avatar: profileJson["avatar"] ?? "",
          gender: profileJson["gender"] ?? "N/A",
          createdAt: profileJson["createdAt"] ?? "N/A",
        );
        logger.log("profile data: $profile");
        return profile;
      } else {
        // Throw an error if the request was not successful
        throw "Failed to load profile. Status code: ${response.statusCode}";
      }
    } catch (e) {
      // Log and rethrow any errors that occur during the process
      logger.log("Error fetching profile: $e");
      throw "An error occurred while fetching the profile.";
    }
  }
}
