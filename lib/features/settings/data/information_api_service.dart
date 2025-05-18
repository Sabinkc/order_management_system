import 'dart:convert';
import 'dart:io';

import 'package:order_management_system/common/constants.dart';
import 'package:order_management_system/features/login/data/sharedpref_loginstate.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as logger;

import 'package:order_management_system/features/settings/data/information_model.dart';

class InformationApiService {
  Future<List<FaqModel>> getFaq() async {
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

    // Constructing the URL to fetch FAQs
    var url = Uri.parse("${Constants.baseUrl}/v1/faqs");

    var request = http.Request('GET', url);
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();
      String responseBody = await response.stream.bytesToString();

      // logger.log("Response Status Code: ${response.statusCode}");
      // logger.log("Response Body: $responseBody"); // Log the response body for debugging

      Map<String, dynamic> jsonResponse = json.decode(responseBody);

      if (response.statusCode == 200 && jsonResponse['success'] == true) {
        List<dynamic> faqJsonList = jsonResponse['faqs'];
        List<FaqModel> faqs = [];

        for (var faqJson in faqJsonList) {
          faqs.add(FaqModel(
            id: faqJson['id'].toString(), // Assuming 'id' is an integer
            title: faqJson['title'],
            description: faqJson['description'],
          ));
        }
        // logger.log("Fetched FAQs: $faqs");
        return faqs;
      } else {
        logger.log(
            "Failed to fetch FAQs. Status Code: ${response.statusCode}, Body: $responseBody");
        throw Exception(jsonResponse['message'] ?? 'Failed to fetch FAQs');
      }
    } catch (e) {
      logger.log("Get FAQs Error: $e");
      throw Exception('Failed to fetch FAQs');
    }
  }

  Future<List<PrivacyPolicyModel>> getPrivacyPolicy() async {
    // Headers with Authorization token
    var headers = {
      'Accept': 'application/json',
    };

    // Constructing the URL to fetch FAQs
    var url = Uri.parse("${Constants.baseUrl}/v1/privacy-policies");

    var request = http.Request('GET', url);
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();
      String responseBody = await response.stream.bytesToString();

      // logger.log("Response Status Code: ${response.statusCode}");
      // logger.log("Response Body: $responseBody"); // Log the response body for debugging

      Map<String, dynamic> jsonResponse = json.decode(responseBody);

      if (response.statusCode == 200 && jsonResponse['success'] == true) {
        List<dynamic> privacyPolicyJsonList = jsonResponse['privacyPolicy'];
        List<PrivacyPolicyModel> privacyPolicies = [];

        for (var privacyJson in privacyPolicyJsonList) {
          privacyPolicies.add(PrivacyPolicyModel(
            id: privacyJson['id'].toString(), // Assuming 'id' is an integer
            title: privacyJson['title'],
            description: privacyJson['description'],
          ));
        }
        // logger.log("Fetched FAQs: $faqs");
        return privacyPolicies;
      } else {
        logger.log(
            "Failed to fetch Privacy Policies. Status Code: ${response.statusCode}, Body: $responseBody");
        throw Exception(
            jsonResponse['message'] ?? 'Failed to fetch privacy Policies');
      }
    } catch (e) {
      logger.log("Get privacy Policies Error: $e");
      throw Exception('Failed to fetch Privacy Policies');
    }
  }

  Future<List<TermsOfConditionModel>> getTermsAndConditions() async {
    var headers = {
      'Accept': 'application/json',
    };

    var url = Uri.parse("${Constants.baseUrl}/v1/terms-of-service");

    var request = http.Request('GET', url);
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();
      String responseBody = await response.stream.bytesToString();

      Map<String, dynamic> jsonResponse = json.decode(responseBody);

      if (response.statusCode == 200 && jsonResponse['success'] == true) {
        List<dynamic> termsJsonList = jsonResponse['termsOfService'];
        List<TermsOfConditionModel> termsList = [];

        for (var termJson in termsJsonList) {
          termsList.add(TermsOfConditionModel(
            id: termJson['id'].toString(),
            title: termJson['title'],
            description: termJson['description'],
          ));
        }
        return termsList;
      } else {
        logger.log(
          "Failed to fetch Terms & Conditions. Status Code: ${response.statusCode}, Body: $responseBody",
        );
        throw Exception(
          jsonResponse['message'] ?? 'Failed to fetch Terms & Conditions',
        );
      }
    } catch (e) {
      logger.log("Get Terms & Conditions Error: $e");
      throw Exception('Failed to fetch Terms & Conditions');
    }
  }

  Future<List<ContactAndSupportModel>> getContact() async {
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

    // Constructing the URL to fetch FAQs
    var url = Uri.parse("${Constants.baseUrl}/v1/contact-us");

    var request = http.Request('GET', url);
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();
      String responseBody = await response.stream.bytesToString();

      // logger.log("Response Status Code: ${response.statusCode}");
      // logger.log("Response Body: $responseBody"); // Log the response body for debugging

      Map<String, dynamic> jsonResponse = json.decode(responseBody);

      if (response.statusCode == 200 && jsonResponse['success'] == true) {
        List<dynamic> contactJsonList = jsonResponse['contacts'];
        List<ContactAndSupportModel> contacts = [];

        for (var contactJson in contactJsonList) {
          contacts.add(ContactAndSupportModel(
            field:
                contactJson['field'].toString(), // Assuming 'id' is an integer
            value: contactJson['value'],
            type: contactJson['type'],
          ));
        }
        // logger.log("Fetched FAQs: $faqs");
        return contacts;
      } else {
        logger.log(
            "Failed to fetch contacts. Status Code: ${response.statusCode}, Body: $responseBody");
        throw Exception(jsonResponse['message'] ?? 'Failed to fetch contacts');
      }
    } catch (e) {
      logger.log("Get contacts Error: $e");
      throw Exception('Failed to fetch contacts');
    }
  }

  Future<void> sendReport({
    required File imageFile,
    required String heading,
    required String description,
    required String device,
  }) async {
    logger.log(
        "passed report data: heading: $heading, description: $description, device: $device");
    String? token = await SharedPrefLoggedinState.getAccessToken();

    if (token == null) {
      throw "User not authenticated. Please login first.";
    }

    // Create multipart request
    var url = Uri.parse("${Constants.baseUrl}/v1/report");
    var request = http.MultipartRequest('POST', url);

    // Add headers
    request.headers.addAll({
      "Accept": "application/json",
      "Authorization": "Bearer $token",
    });

    // Add text fields
    request.fields['heading'] = heading;
    request.fields['description'] = description;
    request.fields['device'] = device;

    // Add image file
    request.files.add(await http.MultipartFile.fromPath(
      'image', // Key name expected by your backend
      imageFile.path,
    ));

    try {
      var response = await request.send();
      String responseBody = await response.stream.bytesToString();
      logger.log("Status code: ${response.statusCode}");
      logger.log("Response Body: $responseBody");

      Map<String, dynamic> jsonResponse = json.decode(responseBody);
      logger.log("jsonResponse: $jsonResponse");

      if (response.statusCode == 201 && jsonResponse["success"] == true) {
        logger.log("Report sent successfully");
        return;
      } else {
        String errorMessage = jsonResponse["message"]?.toString() ??
            "Failed to send report. Status code: ${response.statusCode}";
        logger.log(errorMessage);
        throw errorMessage;
      }
    } catch (e) {
      logger.log("Error sending report: $e");
      throw "$e";
    }
  }
}
