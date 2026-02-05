import 'dart:convert';

import 'package:hackathon_app/models/sub_task.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TodoService {
  // static const String baseUrl = "http://192.168.18.19:8000";
  // static const String baseUrl = "https://hackathonapp-production-5ce0.up.railway.app";
  static const String baseUrl = "http://10.0.2.2:8000";

  /// GET todos
  static Future<List<Map<String, dynamic>>> fetchTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("access_token");

    final response = await http.get(
      Uri.parse("$baseUrl/todos/"), // ✅ BENAR
      headers: {"Authorization": "Bearer $token", "Accept": "application/json"},
    );

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(jsonDecode(response.body));
    }

    throw Exception("Failed to load todos");
  }

  /// POST todo
  static Future<bool> addTodo({
    required String title,
    required String duration,
    required DateTime startTime,
    String? reminder,
    required List<SubTask> subTasks,
  }) async {
    final body = {
      "title": title,
      "duration": duration,
      "start_time": startTime.toIso8601String(),
      "reminder": reminder,
      "subtasks": subTasks.map((e) => e.toJson()).toList(),
    };

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("access_token");

    final response = await http.post(
      Uri.parse("$baseUrl/todos/"), // 🔥 INI KUNCI
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode(body),
    );

    return response.statusCode == 200 || response.statusCode == 201;
  }

  /// PATCH todo
  static Future<bool> toggleTodo(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("access_token");

    final response = await http.patch(
      Uri.parse("$baseUrl/todos/$id"), // ✅ FIX
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    return response.statusCode == 200;
  }

  /// DELETE todo
  static Future<bool> deleteTodo(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("access_token");

    final response = await http.delete(
      Uri.parse("$baseUrl/todos/$id"), // ✅ FIX
      headers: {"Authorization": "Bearer $token"},
    );

    return response.statusCode == 204;
  }
}
