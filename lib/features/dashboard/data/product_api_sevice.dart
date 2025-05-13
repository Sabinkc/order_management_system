import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:order_management_system/common/constants.dart';
import 'package:order_management_system/features/dashboard/data/custom_cache_manager.dart';
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

  Future<List<ProductDetails>> getAllProducts(String s, int page) async {
    String? token = await SharedPrefLoggedinState.getAccessToken();
    if (token == null) {
      throw Exception("User not authenticated. Please log in first.");
    }

    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var url = Uri.parse("${Constants.baseUrl}/v1/products?s=$s&page=$page");
    var request = http.Request('GET', url);
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();
      String responseBody = await response.stream.bytesToString();
      Map<String, dynamic> jsonResponse = json.decode(responseBody);

      if (response.statusCode == 200 && jsonResponse["success"]) {
        List<dynamic> productJson = jsonResponse["data"];
        List<ProductDetails> products = [];
        // logger.log("get all products api called");

        for (var product in productJson) {
          // Safely handle unitImages
          String? imageUrl;
          if (product["unitImages"] != null &&
              product["unitImages"].isNotEmpty) {
            imageUrl = product["unitImages"][0];
          }

          // Safely parse unitPrice
          double price = 0.0;
          if (product["unitPrice"] != null) {
            price = double.tryParse(product["unitPrice"].toString()) ?? 0.0;
          }

          products.add(ProductDetails(
            name: product["name"] ?? "No name",
            description: product["description"] ?? "Description not available",
            categoryName: product["category"]["name"] ?? "Uncategorized",
            stockQuantity: product["unitStock"] ?? 0,
            price: price,
            isAvailable: product["isAvailable"] ?? false,
            imageUrl: imageUrl ?? "default_image_url", // Fallback if no image
            sku: product["sku"] ?? "N/A",
            images: product["unitImages"] ?? [], // Ensure this is never null
          ));
        }

        // logger.log("get all products api success");
        return products;
      } else {
        throw Exception(jsonResponse['message'] ?? 'Failed to fetch products');
      }
    } catch (e) {
      logger.log("Get Products Error: $e");
      throw Exception('Failed to fetch products: ${e.toString()}');
    }
  }

  Future<List<ProductDetails>> getAllProductsinJapanese(
      String s, int page) async {
    String? token = await SharedPrefLoggedinState.getAccessToken();
    if (token == null) {
      throw Exception("User not authenticated. Please log in first.");
    }

    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var url = Uri.parse("${Constants.baseUrl}/v1/products?s=$s&page=$page");
    var request = http.Request('GET', url);
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();
      String responseBody = await response.stream.bytesToString();
      Map<String, dynamic> jsonResponse = json.decode(responseBody);

      if (response.statusCode == 200 && jsonResponse["success"]) {
        List<dynamic> productJson = jsonResponse["data"];
        List<ProductDetails> products = [];
        // logger.log("get all products api called");

        for (var product in productJson) {
          // Safely handle unitImages
          String? imageUrl;
          if (product["unitImages"] != null &&
              product["unitImages"].isNotEmpty) {
            imageUrl = product["unitImages"][0];
          }

          // Safely parse unitPrice
          double price = 0.0;
          if (product["unitPrice"] != null) {
            price = double.tryParse(product["unitPrice"].toString()) ?? 0.0;
          }

          products.add(ProductDetails(
            name: product["japaneseName"] ?? "No name",
            description:
                product["japaneseDescription"] ?? "Description not available",
            categoryName: product["category"]["japanese_name"] ?? "Japanese name not availiable",
            stockQuantity: product["unitStock"] ?? 0,
            price: price,
            isAvailable: product["isAvailable"] ?? false,
            imageUrl: imageUrl ?? "default_image_url", // Fallback if no image
            sku: product["sku"] ?? "N/A",
            images: product["unitImages"] ?? [], // Ensure this is never null
          ));
        }

        logger.log("get all products api success");
        return products;
      } else {
        throw Exception(jsonResponse['message'] ?? 'Failed to fetch products');
      }
    } catch (e) {
      logger.log("Get Products Error: $e");
      throw Exception('Failed to fetch products: ${e.toString()}');
    }
  }

  Future<List<OfferProductDetails>> getOfferProducts(String s, int page) async {
    String? token = await SharedPrefLoggedinState.getAccessToken();
    if (token == null) {
      throw Exception("User not authenticated. Please log in first.");
    }

    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var url = Uri.parse("${Constants.baseUrl}/v1/products?s=$s&o=1&page=$page");
    var request = http.Request('GET', url);
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();
      String responseBody = await response.stream.bytesToString();
      Map<String, dynamic> jsonResponse = json.decode(responseBody);

      if (response.statusCode == 200 && jsonResponse["success"]) {
        List<dynamic> productJson = jsonResponse["data"];
        List<OfferProductDetails> products = [];
        logger.log("get all products api called");

        for (var product in productJson) {
          // Safely handle unitImages
          String? imageUrl;
          if (product["unitImages"] != null &&
              product["unitImages"].isNotEmpty) {
            imageUrl = product["unitImages"][0];
          }

          // Safely parse unitPrice
          double price = 0.0;
          if (product["unitPrice"] != null) {
            price = double.tryParse(product["unitPrice"].toString()) ?? 0.0;
          }

          products.add(OfferProductDetails(
            name: product["name"] ?? "No name",
            description: product["description"] ?? "Description not available",
            categoryName: product["category"]["name"] ?? "Uncategorized",
            stockQuantity: product["unitStock"] ?? 0,
            price: price,
            isAvailable: product["isAvailable"] ?? false,
            imageUrl: imageUrl ?? "default_image_url", // Fallback if no image
            sku: product["sku"] ?? "N/A",
            images: product["unitImages"] ?? [], // Ensure this is never null
            discountPercent: product["discountPercent"] ?? "0",
          ));
        }
// logger.log("offer products: $products");
        logger.log("get all products api success");
        return products;
      } else {
        throw Exception(jsonResponse['message'] ?? 'Failed to fetch products');
      }
    } catch (e) {
      logger.log("Get Products Error: $e");
      throw Exception('Failed to fetch products: ${e.toString()}');
    }
  }

  Future<List<OfferProductDetails>> getOfferProductsInJapanese(
      String s, int page) async {
    String? token = await SharedPrefLoggedinState.getAccessToken();
    if (token == null) {
      throw Exception("User not authenticated. Please log in first.");
    }

    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var url = Uri.parse("${Constants.baseUrl}/v1/products?s=$s&o=1&page=$page");
    var request = http.Request('GET', url);
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();
      String responseBody = await response.stream.bytesToString();
      Map<String, dynamic> jsonResponse = json.decode(responseBody);

      if (response.statusCode == 200 && jsonResponse["success"]) {
        List<dynamic> productJson = jsonResponse["data"];
        List<OfferProductDetails> products = [];
        logger.log("get all products api called");

        for (var product in productJson) {
          // Safely handle unitImages
          String? imageUrl;
          if (product["unitImages"] != null &&
              product["unitImages"].isNotEmpty) {
            imageUrl = product["unitImages"][0];
          }

          // Safely parse unitPrice
          double price = 0.0;
          if (product["unitPrice"] != null) {
            price = double.tryParse(product["unitPrice"].toString()) ?? 0.0;
          }

          products.add(OfferProductDetails(
            name: product["japaneseName"] ?? "Japanese name not availiable",
            description: product["japaneseDescription"] ??
                "Japanese description not available",
            categoryName: product["category"]["japanese_name"] ?? "Japanese name not availiable",
            stockQuantity: product["unitStock"] ?? 0,
            price: price,
            isAvailable: product["isAvailable"] ?? false,
            imageUrl: imageUrl ?? "default_image_url", // Fallback if no image
            sku: product["sku"] ?? "N/A",
            images: product["unitImages"] ?? [], // Ensure this is never null
            discountPercent: product["discountPercent"] ?? "0",
          ));
        }
// logger.log("offer products: $products");
        logger.log("get all products api success");
        return products;
      } else {
        throw Exception(jsonResponse['message'] ?? 'Failed to fetch products');
      }
    } catch (e) {
      logger.log("Get Products Error: $e");
      throw Exception('Failed to fetch products: ${e.toString()}');
    }
  }

  // Future<List<ProductDetails>> getAllProducts(String s, int page) async {
  //   // Get the saved token from SharedPreferences
  //   String? token = await SharedPrefLoggedinState.getAccessToken();

  //   // If no token is found, return an error
  //   if (token == null) {
  //     throw Exception("User not authenticated. Please log in first.");
  //   }

  //   // Headers with Authorization token
  //   var headers = {
  //     'Accept': 'application/json',
  //     'Content-Type': 'application/json',
  //     'Authorization': 'Bearer $token', // Adding token in the header
  //   };

  //   // Constructing the URL to fetch all products
  //   var url = Uri.parse("${Constants.baseUrl}/v1/products?s=$s&page=$page");

  //   var request = http.Request('GET', url);
  //   request.headers.addAll(headers);

  //   try {
  //     http.StreamedResponse response = await request.send();
  //     String responseBody = await response.stream.bytesToString();

  //     // logger.log("Response Status Code: ${response.statusCode}");
  //     // logger.log("Response Body: $responseBody");

  //     Map<String, dynamic> jsonResponse = json.decode(responseBody);
  //     // logger.log("jsonResponse: $jsonResponse");

  //     if (response.statusCode == 200 && jsonResponse["success"]) {
  //       List<dynamic> productJson = jsonResponse["data"];
  //       List<ProductDetails> products = [];
  //       logger.log("get all products api called");
  //       for (var product in productJson) {
  //         // Accessing the first element in the unitTypes list
  //         // var unitType = product["unitTypes"][0];

  //         products.add(ProductDetails(
  //           name: product["name"],
  //           description: product["description"] ?? "Description not availiable",
  //           categoryName: product["category"]["name"],
  //           stockQuantity: product[
  //               "unitStock"], // Accessing stockQuantity from unitTypes[0]
  //           price:
  //               double.parse(product["unitPrice"]), // Parsing price as a double
  //           isAvailable: product["isAvailable"],
  //           imageUrl: product["unitImages"][0] ?? "url not found",
  //           sku: product["sku"],

  //           images: product["unitImages"] ?? [],
  //         ));
  //       }
  //       logger.log("get all products api success");
  //       // logger.log("products: $products");
  //       return products;
  //     } else {
  //       throw Exception(jsonResponse['message'] ?? 'Failed to fetch products');
  //     }
  //   } catch (e) {
  //     logger.log("Get Products Error: $e");
  //     throw Exception('Failed to fetch products');
  //   }
  // }

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
    var url =
        Uri.parse("${Constants.baseUrl}/v1/storage/img/products/$filename");

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

  // Future<Uint8List> getThumbnailByFilename(String filename) async {
  //   // Use the full URL as cache key for better reliability
  //   final cacheKey =
  //       'image_${Constants.baseUrl}/v1/storage/img/products/thumbnails/$filename';
  //   final cacheManager = DefaultCacheManager();

  //   // 1. Try disk cache first
  //   final cachedFile = await cacheManager.getFileFromCache(cacheKey);
  //   if (cachedFile != null) {
  //     final bytes = await cachedFile.file.readAsBytes();
  //     if (bytes.isNotEmpty) {
  //       // logger.log('Loaded from cache: $filename (${bytes.length} bytes)');
  //       return bytes;
  //     }
  //   }

  //   // 2. Network fetch if not in cache
  //   final token = await SharedPrefLoggedinState.getAccessToken();
  //   if (token == null) throw Exception("Not authenticated");

  //   // logger.log('Fetching from network: $filename');
  //   final response = await http.get(
  //     Uri.parse(
  //         "${Constants.baseUrl}/v1/storage/img/products/thumbnails/$filename"),
  //     headers: {'Authorization': 'Bearer $token'},
  //   );

  //   if (response.statusCode != 200) {
  //     throw Exception('Failed to fetch image: ${response.statusCode}');
  //   }

  //   // 3. Compress and cache the image
  //   final compressedBytes = await _compressImage(response.bodyBytes);
  //   // logger.log(
  //   // 'Compressed ${response.bodyBytes.length} → ${compressedBytes.length} bytes');

  //   // Store in cache (only if compression succeeded)
  //   if (compressedBytes.isNotEmpty) {
  //     await cacheManager.putFile(cacheKey, compressedBytes);
  //   } else {
  //     // logger.log('Compression failed, storing original');
  //     await cacheManager.putFile(cacheKey, response.bodyBytes);
  //   }
  //   // final cacheSize = await calculateCacheSize();
  //   // logger.log(
  //   // 'Total cache size: ${(cacheSize / (1024 * 1024)).toStringAsFixed(2)} MB');

  //   return compressedBytes.isNotEmpty ? compressedBytes : response.bodyBytes;
  // }

  // Future<Uint8List> getCategoryImage(String filename) async {
  //   // Use the full URL as cache key for better reliability
  //   final cacheKey =
  //       'image_${Constants.baseUrl}/v1/storage/img/product-categories/$filename';
  //   final cacheManager = DefaultCacheManager();

  //   // 1. Try disk cache first
  //   final cachedFile = await cacheManager.getFileFromCache(cacheKey);
  //   if (cachedFile != null) {
  //     final bytes = await cachedFile.file.readAsBytes();
  //     if (bytes.isNotEmpty) {
  //       // logger.log('Loaded from cache: $filename (${bytes.length} bytes)');
  //       return bytes;
  //     }
  //   }

  //   // 2. Network fetch if not in cache
  //   final token = await SharedPrefLoggedinState.getAccessToken();
  //   if (token == null) throw Exception("Not authenticated");

  //   // logger.log('Fetching from network: $filename');
  //   final response = await http.get(
  //     Uri.parse(
  //         "${Constants.baseUrl}/v1/storage/img/product-categories/$filename"),
  //     headers: {'Authorization': 'Bearer $token'},
  //   );

  //   if (response.statusCode != 200) {
  //     throw Exception('Failed to fetch image: ${response.statusCode}');
  //   }

  //   // 3. Compress and cache the image
  //   final compressedBytes = await _compressImage(response.bodyBytes);
  //   // logger.log(
  //   // 'Compressed ${response.bodyBytes.length} → ${compressedBytes.length} bytes');

  //   // Store in cache (only if compression succeeded)
  //   if (compressedBytes.isNotEmpty) {
  //     await cacheManager.putFile(cacheKey, compressedBytes);
  //   } else {
  //     // logger.log('Compression failed, storing original');
  //     await cacheManager.putFile(cacheKey, response.bodyBytes);
  //   }
  //   // final cacheSize = await calculateCacheSize();
  //   // logger.log(
  //   // 'Total cache size: ${(cacheSize / (1024 * 1024)).toStringAsFixed(2)} MB');

  //   return compressedBytes.isNotEmpty ? compressedBytes : response.bodyBytes;
  // }

  // Future<Directory> getCacheDirectory() async {
  //   return await getTemporaryDirectory();
  // }

  // Future<int> calculateCacheSize() async {
  //   final cacheDir = await getCacheDirectory();
  //   int totalSize = 0;

  //   if (await cacheDir.exists()) {
  //     final files = cacheDir.listSync(recursive: true);
  //     for (var file in files) {
  //       if (file is File) {
  //         totalSize += await file.length();
  //       }
  //     }
  //   }

  //   return totalSize;
  // }

  // Future<Uint8List> _compressImage(Uint8List bytes) async {
  //   try {
  //     return await FlutterImageCompress.compressWithList(bytes,
  //         minWidth: 800,
  //         minHeight: 800,
  //         quality: 80,
  //         format: CompressFormat.webp);
  //   } catch (e) {
  //     logger.log('Compression error: $e');
  //     return bytes; // Return original if compression fails
  //   }
  // }

  // Future<void> clearCache() async {
  //   await DefaultCacheManager().emptyCache();
  //   logger.log("cache cleaned");
  // }


Future<Uint8List> getThumbnailByFilename(String filename) async {
  final cacheKey =
      'image_${Constants.baseUrl}/v1/storage/img/products/thumbnails/$filename';
  final cacheManager = LimitedCacheManager(); // ✅ Use custom cache manager

  // 1. Try disk cache first
  final cachedFile = await cacheManager.getFileFromCache(cacheKey);
  if (cachedFile != null) {
    final bytes = await cachedFile.file.readAsBytes();
    if (bytes.isNotEmpty) {
      return bytes;
    }
  }

  // 2. Network fetch if not in cache
  final token = await SharedPrefLoggedinState.getAccessToken();
  if (token == null) throw Exception("Not authenticated");

  final response = await http.get(
    Uri.parse(
        "${Constants.baseUrl}/v1/storage/img/products/thumbnails/$filename"),
    headers: {'Authorization': 'Bearer $token'},
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to fetch image: ${response.statusCode}');
  }

  // 3. Compress and cache the image
  final compressedBytes = await _compressImage(response.bodyBytes);

  if (compressedBytes.isNotEmpty) {
    await cacheManager.putFile(cacheKey, compressedBytes);
  } else {
    await cacheManager.putFile(cacheKey, response.bodyBytes);
  }

  return compressedBytes.isNotEmpty ? compressedBytes : response.bodyBytes;
}



  Future<Uint8List> getCategoryImage(String filename) async {
  final cacheKey =
      'image_${Constants.baseUrl}/v1/storage/img/product-categories/$filename';
  final cacheManager = LimitedCacheManager(); // ✅ use custom manager

  // 1. Try disk cache first
  final cachedFile = await cacheManager.getFileFromCache(cacheKey);
  if (cachedFile != null) {
    final bytes = await cachedFile.file.readAsBytes();
    if (bytes.isNotEmpty) {
      return bytes;
    }
  }

  // 2. Network fetch if not in cache
  final token = await SharedPrefLoggedinState.getAccessToken();
  if (token == null) throw Exception("Not authenticated");

  final response = await http.get(
    Uri.parse(
        "${Constants.baseUrl}/v1/storage/img/product-categories/$filename"),
    headers: {'Authorization': 'Bearer $token'},
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to fetch image: ${response.statusCode}');
  }

  // 3. Compress and cache
  final compressedBytes = await _compressImage(response.bodyBytes);

  if (compressedBytes.isNotEmpty) {
    await cacheManager.putFile(cacheKey, compressedBytes);
  } else {
    await cacheManager.putFile(cacheKey, response.bodyBytes);
  }

  return compressedBytes.isNotEmpty ? compressedBytes : response.bodyBytes;
}

Future<Uint8List> _compressImage(Uint8List bytes) async {
    try {
      return await FlutterImageCompress.compressWithList(bytes,
          minWidth: 800,
          minHeight: 800,
          quality: 80,
          format: CompressFormat.webp);
    } catch (e) {
      logger.log('Compression error: $e');
      return bytes; // Return original if compression fails
    }
  }


Future<void> clearCache() async {
  await LimitedCacheManager().emptyCache();
  logger.log("cache cleaned");
}



//get products by category
  Future<List<ProductDetails>> getProductsByCategory(
      int c, String s, int page) async {
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
    var url =
        Uri.parse("${Constants.baseUrl}/v1/products?c=$c&s=$s&page=$page");

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
          // var unitType = product["unitTypes"][0];

          products.add(ProductDetails(
            // id: product["id"],
            name: product["name"],
            description: product["description"] ?? "Description not availiable",
            categoryName: product["category"]["name"],
            stockQuantity: product[
                "unitStock"], // Accessing stockQuantity from unitTypes[0]
            price:
                double.parse(product["unitPrice"]), // Parsing price as a double
            isAvailable: product["isAvailable"],
            imageUrl: product["unitImages"]
                [0], // Accessing isAvailable from unitTypes[0]
            sku: product["sku"],
            images: product["unitImages"] ?? [],
          ));
        }
        // logger.log("get products by category called");
        // logger.log("products: $products");
        return products;
      } else {
        throw Exception(jsonResponse['message'] ?? 'Failed to fetch products');
      }
    } catch (e) {
      logger.log("Get Products by Category Error: $e");
      throw Exception('Failed to fetch products');
    }
  }

  Future<List<ProductDetails>> getProductsByCategoryInJapanese(
      int c, String s, int page) async {
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
    var url =
        Uri.parse("${Constants.baseUrl}/v1/products?c=$c&s=$s&page=$page");

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
          // var unitType = product["unitTypes"][0];

          products.add(ProductDetails(
            // id: product["id"],
            name: product["japaneseName"] ?? "Japanese name not availiable",
            description: product["japaneseDescription"] ??
                "Japanese description not availiable",
            categoryName: product["category"]["japanese_name"] ??"Japanese name not availiable",
            stockQuantity: product[
                "unitStock"], // Accessing stockQuantity from unitTypes[0]
            price:
                double.parse(product["unitPrice"]), // Parsing price as a double
            isAvailable: product["isAvailable"],
            imageUrl: product["unitImages"]
                [0], // Accessing isAvailable from unitTypes[0]
            sku: product["sku"],
            images: product["unitImages"] ?? [],
          ));
        }
        logger.log("get products by category in japanese called");
        logger.log("japaneseproducts: $products");
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
  Future<ProductDetails> getProductDetailsById(String productId) async {
    // Get the saved token from SharedPreferences
    String? token = await SharedPrefLoggedinState.getAccessToken();

    // If no token is found, return an error
    if (token == null) {
      throw "User not authenticated. Please log in first.";
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

      // logger.log("Response Status Code: ${response.statusCode}");
      // logger.log("Response Body: $responseBody");

      Map<String, dynamic> jsonResponse = json.decode(responseBody);
      // logger.log("jsonResponse: $jsonResponse");

      if (response.statusCode == 200) {
        // return {"success": true, "data": jsonResponse};
        return ProductDetails(
            name: jsonResponse["product"]["name"],
            description: jsonResponse["product"]["description"] ??
                "Product description not availiable",
            categoryName: jsonResponse["product"]["category"]["name"],
            imageUrl: jsonResponse["product"]["unitImages"][0],
            stockQuantity: jsonResponse["product"]["unitStock"],
            price: double.parse(jsonResponse["product"]["unitPrice"]),
            isAvailable: jsonResponse["product"]["isUnitAvailable"],
            images: jsonResponse["product"]["unitImages"] ?? [],
            sku: jsonResponse["product"]["sku"]);
      } else {
        throw jsonResponse["message"] ?? "Failed to fetch product details";
      }
    } catch (e) {
      logger.log("Get Product by ID Error: $e");
      rethrow;
    }
  }

  Future<ProductDetails> getProductDetailsinJapaneseById(
      String productId) async {
    // Get the saved token from SharedPreferences
    String? token = await SharedPrefLoggedinState.getAccessToken();

    // If no token is found, return an error
    if (token == null) {
      throw "User not authenticated. Please log in first.";
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

      // logger.log("Response Status Code: ${response.statusCode}");
      // logger.log("Response Body: $responseBody");

      Map<String, dynamic> jsonResponse = json.decode(responseBody);
      // logger.log("jsonResponse: $jsonResponse");

      if (response.statusCode == 200) {
        // return {"success": true, "data": jsonResponse};
        return ProductDetails(
            name: jsonResponse["product"]["japaneseName"] ??
                "Not entered by admin",
            description: jsonResponse["product"]["japaneseDescription"] ??
                "Japanese description not availiable",
            categoryName: jsonResponse["product"]["category"]
                    ["japanese_name"] ??
                "Category not set in japanese",
            imageUrl: jsonResponse["product"]["unitImages"][0],
            stockQuantity: jsonResponse["product"]["unitStock"],
            price: double.parse(jsonResponse["product"]["unitPrice"]),
            isAvailable: jsonResponse["product"]["isUnitAvailable"],
            images: jsonResponse["product"]["unitImages"] ?? [],
            sku: jsonResponse["product"]["sku"]);
      } else {
        throw jsonResponse["message"] ?? "Failed to fetch product details";
      }
    } catch (e) {
      logger.log("Get Product by ID Error: $e");
      rethrow;
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
        String id = categoryJson['id'];
        //   ),
        categories.add(ProductCategory(
          id: int.parse(id),
          name: categoryJson['name'],
          productsCount: categoryJson['productsCount'],
          categoryImage: categoryJson["image"] ?? "no image",
          subCategories: (categoryJson["subcategories"] as List?)
                  ?.map((subCatJson) => SubCategory(
                        id: int.parse(subCatJson['id']),
                        name: subCatJson['name'],
                        productsCount: subCatJson['productsCount'],
                        categoryImage: subCatJson['image'] ?? "no image",
                      ))
                  .toList() ??
              [], // Fallback to empty list
        ));
      }
      logger.log("get all categories without all api called");
      // logger.log("categories: $categories");
      return categories;
    } else {
      throw Exception(jsonResponse['message'] ?? 'Failed to fetch categories');
    }
  }

  Future<List<ProductCategory>> getProductCategoriesinJapanese() async {
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
        String id = categoryJson['id'];
        //   ),
        categories.add(ProductCategory(
          id: int.parse(id),
          name:
              categoryJson['japaneseName'] ?? ["Japanese name not availiable"],
          productsCount: categoryJson['productsCount'],
          categoryImage: categoryJson["image"] ?? "no image",
          subCategories: (categoryJson["subcategories"] as List?)
                  ?.map((subCatJson) => SubCategory(
                        id: int.parse(subCatJson['id']),
                        name: subCatJson['japaneseName'] ??
                            ["Japanese name not availiable"],
                        productsCount: subCatJson['productsCount'],
                        categoryImage: subCatJson['image'] ?? "no image",
                      ))
                  .toList() ??
              [], // Fallback to empty list
        ));
      }
      logger.log("get all categories without all api called");
      // logger.log("categories: $categories");
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

// // Function to get image as response
//   Future<Uint8List> getCategoryImageByFilename(String filename) async {
//     // Get the saved token from SharedPreferences
//     String? token = await SharedPrefLoggedinState.getAccessToken();

//     // If no token is found, return an error
//     if (token == null) {
//       throw Exception("User not authenticated. Please log in first.");
//     }

//     // Headers with Authorization token
//     var headers = {
//       'Accept': 'application/json',
//       'Authorization': 'Bearer $token', // Adding token in the header
//     };

//     // Constructing the URL to fetch image by filename
//     var url =
//         Uri.parse("${Constants.baseUrl}/v1/product-categories/img/$filename");

//     var request = http.Request('GET', url);
//     request.headers.addAll(headers);

//     try {
//       http.StreamedResponse response = await request.send();

//       logger.log("Response Status Code: ${response.statusCode}");

//       if (response.statusCode == 200) {
//         // Getting image data as bytes
//         Uint8List imageData = await response.stream.toBytes();
//         return imageData;
//       } else {
//         throw Exception('Failed to fetch image');
//       }
//     } catch (e) {
//       logger.log("Get Image Error: $e");
//       throw Exception('Failed to fetch image');
//     }
//   }

  Future<Map<String, dynamic>> createOrders(
      int shippingLocationId, List<Map<String, dynamic>> orders) async {
    String? token = await SharedPrefLoggedinState.getAccessToken();
    logger.log("orders: ${orders.toString()}");

    if (token == null) {
      String tokenErorMessage = "User not authenticated. Please login first.";
      throw tokenErorMessage;
    }

    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var url = Uri.parse(
        "${Constants.createOrderUrl}?shippingLocationId=$shippingLocationId");

    var request = http.Request('POST', url);

    // Pass the list of orders in the request body
    request.body = json.encode({
      "products": orders, // Use the passed orders list here
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
      if (jsonResponse["message"] is String) {
        String errorMessage = jsonResponse["message"];
        logger.log(errorMessage);
        throw errorMessage;
      } else {
        String errorMessage = jsonResponse["message"]["stock"][0].toString();
        logger.log(errorMessage);
        throw errorMessage;
      }
    }
  }

  Future<List<OrderModel>> getAllMyOrders(int page) async {
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

    var url = Uri.parse("${Constants.getMyAlloderdUrl}?page=$page");

    var request = http.Request('GET', url);
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    String responseBody = await response.stream.bytesToString();
    // logger.log(responseBody.toString());
    // logger.log("status code: ${response.statusCode}");
    Map<String, dynamic> jsonResponse = json.decode(responseBody);

    if (response.statusCode == 200) {
      List<dynamic> ordersJson = jsonResponse["data"];
      List<OrderModel> orders = [];

      for (var order in ordersJson) {
        int totalQuantity = 0;
        double totalAmount = 0.0;
        List<OrderProductDetailModel> products =
            []; // List to hold CartModel objects

        for (var product in order["products"]) {
          totalQuantity += product["quantity"] as int;
          totalAmount += double.parse(product["amount"].toString());

          // Create CartModel object directly
          products.add(OrderProductDetailModel(
            // Use a default value if "id" is missing
            name: product["name"],
            price: double.parse(product["price"].toString()),
            category: product["category"]["name"],
            imagePath: product["image"] ??
                "N/A", // Use a default value if "imagePath" is missing
            quantity: product["quantity"],
          ));
        }

        orders.add(OrderModel(
          orderNo: order["key"],
          totalAmount:
              totalAmount.toStringAsFixed(2), // Ensures 2 decimal places
          date: order["createdAt"],
          totalQuantity: totalQuantity,
          status: order["status"],
          products: products, // Include the list of CartModel
        ));
      }
      logger.log("get all order api called");
      // logger.log("orders: ${orders.toString()}");
      return orders;
    } else {
      String errorMessage = "Failed to get orders";
      logger.log(errorMessage);
      throw errorMessage;
    }
  }

  Future<List<OrderModel>> getAllMyOrdersByStatus(
      int page, String status) async {
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

    var url = Uri.parse("${Constants.getMyAlloderdUrl}?page=$page&s=$status");

    var request = http.Request('GET', url);
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    String responseBody = await response.stream.bytesToString();
    // logger.log(responseBody.toString());
    // logger.log("status code: ${response.statusCode}");
    Map<String, dynamic> jsonResponse = json.decode(responseBody);

    if (response.statusCode == 200) {
      List<dynamic> ordersJson = jsonResponse["data"];
      List<OrderModel> orders = [];

      for (var order in ordersJson) {
        int totalQuantity = 0;
        double totalAmount = 0.0;
        List<OrderProductDetailModel> products =
            []; // List to hold CartModel objects

        for (var product in order["products"]) {
          totalQuantity += product["quantity"] as int;
          totalAmount += double.parse(product["amount"].toString());

          // Create CartModel object directly
          products.add(OrderProductDetailModel(
            // Use a default value if "id" is missing
            name: product["name"],
            price: double.parse(product["price"].toString()),
            category: product["category"]["name"],
            imagePath: product["image"] ??
                "N/A", // Use a default value if "imagePath" is missing
            quantity: product["quantity"],
          ));
        }

        orders.add(OrderModel(
          orderNo: order["key"],
          totalAmount:
              totalAmount.toStringAsFixed(2), // Ensures 2 decimal places
          date: order["createdAt"],
          totalQuantity: totalQuantity,
          status: order["status"],
          products: products, // Include the list of CartModel
        ));
      }
      logger.log("get all order api called");
      // logger.log("orders: ${orders.toString()}");
      return orders;
    } else {
      String errorMessage = "Failed to get orders";
      logger.log(errorMessage);
      throw errorMessage;
    }
  }

  Future<List<OrderModel>> getAllMyOrdersByDate(
      int page, String startDate, String endDate) async {
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

    var url = Uri.parse(
        "${Constants.getMyAlloderdUrl}?page=$page&sd=$startDate&ed=$endDate");

    var request = http.Request('GET', url);
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    String responseBody = await response.stream.bytesToString();
    // logger.log(responseBody.toString());
    // logger.log("status code: ${response.statusCode}");
    Map<String, dynamic> jsonResponse = json.decode(responseBody);

    if (response.statusCode == 200) {
      List<dynamic> ordersJson = jsonResponse["data"];
      List<OrderModel> orders = [];

      for (var order in ordersJson) {
        int totalQuantity = 0;
        double totalAmount = 0.0;
        List<OrderProductDetailModel> products =
            []; // List to hold CartModel objects

        for (var product in order["products"]) {
          totalQuantity += product["quantity"] as int;
          totalAmount += double.parse(product["amount"].toString());

          // Create CartModel object directly
          products.add(OrderProductDetailModel(
            // Use a default value if "id" is missing
            name: product["name"],
            price: double.parse(product["price"].toString()),
            category: product["category"]["name"],
            imagePath: product["image"] ??
                "N/A", // Use a default value if "imagePath" is missing
            quantity: product["quantity"],
          ));
        }

        orders.add(OrderModel(
          orderNo: order["key"],
          totalAmount:
              totalAmount.toStringAsFixed(2), // Ensures 2 decimal places
          date: order["createdAt"],
          totalQuantity: totalQuantity,
          status: order["status"],
          products: products, // Include the list of CartModel
        ));
      }
      logger.log("get all order api called");
      // logger.log("orders: ${orders.toString()}");
      return orders;
    } else {
      String errorMessage = "Failed to get orders";
      logger.log(errorMessage);
      throw errorMessage;
    }
  }

  Future<List<OrderModel>> getAllMyOrdersByStatusAndDate(
      int page, String status, String startDate, String endDate) async {
    // logger.log("status: $status, start Date: $startDate, end Date: $endDate");
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

    var url = Uri.parse(
        "${Constants.getMyAlloderdUrl}?page=$page&s=$status&sd=$startDate&ed=$endDate");

    var request = http.Request('GET', url);
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    String responseBody = await response.stream.bytesToString();
    // logger.log(responseBody.toString());
    // logger.log("status code: ${response.statusCode}");
    Map<String, dynamic> jsonResponse = json.decode(responseBody);

    if (response.statusCode == 200) {
      List<dynamic> ordersJson = jsonResponse["data"];
      List<OrderModel> orders = [];

      for (var order in ordersJson) {
        int totalQuantity = 0;
        double totalAmount = 0.0;
        List<OrderProductDetailModel> products =
            []; // List to hold CartModel objects

        for (var product in order["products"]) {
          totalQuantity += product["quantity"] as int;
          totalAmount += double.parse(product["amount"].toString());

          // Create CartModel object directly
          products.add(OrderProductDetailModel(
            // Use a default value if "id" is missing
            name: product["name"],
            price: double.parse(product["price"].toString()),
            category: product["category"]["name"],
            imagePath: product["image"] ??
                "N/A", // Use a default value if "imagePath" is missing
            quantity: product["quantity"],
          ));
        }

        orders.add(OrderModel(
          orderNo: order["key"],
          totalAmount:
              totalAmount.toStringAsFixed(2), // Ensures 2 decimal places
          date: order["createdAt"],
          totalQuantity: totalQuantity,
          status: order["status"],
          products: products, // Include the list of CartModel
        ));
      }
      logger.log("get all order api called");
      // logger.log("orders: ${orders.toString()}");
      return orders;
    } else {
      String errorMessage = "Failed to get orders";
      logger.log(errorMessage);
      throw errorMessage;
    }
  }

  Future<OrderModel> getOrderByKey(String orderKey) async {
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
    if (response.statusCode == 200) {
      Map<String, dynamic> orderJson = jsonResponse["order"];
      List<OrderProductDetailModel> products = [];

      // Calculate total quantity and total amount
      int totalQuantity = 0;
      double totalAmount = 0.0;

      // Parse products
      for (var product in orderJson["products"]) {
        totalQuantity += product["quantity"] as int;
        totalAmount += double.parse(product["amount"].toString());

        products.add(OrderProductDetailModel(
          name: product["name"],
          category: product["category"]["name"],
          quantity: product["quantity"],
          price: double.parse(product["price"].toString()),
          imagePath: product["image"] ?? "N/A", // Default value if missing
        ));
      }

      // Create and return the InvoiceModel
      OrderModel invoice = OrderModel(
        orderNo: orderKey,
        totalAmount:
            totalAmount.toStringAsFixed(2), // Format to 2 decimal places
        date: orderJson["createdAt"],
        totalQuantity: totalQuantity,
        status: orderJson["status"],
        products: products,
      );
      // logger.log("orders: ${invoice.toString()}");
      return invoice;
    } else {
      String errorMessage = "Failed to fetch order details";
      logger.log(errorMessage);
      throw errorMessage;
    }
  }

  Future<List<InvoiceModel>> getAllInvoiceByStatusAndDate(
      int page, String paidStatus, String startDate, String endDate) async {
    logger
        .log("status: $paidStatus, start Date: $startDate, end Date: $endDate");
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

    var url = Uri.parse(
        "${Constants.getAllInvoiceUrl}?page=$page&p=$paidStatus&sd=$startDate&ed=$endDate");

    var request = http.Request('GET', url);
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    String responseBody = await response.stream.bytesToString();
    // logger.log(responseBody.toString());
    logger.log("status code: ${response.statusCode}");
    Map<String, dynamic> jsonResponse = json.decode(responseBody);
    // logger.log("$responseBody");

    if (response.statusCode == 200) {
      List<dynamic> invoicesJson = jsonResponse["data"];
      List<InvoiceModel> invoices = [];

      for (var invoice in invoicesJson) {
        List<OrderProductDetailModel> products = [];
        var order = invoice["order"];
        var shippingLocation = order["shippingLocation"];
        var receiver = shippingLocation["receiver"];

        // Process products
        for (var product in order["products"]) {
          products.add(OrderProductDetailModel(
            name: product["name"],
            price: double.parse(product["amount"].toString()),
            category: product["category"]["name"],
            imagePath: product["image"] ?? "N/A",
            quantity: product["quantity"],
          ));
        }

        // Calculate total quantity
        int totalQuantity = order["products"]
            .fold(0, (sum, product) => sum + product["quantity"]);

        invoices.add(InvoiceModel(
          invoiceNo: invoice["invoiceNo"],
          totalAmount: invoice["totalAmount"], // Use the provided totalAmount
          date: invoice["createdAt"],
          totalQuantity: totalQuantity,
          paidStatus: invoice["isPaid"].toString(),
          products: products,
          receiverName: receiver["name"],
          receiverPhone: receiver["phone"],
          receiverEmail: receiver["email"],
          receiverPrefecture: shippingLocation["prefecture"],
          receiverCity: shippingLocation["city"],
          receiverArea: shippingLocation["area"],
        ));
      }
      logger.log("invoices: $invoices");
      logger.log("get all invoice api called");
      return invoices;
    } else {
      String errorMessage = "Failed to get invoice";
      logger.log(errorMessage);
      throw errorMessage;
    }
  }

  Future<InvoiceModel> getInvoiceByInvoiceno(String invoiceNo) async {
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

    var url = Uri.parse("${Constants.baseUrl}/v1/my-invoices/$invoiceNo");
    logger.log("$url");

    var request = http.Request('GET', url);
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    String responseBody = await response.stream.bytesToString();

    Map<String, dynamic> jsonResponse = json.decode(responseBody);

    if (response.statusCode == 200) {
      var invoiceData = jsonResponse["invoice"]; // Access the invoice object
      var order = invoiceData["order"];
      var shippingLocation = order["shippingLocation"];
      var receiver = shippingLocation["receiver"];

      // Process products
      List<OrderProductDetailModel> products = [];
      for (var product in order["products"]) {
        products.add(OrderProductDetailModel(
          name: product["name"],
          price: double.parse(product["amount"].toString()),
          category: product["category"]["name"],
          imagePath: product["image"] ?? "N/A",
          quantity: product["quantity"],
        ));
      }

      // Calculate total quantity
      int totalQuantity = order["products"]
          .fold(0, (sum, product) => sum + product["quantity"]);

      InvoiceModel invoice = InvoiceModel(
        invoiceNo: invoiceData["invoiceNo"],
        totalAmount: invoiceData["totalAmount"],
        date: invoiceData["createdAt"],
        totalQuantity: totalQuantity,
        paidStatus: invoiceData["isPaid"].toString(),
        products: products,
        receiverName: receiver["name"],
        receiverPhone: receiver["phone"],
        receiverEmail: receiver["email"],
        receiverPrefecture: shippingLocation["prefecture"],
        receiverCity: shippingLocation["city"],
        receiverArea: shippingLocation["area"],
      );

      logger.log("invoice: $invoice");
      logger.log("get invoice by invoice no api called");
      return invoice; // Return single invoice instead of list
    } else {
      String errorMessage = "Failed to get invoice";
      logger.log(errorMessage);
      throw errorMessage;
    }
  }
}
