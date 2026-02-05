import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hackathon_app/core/storage/token_storage.dart';

class AuthService {
  // static const String baseUrl ="https://hackathonapp-production-5ce0.up.railway.app";
  // static const String baseUrl = "http://10.168.12.193:8000";
  static const String baseUrl = "http://10.0.2.2:8000"; // Flutter Web
  // kalau HP fisik → ganti IP laptop

  static const _tokenKey = 'access_token';

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  static Map<String, String> _headers() => {'Content-Type': 'application/json'};

  /// ================================
  /// STEP 1 — SEND OTP (name + email)
  /// ================================
  static Future<String?> sendOtp({
    required String name,
    required String email,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/register/send-otp'),
        headers: _headers(),
        body: jsonEncode({'name': name, 'email': email}),
      );

      print("STATUS: ${response.statusCode}");
      print("BODY RAW: ${response.body}");

      // kalau server error
      if (response.statusCode >= 500) {
        return "Server error. Coba lagi nanti";
      }

      // cek apakah JSON valid
      dynamic data;
      try {
        data = jsonDecode(response.body);
      } catch (e) {
        return "Server response invalid";
      }

      if (response.statusCode == 200 && data["success"] == true) {
        return null;
      }

      return data["detail"] ?? data["message"] ?? "Failed send OTP";
    } catch (e) {
      print("ERROR SEND OTP: $e");
      return "Network error";
    }
  }

  /// ================================
  /// STEP 2 — VERIFY OTP
  /// ================================
  static Future<String?> verifyOtp({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/register/verify-otp'),
        headers: _headers(),
        body: jsonEncode({'email': email, 'otp': otp}),
      );

      if (response.statusCode == 200) {
        return null;
      }

      final data = jsonDecode(response.body);
      return data['detail'] ?? 'Invalid OTP';
    } catch (e) {
      return 'Network error';
    }
  }

  /// ================================
  /// STEP 3 — SET PASSWORD (FINAL)
  /// ================================
  static Future<String?> setPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/register/set-password'),
        headers: _headers(),
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('access_token', data['access_token']);
        await prefs.setString('token_type', data['token_type']);

        return null;
      }

      final data = jsonDecode(response.body);
      return data['detail'] ?? 'Failed to create account';
    } catch (e) {
      return 'Network error';
    }
  }

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
      await TokenStorage.saveToken(data["access_token"]);
      return true;
    }

    return false;
  }

  static Future<Map<String, dynamic>?> getCurrentUser() async {
    try {
      final token = await getToken();
      if (token == null) return null;

      final response = await http.get(
        Uri.parse('$baseUrl/auth/me'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }

      return null;
    } catch (_) {
      return null;
    }
  }

  static Future<String?> submitProfiling({
    required List<Map<String, int>> answers,
  }) async {
    try {
      final token = await getToken();

      final response = await http.post(
        Uri.parse('$baseUrl/auth/profiling'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'answers': answers}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['persona']; // 🔥 INI KUNCI
      }

      return null;
    } catch (e) {
      // ignore: avoid_print
      print('ERROR: $e');
      return null;
    }
  }
}
