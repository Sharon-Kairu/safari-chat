import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://10.0.2.2:5000"; // localhost for emulator

  static Future<String> pingServer() async {
    final response = await http.get(Uri.parse("$baseUrl/ping"));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception("Failed to connect to backend");
    }
  }
}
