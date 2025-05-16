import 'dart:convert';

import 'package:order_management_system/common/constants.dart';
import 'package:order_management_system/features/login/data/sharedpref_loginstate.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as logger;

import 'package:order_management_system/features/settings/data/faq_model.dart';

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
        logger.log("Failed to fetch FAQs. Status Code: ${response.statusCode}, Body: $responseBody");
        throw Exception(jsonResponse['message'] ?? 'Failed to fetch FAQs');
      }
    } catch (e) {
      logger.log("Get FAQs Error: $e");
      throw Exception('Failed to fetch FAQs');
    }
  }

}