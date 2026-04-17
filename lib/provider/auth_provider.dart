import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthProvider extends ChangeNotifier {
  final _storage = FlutterSecureStorage();

  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  // 🔹 SIGN UP (first time)
  Future<bool> signUp(String id, String password) async {
    String? existingUser = await _storage.read(key: "user_id");

    if (existingUser != null) {
      return false; // User already exists
    }

    await _storage.write(key: "user_id", value: id);
    await _storage.write(key: "password", value: password);

    return true;
  }

  // 🔹 LOGIN (Sign In)
  Future<bool> login(String id, String password) async {
    String? storedId = await _storage.read(key: "user_id");
    String? storedPassword = await _storage.read(key: "password");

    if (id == storedId && password == storedPassword) {
      await _storage.write(key: "auth_token", value: "logged_in");

      _isLoggedIn = true;
      notifyListeners();
      return true;
    }

    return false;
  }

  // 🔹 CHECK LOGIN
  Future<void> checkLoginStatus() async {
    String? token = await _storage.read(key: "auth_token");
    _isLoggedIn = token != null;
    notifyListeners();
  }

  // 🔹 LOGOUT
  Future<void> logout() async {
    await _storage.delete(key: "auth_token");
    _isLoggedIn = false;
    notifyListeners();
  }
}