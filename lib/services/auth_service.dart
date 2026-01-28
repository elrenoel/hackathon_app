import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String baseUrl = "http://localhost:8000";
  // static const String baseUrl = "http://192.168.1.4:8000";
  // kalau HP fisik → ganti IP laptop

  static Future<String?> register(
    String name,
    String email,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse("$baseUrl/auth/register"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"name": name, "email": email, "password": password}),
    );

    if (response.statusCode == 201) {
      // 🔥 AUTO LOGIN
      final loginSuccess = await login(email, password);
      if (loginSuccess) return null;
      return "Register berhasil, tapi login gagal";
    }

    if (response.statusCode == 400) {
      final data = jsonDecode(response.body);
      return data["detail"]; // "Email sudah terdaftar"
    }

    if (response.statusCode == 422) {
      return "Data tidak valid (cek email & password)";
    }

    return "Register gagal";
  }

  static Future<bool> login(String email, String password) async {
    final response = await http.post(
      Uri.parse("$baseUrl/auth/login"),
      headers: {"Content-Type": "application/x-www-form-urlencoded"},
      body: {"username": email, "password": password},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("access_token", data["access_token"]);
      return true;
    }
    return false;
  }

  static Future<Map<String, dynamic>?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("access_token");
    if (token == null) return null;

    final response = await http.get(
      Uri.parse("$baseUrl/protected"),
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return null;
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("access_token");
  }
}
