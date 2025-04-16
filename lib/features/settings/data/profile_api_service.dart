import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
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
      // logger.log("Status code: ${response.statusCode}");

      // Decode the JSON response
      Map<String, dynamic> jsonResponse = json.decode(responseBody);

      // Check if the request was successful
      if (response.statusCode == 200 && jsonResponse["success"] == true) {
        // Extract the profile data from the response
        Map<String, dynamic> profileJson = jsonResponse["profile"];

        // Map the JSON data to a ProfileModel object
        ProfileModel profile = ProfileModel(
          name: profileJson["name"] ?? "Unknown",
          email: profileJson["email"] ?? "Email not set",
          emailVerified: profileJson["emailVerified"] ?? false,
          phone: profileJson["phone"] ?? "",
          address: profileJson["address"] ?? "",
          avatar: profileJson["avatar"] ?? "",
          gender: profileJson["gender"] ?? "N/A",
          createdAt: profileJson["createdAt"] ?? "N/A",
        );
        // logger.log("profile data: $profile");
        logger.log("get profile api called");
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

  Future<void> updateProfile({
    required BuildContext context,
    required ProfileModel currentProfile,
    String? name,
    String? email,
    String? phone,
    String? gender,
    String? address,
  }) async {
    Map<String, dynamic> changedFields = {};

    if (name != null && name != currentProfile.name) {
      changedFields['name'] = name;
    }
    if (email != null && email != currentProfile.email) {
      changedFields['email'] = email;
    }
    if (phone != null && phone != currentProfile.phone) {
      changedFields['phone'] = phone;
    }
    if (gender != null && gender != currentProfile.gender) {
      changedFields['gender'] = gender;
    }
    if (address != null && address != currentProfile.address) {
      changedFields['address'] = address;
    }

    if (changedFields.isEmpty) {
      // logger.log("No changes detected. Skipping update.");
      return;
    }

    String? token = await SharedPrefLoggedinState.getAccessToken();
    if (token == null) throw "User not authenticated. Please login first.";

    final url = Uri.parse(Constants.updateMyProfileUrl);
    final response = await http.patch(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: json.encode(changedFields),
    );

    final jsonResponse = json.decode(response.body);
    if (response.statusCode == 200 && jsonResponse["success"] == true) {
      logger.log("update profile api called");
      // logger.log("Profile updated successfully.");
    } else {
      throw jsonResponse["message"] ?? "Profile update failed.";
    }
  }

  Future<void> updateProfileAvatar({required File imageFile}) async {
    String? token = await SharedPrefLoggedinState.getAccessToken();

    if (token == null) {
      throw "User not authenticated. Please login first.";
    }

    // Create multipart request
    var url = Uri.parse("${Constants.baseUrl}/v1/my-profile");
    var request = http.MultipartRequest('POST', url);

    // Add headers
    request.headers.addAll({
      "Accept": "application/json",
      "Authorization": "Bearer $token",
    });

    // Add image file
    request.files.add(await http.MultipartFile.fromPath(
      'avatar', // key for the form data
      imageFile.path,
    ));

    try {
      // Send the request
      var response = await request.send();
      String responseBody = await response.stream.bytesToString();
      logger.log("Status code: ${response.statusCode}");
      logger.log("Response Body: $responseBody");

      Map<String, dynamic> jsonResponse = json.decode(responseBody);
      logger.log("jsonResponse: $jsonResponse");

      if (response.statusCode == 201 && jsonResponse["success"] == true) {
        logger.log("Avatar updated successfully");
        return;
      } else {
        String errorMessage = jsonResponse["message"]?.toString() ??
            "Failed to update avatar. Status code: ${response.statusCode}";
        logger.log(errorMessage);
        throw errorMessage;
      }
    } catch (e) {
      logger.log("Error updating avatar: $e");
      throw "$e";
    }
  }

  Future<Uint8List> getProfileAvatar() async {
    String? token = await SharedPrefLoggedinState.getAccessToken();

    if (token == null) {
      throw "User not authenticated. Please login first.";
    }

    var headers = {
      "Authorization": "Bearer $token",
      "Accept": "image/*", // Important for image responses
    };

    var url = Uri.parse("${Constants.baseUrl}/v1/my-profile/avatar");

    try {
      var response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        logger.log("get avatar api called");
        return response.bodyBytes; // Return the raw image bytes
      } else {
        throw "Failed to load avatar. Status code: ${response.statusCode}";
      }
    } catch (e) {
      logger.log("Error fetching avatar: $e");
      throw "$e";
    }
  }

  Future removeMyAvatar() async {
    String? token = await SharedPrefLoggedinState.getAccessToken();

    if (token == null) {
      throw "User not authenticated. Please login first.";
    }

    var headers = {
      "Authorization": "Bearer $token",
    };

    var url = Uri.parse("${Constants.baseUrl}/v1/my-profile/avatar");

    try {
      var response = await http.delete(url, headers: headers);

      if (response.statusCode == 204) {
        return true; // Return the raw image bytes
      } else {
        throw "Failed to delete avatar. Status code: ${response.statusCode}";
      }
    } catch (e) {
      logger.log("Error deleting avatar: $e");
      throw "$e";
    }
  }
}
