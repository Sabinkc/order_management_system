import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "http://localhost:8000/api";

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
    required String deviceName,
  }) async {
    final url = Uri.parse("$baseUrl/v1/login");
    final headers = {"Content-Type": "application/json"};
    final body = jsonEncode({
      "email": email,
      "password": password,
      "device_name": deviceName,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        return {"success": true, "data": jsonDecode(response.body)};
      } else {
        return {"success": false, "error": jsonDecode(response.body)["error"]};
      }
    } catch (e) {
      return {"success": false, "error": "An error occurred: $e"};
    }
  }
}
