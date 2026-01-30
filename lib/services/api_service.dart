import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // static const String baseUrl = "http://127.0.0.1:8000"; // Flutter Web
  static const String baseUrl = "http://192.168.18.19:8000";

  static Future<List<dynamic>> fetchTodos() async {
    final res = await http.get(Uri.parse("$baseUrl/todos"));

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      return data["todos"];
    } else {
      throw Exception("Failed to load todos");
    }
  }
}
