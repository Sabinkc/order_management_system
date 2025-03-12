import 'dart:convert';

import 'package:order_management_system/common/constants.dart';
import 'package:order_management_system/features/login/data/sharedpref_loginstate.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as logger;

class LocationApiService {
  Future createShippingLocation(String receiverName, String receiverPhone, String receiverEmail, double lat, double long, String prefecture, String city, String area, String? landmark) async {
    String? token = await SharedPrefLoggedinState.getAccessToken();

    if (token == null) {
      String tokenErorMessage = "User not authenticated. Please login first.";
      throw tokenErorMessage;
    }

    var headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    var url = Uri.parse("${Constants.baseUrl}/v1/locations");

    var request = http.Request("POST", url);

    request.body = json.encode({
      "receiver": {
        "name": receiverName,
        "phone": receiverPhone,
        "email": receiverEmail,
      },
      "lat": lat,
      "lng": long,
      "prefecture": prefecture,
      "city": city,
      "area": area,
      "landmark": landmark
    });
    request.headers.addAll(headers);

    
      http.StreamedResponse response = await request.send();
      String responseBody = await response.stream.bytesToString();
      logger.log("status code: ${response.statusCode}");
      logger.log("Response Body: $responseBody");

      Map<String, dynamic> jsonResponse = json.decode(responseBody);
      logger.log("jsonResponse: $jsonResponse");

      if (response.statusCode == 201 && jsonResponse["success"] == true) {
        logger.log(jsonResponse.toString());
        return jsonResponse;
      } else {
        String errorMessage = "Failed to add shipping location";
        logger.log(errorMessage);
        throw errorMessage;
      }
    

    }
  }

