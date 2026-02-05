import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // static const String baseUrl ="https://hackathonapp-production-5ce0.up.railway.app"; // Flutter Web
  static const String baseUrl = "http://10.0.2.2:8000"; // Flutter Web
  // static const String baseUrl = "http://10.168.12.193:8000";

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
