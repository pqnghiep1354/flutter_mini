import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future<bool> loginWithGoogle() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      _user = await AuthRepo.signInWithGoogle();
      final prefs = await SharedPreferences.getInstance();
      _token = prefs.getString('token'); // or from memory if AuthRepo saves it
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

  Future<bool> loginAnonymously() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      _token = 'anonymous_token';
      _user = User(
        id: -1,
        name: 'Guest User',
        email: 'anonymous@guest.com',
      );
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'Failed to sign in anonymously';
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

      // Save user profile to Firestore using email as the document ID
      try {
        await FirebaseFirestore.instance.collection('users').doc(email).set({
          'name': name,
          'email': email,
          'phone': phone,
          'address': address,
          'createdAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
      } catch (e) {
        print('Error saving user profile to Firestore: $e');
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
    await AuthRepo.signOutWithGoogle();
    notifyListeners();
  }

  /// Cập nhật thông tin user (name, phone, address)
  /// Gọi AuthRepo → API, rồi cập nhật _user trong app
  Future<bool> updateProfile({
    required String name,
    String? phone,
    String? address,
  }) async {
    if (_token == null) return false;
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      // Gọi API cập nhật
      _user = await AuthRepo.updateProfile(
        _token!,
        name: name,
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

  /// Đổi mật khẩu
  Future<bool> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    if (_token == null) return false;
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      await AuthRepo.changePassword(
        _token!,
        oldPassword: oldPassword,
        newPassword: newPassword,
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

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
