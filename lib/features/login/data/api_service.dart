import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:logger/logger.dart';

class ApiService {
  final logger = Logger();

  Future<bool> login(String email, String password) async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer 6|yqwRA9g7KMUwPG5sqSAg2ujOMrNJLiI0wJ5jJ0c0b73ced75'
    };

    var request = http.Request(
        'POST', Uri.parse('https://oms.sysqube.com.np/api/v1/login'));

    request.body = json.encode({
      "email": email,
      "password": password,
      "device": "android 20344"
    });

    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();
      String responseBody = await response.stream.bytesToString();

      logger.i("Response Status Code: ${response.statusCode}");
      logger.i("Response Body: $responseBody");

      if (response.statusCode == 200) {
        return true; // Login successful
      } else {
        return false; // Login failed
      }
    } catch (e) {
      logger.e("Error: $e");
      return false;
    }
  }
}
