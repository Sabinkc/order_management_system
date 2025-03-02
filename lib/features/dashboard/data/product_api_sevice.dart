import 'dart:convert';
import 'dart:typed_data';
import 'package:order_management_system/common/constants.dart';
import 'package:order_management_system/features/dashboard/data/cart_model.dart';
import 'package:order_management_system/features/dashboard/data/product_model.dart';
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
  Future<List<ProductDetails>> getAllProducts() async {
    // Get the saved token from SharedPreferences
    String? token = await SharedPrefLoggedinState.getAccessToken();

    // If no token is found, return an error
    if (token == null) {
      throw Exception("User not authenticated. Please log in first.");
    }

    // Headers with Authorization token
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token', // Adding token in the header
    };

    // Constructing the URL to fetch all products
    var url = Uri.parse("${Constants.baseUrl}/v1/products");

    var request = http.Request('GET', url);
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();
      String responseBody = await response.stream.bytesToString();

      // logger.log("Response Status Code: ${response.statusCode}");
      // logger.log("Response Body: $responseBody");

      Map<String, dynamic> jsonResponse = json.decode(responseBody);
      // logger.log("jsonResponse: $jsonResponse");

      if (response.statusCode == 200 && jsonResponse["success"]) {
        List<dynamic> productJson = jsonResponse["data"];
        List<ProductDetails> products = [];

        for (var product in productJson) {
          // Accessing the first element in the unitTypes list
          var unitType = product["unitTypes"][0];

          products.add(ProductDetails(
            id: product["id"],
            name: product["name"],
            description: product["description"],
            categoryName: product["category"]["name"],
            stockQuantity: unitType[
                "stockQuantity"], // Accessing stockQuantity from unitTypes[0]
            price: double.parse(unitType["price"]), // Parsing price as a double
            isAvailable: unitType["isAvailable"],
            imageUrl: unitType["images"][0],
            sku: unitType["sku"],
          ));
        }
        // logger.log("products: $products");
        return products;
      } else {
        throw Exception(jsonResponse['message'] ?? 'Failed to fetch products');
      }
    } catch (e) {
      logger.log("Get Products Error: $e");
      throw Exception('Failed to fetch products');
    }
  }

// Function to get image as response
  Future<Uint8List> getImageByFilename(String filename) async {
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
    var url = Uri.parse("${Constants.baseUrl}/v1/product-image/$filename");

    var request = http.Request('GET', url);
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      // logger.log("Response Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        // Getting image data as bytes
        Uint8List imageData = await response.stream.toBytes();
        return imageData;
      } else {
        throw Exception('Failed to fetch image');
      }
    } catch (e) {
      logger.log("Get Image Error: $e");
      throw Exception('Failed to fetch image');
    }
  }

//get products by category
  Future<List<ProductDetails>> getProductsByCategory(int c) async {
    // Get the saved token from SharedPreferences
    String? token = await SharedPrefLoggedinState.getAccessToken();

    // If no token is found, return an error
    if (token == null) {
      throw Exception("User not authenticated. Please log in first.");
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

      // logger.log("Response Status Code: ${response.statusCode}");

      Map<String, dynamic> jsonResponse = json.decode(responseBody);

      if (response.statusCode == 200 && jsonResponse['success']) {
        List<dynamic> productJson = jsonResponse["data"];
        List<ProductDetails> products = [];

        for (var product in productJson) {
          // Accessing the first element in the unitTypes list
          var unitType = product["unitTypes"][0];

          products.add(ProductDetails(
            id: product["id"],
            name: product["name"],
            description: product["description"],
            categoryName: product["category"]["name"],
            stockQuantity: unitType[
                "stockQuantity"], // Accessing stockQuantity from unitTypes[0]
            price: double.parse(unitType["price"]), // Parsing price as a double
            isAvailable: unitType["isAvailable"],
            imageUrl: unitType["images"]
                [0], // Accessing isAvailable from unitTypes[0]
            sku: unitType["sku"],
          ));
        }
        logger.log("products: $products");
        return products;
      } else {
        throw Exception(jsonResponse['message'] ?? 'Failed to fetch products');
      }
    } catch (e) {
      logger.log("Get Products by Category Error: $e");
      throw Exception('Failed to fetch products');
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
          "message": jsonResponse["message"] ??
              "Failed to fetch products by availability"
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

//get product details
  Future<Map<String, dynamic>> getProductDetailsById(int productId) async {
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

    // Constructing the URL with the productId to fetch product details
    var url = Uri.parse("${Constants.baseUrl}/v1/products/$productId");

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
          "message":
              jsonResponse["message"] ?? "Failed to fetch product details"
        };
      }
    } catch (e) {
      logger.log("Get Product by ID Error: $e");
      return {
        "success": false,
        "message": "Something went wrong. Please try again."
      };
    }
  }

//get product categories
  Future<List<ProductCategory>> getProductCategories() async {
    String? token = await SharedPrefLoggedinState.getAccessToken();

    if (token == null) {
      throw Exception("User not authenticated. Please log in first.");
    }

    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var url = Uri.parse("${Constants.baseUrl}/v1/product-categories");

    var request = http.Request('GET', url);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    String responseBody = await response.stream.bytesToString();
    Map<String, dynamic> jsonResponse = json.decode(responseBody);

    if (response.statusCode == 200 && jsonResponse['success']) {
      List<dynamic> categoriesJson = jsonResponse['categories'];
      List<ProductCategory> categories = [];

      for (var categoryJson in categoriesJson) {
        categories.add(ProductCategory(
          id: categoryJson['id'],
          name: categoryJson['name'],
          productsCount: categoryJson['productsCount'],
        ));
      }
      logger.log("categories: $categories");
      return categories;
    } else {
      throw Exception(jsonResponse['message'] ?? 'Failed to fetch categories');
    }
  }

//get Product Image
  Future<Map<String, dynamic>> getProductImage(String filename) async {
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

    // Constructing the URL with filename to fetch the product image
    var url = Uri.parse("${Constants.baseUrl}/v1/product-image/$filename");

    var request = http.Request('GET', url);
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();
      String responseBody = await response.stream.bytesToString();

      logger.log("Response Status Code: ${response.statusCode}");
      logger.log("Response Body: $responseBody");

      // If the response status code is successful (200), return the image URL or data
      if (response.statusCode == 200) {
        // Assuming the image is returned directly or as base64 encoded data
        return {
          "success": true,
          "data":
              responseBody, // This could be the image data or a URL to the image
        };
      } else {
        return {"success": false, "message": "Failed to fetch product image"};
      }
    } catch (e) {
      logger.log("Get Product Image Error: $e");
      return {
        "success": false,
        "message": "Something went wrong. Please try again."
      };
    }
  }

  Future<Map<String, dynamic>> createOrders(
      List<Map<String, dynamic>> orders) async {
    String? token = await SharedPrefLoggedinState.getAccessToken();

    if (token == null) {
      String tokenErorMessage = "User not authenticated. Please login first.";
      throw tokenErorMessage;
    }

    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var url = Uri.parse(Constants.createOrderUrl);

    var request = http.Request('POST', url);

    // Pass the list of orders in the request body
    request.body = json.encode({
      "orders": orders, // Use the passed orders list here
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    logger.log(response.toString());
    logger.log(response.statusCode.toString());
    String responseBody = await response.stream.bytesToString();

    Map<String, dynamic> jsonResponse = json.decode(responseBody);

    if (response.statusCode == 201 && jsonResponse["success"] == true) {
      logger.log(jsonResponse.toString());
      return jsonResponse;
    } else {
      String errorMessage = jsonResponse["message"]["product"][0];
      logger.log(errorMessage);
      throw errorMessage;
    }
  }

  Future<List<InvoiceModel>> getAllMyOrders() async {
    String? token = await SharedPrefLoggedinState.getAccessToken();

    if (token == null) {
      String tokenErrorMessage = "User not authenticated. Please login first.";
      throw tokenErrorMessage;
    }

    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var url = Uri.parse(Constants.getMyAlloderdUrl);

    var request = http.Request('GET', url);
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    String responseBody = await response.stream.bytesToString();
    logger.log(response.toString());
    Map<String, dynamic> jsonResponse = json.decode(responseBody);

    if (response.statusCode == 200 && jsonResponse["success"]) {
      List<dynamic> ordersJson = jsonResponse["data"];
      List<InvoiceModel> orders = [];

      for (var order in ordersJson) {
        int totalQuantity = 0;
        double totalAmount = 0.0;
        List<InvoiceProductDetailModel> products =
            []; // List to hold CartModel objects

        for (var product in order["products"]) {
          totalQuantity += product["quantity"] as int;
          totalAmount += double.parse(product["amount"].toString());

          // Create CartModel object directly
          products.add(InvoiceProductDetailModel(
            // Use a default value if "id" is missing
            name: product["name"],
            price: double.parse(product["unitPrice"].toString()),
            category: product["category"],
            imagePath: product["imagePath"] ??
                "N/A", // Use a default value if "imagePath" is missing
            quantity: product["quantity"],
          ));
        }

        orders.add(InvoiceModel(
          orderNo: order["key"],
          totalAmount:
              totalAmount.toStringAsFixed(2), // Ensures 2 decimal places
          date: order["products"][0]["createdAt"],
          totalQuantity: totalQuantity,
          status: order["status"],
          products: products, // Include the list of CartModel
        ));
      }
      logger.log(orders.toString());
      return orders;
    } else {
      String errorMessage = "Failed to get orders";
      logger.log(errorMessage);
      throw errorMessage;
    }
  }

  Future<InvoiceModel> getOrderByKey(String orderKey) async {
    // Retrieve the access token
    String? token = await SharedPrefLoggedinState.getAccessToken();

    if (token == null) {
      String tokenErrorMessage = "User not authenticated. Please login first.";
      throw tokenErrorMessage;
    }

    // Set up headers
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    // Construct the URL with the orderKey
    var url = Uri.parse('${Constants.baseUrl}/v1/my-orders/$orderKey');

    // Make the GET request
    var request = http.Request('GET', url);
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    String responseBody = await response.stream.bytesToString();
    logger.log(response.toString());

    // Decode the JSON response
    Map<String, dynamic> jsonResponse = json.decode(responseBody);

    // Check if the request was successful
    if (response.statusCode == 200 && jsonResponse["success"]) {
      Map<String, dynamic> orderJson = jsonResponse["order"];
      List<InvoiceProductDetailModel> products = [];

      // Calculate total quantity and total amount
      int totalQuantity = 0;
      double totalAmount = 0.0;

      // Parse products
      for (var product in orderJson["products"]) {
        totalQuantity += product["quantity"] as int;
        totalAmount += double.parse(product["amount"].toString());

        products.add(InvoiceProductDetailModel(
          name: product["name"],
          category: product["category"],
          quantity: product["quantity"],
          price: double.parse(product["unitPrice"].toString()),
          imagePath: product["imagePath"] ?? "N/A", // Default value if missing
        ));
      }

      // Create and return the InvoiceModel
      InvoiceModel invoice = InvoiceModel(
        orderNo: orderKey,
        totalAmount:
            totalAmount.toStringAsFixed(2), // Format to 2 decimal places
        date: orderJson["createdAt"],
        totalQuantity: totalQuantity,
        status: orderJson["status"],
        products: products,
      );
      logger.log(invoice.toString());
      return invoice;
    } else {
      String errorMessage = "Failed to fetch order details";
      logger.log(errorMessage);
      throw errorMessage;
    }
  }
}
