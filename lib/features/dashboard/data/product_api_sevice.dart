import 'dart:convert';
import 'package:order_management_system/common/constants.dart';
import 'package:order_management_system/features/login/data/sharedpref_loginstate.dart';
import "package:http/http.dart" as http;
import 'dart:developer' as logger;
class ProductApiSevice {

  //get products based on category and availiability
  Future<Map<String, dynamic>> getProductByCandA(int c, int a) async {
  // Get the saved token from SharedPreferences
  String? token = await SharedPrefLoggedinState.getAccessToken();

  // If no token is found, return an error
  if (token == null) {
    return {
      "success": false,
      "message": "User not authenticated. Please log in first."
    };
  }

  // Headers with Authorization token
  var headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token', // Adding token in the header
  };

  // Constructing the URL with query parameters
  var url = Uri.parse(
    "${Constants.baseUrl}/v1/products?c=$c&a=$a",
  );

  var request = http.Request('GET', url);
  request.headers.addAll(headers);

  try {
    http.StreamedResponse response = await request.send();
    String responseBody = await response.stream.bytesToString();

    logger.log("Response Status Code: ${response.statusCode}");
    logger.log("Response Body: $responseBody");

    Map<String, dynamic> jsonResponse = json.decode(responseBody);
    logger.log("jsonResponse: $jsonResponse");

    if (response.statusCode == 200) {
      return {"success": true, "data": jsonResponse};
    } else {
      return {
        "success": false,
        "message": jsonResponse["message"] ?? "Failed to fetch products"
      };
    }
  } catch (e) {
    logger.log("Get Products Error: $e");
    return {
      "success": false,
      "message": "Something went wrong. Please try again."
    };
  }
}


//get all products
Future<Map<String, dynamic>> getAllProducts() async {
  // Get the saved token from SharedPreferences
  String? token = await SharedPrefLoggedinState.getAccessToken();

  // If no token is found, return an error
  if (token == null) {
    return {
      "success": false,
      "message": "User not authenticated. Please log in first."
    };
  }

  // Headers with Authorization token
  var headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token', // Adding token in the header
  };

  // Constructing the URL without query parameters (fetch all products)
  var url = Uri.parse("${Constants.baseUrl}/v1/products");

  var request = http.Request('GET', url);
  request.headers.addAll(headers);

  try {
    http.StreamedResponse response = await request.send();
    String responseBody = await response.stream.bytesToString();

    logger.log("Response Status Code: ${response.statusCode}");
    logger.log("Response Body: $responseBody");

    Map<String, dynamic> jsonResponse = json.decode(responseBody);
    logger.log("jsonResponse: $jsonResponse");

    if (response.statusCode == 200) {
      return {"success": true, "data": jsonResponse};
    } else {
      return {
        "success": false,
        "message": jsonResponse["message"] ?? "Failed to fetch products"
      };
    }
  } catch (e) {
    logger.log("Get Products Error: $e");
    return {
      "success": false,
      "message": "Something went wrong. Please try again."
    };
  }
}


//get products by category
Future<Map<String, dynamic>> getProductsByCategory(int c) async {
  // Get the saved token from SharedPreferences
  String? token = await SharedPrefLoggedinState.getAccessToken();

  // If no token is found, return an error
  if (token == null) {
    return {
      "success": false,
      "message": "User not authenticated. Please log in first."
    };
  }

  // Headers with Authorization token
  var headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token', // Adding token in the header
  };

  // Constructing the URL with the category filter (c for category)
  var url = Uri.parse("${Constants.baseUrl}/v1/products?c=$c");

  var request = http.Request('GET', url);
  request.headers.addAll(headers);

  try {
    http.StreamedResponse response = await request.send();
    String responseBody = await response.stream.bytesToString();

    logger.log("Response Status Code: ${response.statusCode}");
    logger.log("Response Body: $responseBody");

    Map<String, dynamic> jsonResponse = json.decode(responseBody);
    logger.log("jsonResponse: $jsonResponse");

    if (response.statusCode == 200) {
      return {"success": true, "data": jsonResponse};
    } else {
      return {
        "success": false,
        "message": jsonResponse["message"] ?? "Failed to fetch products by category"
      };
    }
  } catch (e) {
    logger.log("Get Products by Category Error: $e");
    return {
      "success": false,
      "message": "Something went wrong. Please try again."
    };
  }
}


//get products by availiability
Future<Map<String, dynamic>> getProductsByAvailability(int a) async {
  // Get the saved token from SharedPreferences
  String? token = await SharedPrefLoggedinState.getAccessToken();

  // If no token is found, return an error
  if (token == null) {
    return {
      "success": false,
      "message": "User not authenticated. Please log in first."
    };
  }

  // Headers with Authorization token
  var headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token', // Adding token in the header
  };

  // Constructing the URL with the availability filter (a for availability)
  var url = Uri.parse("${Constants.baseUrl}/v1/products?a=$a");

  var request = http.Request('GET', url);
  request.headers.addAll(headers);

  try {
    http.StreamedResponse response = await request.send();
    String responseBody = await response.stream.bytesToString();

    logger.log("Response Status Code: ${response.statusCode}");
    logger.log("Response Body: $responseBody");

    Map<String, dynamic> jsonResponse = json.decode(responseBody);
    logger.log("jsonResponse: $jsonResponse");

    if (response.statusCode == 200) {
      return {"success": true, "data": jsonResponse};
    } else {
      return {
        "success": false,
        "message": jsonResponse["message"] ?? "Failed to fetch products by availability"
      };
    }
  } catch (e) {
    logger.log("Get Products by Availability Error: $e");
    return {
      "success": false,
      "message": "Something went wrong. Please try again."
    };
  }
}


}
