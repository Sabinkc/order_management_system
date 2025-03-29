import 'dart:convert';
import 'package:order_management_system/common/constants.dart';
import 'package:order_management_system/features/location/data/address_model.dart';
import 'package:order_management_system/features/login/data/sharedpref_loginstate.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as logger;

class LocationApiService {
  Future createShippingLocation(
      String receiverName,
      String receiverPhone,
      String receiverEmail,
      double lat,
      double long,
      String prefecture,
      String city,
      String area,
      String? landmark) async {
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

    var url = Uri.parse(Constants.createShippingLocationUrl);

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
      String errorMessage =
          jsonResponse["message"].values.first[0] ?? "Failed to add location!";
      logger.log(errorMessage);
      throw errorMessage;
    }
  }

  Future<List<AddressModel>> getAllLocation() async {
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
    var url = Uri.parse(Constants.getAllLocationUrl);
    var request = http.Request("GET", url);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    String responseBody = await response.stream.bytesToString();
    logger.log("status code: ${response.statusCode}");
    // logger.log("Response Body: $responseBody");
    Map<String, dynamic> jsonResponse = json.decode(responseBody);
    // logger.log("jsonResponse: $jsonResponse");

    if (response.statusCode == 200 && jsonResponse["success"] == true) {
      // logger.log(jsonResponse.toString());
      List locationJson = jsonResponse["locations"];
      List<AddressModel> locations = [];

      for (var location in locationJson) {
        locations.add(AddressModel(
            id: location["id"],
            fullName: location["receiver"]["name"],
            phone: location["receiver"]["phone"],
            email: location["receiver"]["email"],
            state: location["prefecture"],
            city: location["city"],
            area: location["area"],
            landmark: location["landmark"]));
      }
      // logger.log(locations.toString());
      return locations;
    } else {
      String errorMessage = "Failed to load locations";
      throw errorMessage;
    }
  }

  Future deleteLocation(int locationId) async {
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
    var url = Uri.parse("${Constants.deleteLocationBaseUrl}/$locationId");
    var request = http.Request("DELETE", url);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    String responseBody = await response.stream.bytesToString();
    logger.log("status code: ${response.statusCode}");
    // logger.log("Response Body: $responseBody");
    // logger.log("jsonResponse: $jsonResponse");

    if (response.statusCode == 204) {
      // logger.log(jsonResponse.toString());
      return;
    } else {
      Map<String, dynamic> jsonResponse = json.decode(responseBody);
      String errorMessage = jsonResponse["message"];
      logger.log(errorMessage);
      throw errorMessage;
    }
  }

  Future updateShippingLocation(
      {required int locationId,
      String? receiverName,
      String? receiverPhone,
      String? receiverEmail,
      double? lat,
      double? long,
      String? prefecture,
      String? city,
      String? area,
      String? landmark}) async {
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

    var url = Uri.parse("${Constants.updateLocationBaseUrl}/$locationId");

    var request = http.Request("PATCH", url);

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
      "landmark": landmark ?? "_",
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    String responseBody = await response.stream.bytesToString();
    logger.log("status code: ${response.statusCode}");
    logger.log("Response Body: $responseBody");

    Map<String, dynamic> jsonResponse = json.decode(responseBody);
    logger.log("jsonResponse: $jsonResponse");

    if (response.statusCode == 200 && jsonResponse["success"] == true) {
      logger.log(jsonResponse.toString());
      return;
    } else {
      String errorMessage =
          jsonResponse["message"].toString();
      logger.log(errorMessage);
      throw errorMessage;
    }
  }

}
