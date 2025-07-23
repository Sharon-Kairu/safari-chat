// services/api_service.dart
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String baseUrl = "http://10.0.2.2:5000"; // Use 10.0.2.2 for Android emulator

  static Future<String> pingServer() async {
    final response = await http.get(Uri.parse("$baseUrl/ping"));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception("Failed to connect to backend");
    }
  }

  static Future<String> sendMessage(String message) async {
    final response = await http.post(
      Uri.parse("$baseUrl/chat"), // This should match your Flask route
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'message': message}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['reply'] ?? 'No response from server.';
    } else {
      throw Exception("Failed to get a valid response");
    }
  }
}
