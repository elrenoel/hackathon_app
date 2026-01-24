import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TodoService {
  static const String baseUrl = "http://localhost:8000";
  // Android emulator → pakai 10.0.2.2

  /// GET todos
  static Future<List<Map<String, dynamic>>> fetchTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("access_token");

    if (token == null) throw Exception("Not authenticated");

    final response = await http.get(
      Uri.parse("$baseUrl/todos/todos"),
      headers: {"Authorization": "Bearer $token", "Accept": "application/json"},
    );

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(jsonDecode(response.body));
    }

    throw Exception("Failed to load todos");
  }

  /// POST todo (OPSI A)
  static Future<bool> addTodo({
    required String title,
    required String duration,
    required DateTime startTime,
    String? reminder,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("access_token");

    if (token == null) throw Exception("Not authenticated");

    final response = await http.post(
      Uri.parse("$baseUrl/todos/todos"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "title": title,
        "duration": duration,
        "start_time": startTime.toIso8601String(),
        "reminder": reminder,
      }),
    );

    return response.statusCode == 200 || response.statusCode == 201;
  }
}
