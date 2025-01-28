import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "https://oms.sysqube.com.np/api";

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
    required String deviceName,
  }) async {
    final url = Uri.parse("$baseUrl/v1/login");
    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      'Authorization':
          'Bearer 2|7e2fZxXODoZpbRLACLTlanKkk8xrFiv46gUl6wtZ1ac3fe10',
    };
    final body = jsonEncode({
      "email": email,
      "password": password,
      "device_name": deviceName,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');
      print(deviceName);

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
