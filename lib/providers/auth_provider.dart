import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../core/storage/token_storage.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool _isLoggedIn = false;
  bool _isInitialized = false;

  bool get isLoading => _isLoading;
  bool get isLoggedIn => _isLoggedIn;
  bool get isInitialized => _isInitialized;

  AuthProvider() {
    checkAuth();
  }

  /// DIPANGGIL SAAT APP START
  Future<void> checkAuth() async {
    final token = await TokenStorage.getToken();
    _isLoggedIn = token != null;
    _isInitialized = true;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    final success = await AuthService.login(email, password);

    if (success) {
      _isLoggedIn = true;
    }

    _isLoading = false;
    notifyListeners();
    return success;
  }

  Future<void> logout() async {
    await TokenStorage.deleteToken();
    _isLoggedIn = false;
    notifyListeners();
  }
}
