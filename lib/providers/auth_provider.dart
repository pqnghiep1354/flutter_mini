import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import '../repos/auth_repo.dart';

class AuthProvider extends ChangeNotifier {
  User? _user;
  String? _token;
  bool _isLoading = false;
  String? _error;

  User? get user => _user;
  String? get token => _token;
  bool get isLoggedIn => _token != null && _user != null;
  bool get isLoading => _isLoading;
  String? get error => _error;

  static const String _tokenKey = 'auth_token';

  /// Try auto-login from saved token
  Future<void> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final savedToken = prefs.getString(_tokenKey);
    if (savedToken == null) return;

    _isLoading = true;
    notifyListeners();
    try {
      _user = await AuthRepo.getCurrentUser(savedToken);
      _token = savedToken;
    } catch (_) {
      await prefs.remove(_tokenKey);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      final result = await AuthRepo.login(email, password);
      _token = result['access_token'] ?? result['token'];
      if (_token != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(_tokenKey, _token!);
        _user = await AuthRepo.getCurrentUser(_token!);
      }
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString().replaceFirst('Exception: ', '');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> register({
    required String name,
    required String email,
    required String password,
    String? phone,
    String? address,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      await AuthRepo.register(
        name: name,
        email: email,
        password: password,
        phone: phone,
        address: address,
      );
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString().replaceFirst('Exception: ', '');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    if (_token != null) {
      try {
        await AuthRepo.logout(_token!);
      } catch (_) {}
    }
    _user = null;
    _token = null;
    _error = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
