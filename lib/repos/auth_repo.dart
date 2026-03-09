import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/user_model.dart';

class AuthRepo {
  static String get _base => dotenv.get('API_BASE_URL',
      fallback: 'https://apiforlearning.zendvn.com/api/v2');

  static Future<Map<String, dynamic>> login(
      String email, String password) async {
    final res = await http.post(
      Uri.parse('$_base/auth/login'),
      headers: {'Accept': 'application/json'},
      body: {'email': email, 'password': password},
    );
    final data = json.decode(res.body);
    if (res.statusCode == 200) {
      return data;
    }
    throw Exception(data['message'] ?? 'Login failed');
  }

  static Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
    String? phone,
    String? address,
  }) async {
    final body = <String, String>{
      'name': name,
      'email': email,
      'password': password,
    };
    if (phone != null && phone.isNotEmpty) body['phone'] = phone;
    if (address != null && address.isNotEmpty) body['address'] = address;

    final res = await http.post(
      Uri.parse('$_base/users/register'),
      headers: {'Accept': 'application/json'},
      body: body,
    );
    final data = json.decode(res.body);
    if (res.statusCode == 200 || res.statusCode == 201) {
      return data;
    }
    throw Exception(data['message'] ?? 'Registration failed');
  }

  static Future<User> getCurrentUser(String token) async {
    final res = await http.get(
      Uri.parse('$_base/auth/me'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      final d = data is Map<String, dynamic> && data.containsKey('data')
          ? data['data']
          : data;
      return User.fromJson(d);
    }
    throw Exception('Failed to get user info');
  }

  static Future<void> logout(String token) async {
    await http.post(
      Uri.parse('$_base/auth/logout'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
  }

  /// Cập nhật thông tin user (name, phone, address)
  /// API: PUT /auth/update — cần Bearer token
  static Future<User> updateProfile(
    String token, {
    required String name,
    String? phone,
    String? address,
  }) async {
    final body = <String, String>{'name': name};
    if (phone != null) body['phone'] = phone;
    if (address != null) body['address'] = address;

    final res = await http.put(
      Uri.parse('$_base/auth/update'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: body,
    );
    final data = json.decode(res.body);
    if (res.statusCode == 200) {
      final d = data is Map<String, dynamic> && data.containsKey('data')
          ? data['data']
          : data;
      return User.fromJson(d);
    }
    throw Exception(data['message'] ?? 'Failed to update profile');
  }

  /// Đổi mật khẩu
  /// API: PUT /auth/change-password — cần Bearer token
  static Future<void> changePassword(
    String token, {
    required String oldPassword,
    required String newPassword,
  }) async {
    final res = await http.put(
      Uri.parse('$_base/auth/change-password'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: {
        'password_current': oldPassword,
        'password': newPassword,
        'password_confirmation': newPassword,
      },
    );
    final data = json.decode(res.body);
    if (res.statusCode == 200) return;
    String errorMessage = data['message'] ?? 'Failed to change password';
    if (data['errors'] != null && data['errors'] is Map) {
      final errors = data['errors'] as Map;
      if (errors.isNotEmpty) {
        errorMessage = errors.values.first[0].toString();
      }
    }
    throw Exception(errorMessage);
  }

  // ============================================================================
  // GOOGLE SIGN-IN
  // ============================================================================

  static final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  static bool _isGoogleInitialized = false;

  /// Đăng nhập bằng Google (kết hợp Firebase Auth & Backend API)
  static Future<User> signInWithGoogle() async {
    try {
      if (!_isGoogleInitialized) {
        await _googleSignIn.initialize();
        _isGoogleInitialized = true;
      }

      final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();

      // Không dùng await ở đây đối với pub version > 7.1.0
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;
      final String? idToken = googleAuth.idToken;

      if (idToken == null) {
        throw Exception('Failed to get Google ID Token.');
      }

      // -- 1. Đăng nhập vào Firebase (nếu ứng dụng dùng firebase_auth) --
      try {
        final firebaseCredential = firebase_auth.GoogleAuthProvider.credential(
          idToken: idToken,
        );
        await firebase_auth.FirebaseAuth.instance
            .signInWithCredential(firebaseCredential);
      } catch (firebaseErr) {
        print('Firebase sign in error: $firebaseErr');
      }

      // -- 2. Gửi idToken đến Backend API --
      final res = await http.post(
        Uri.parse('$_base/auth/google'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({'id_token': idToken}),
      );

      final data = json.decode(res.body);

      if (res.statusCode == 200) {
        // Lưu token do Backend cấp vào SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        if (data['token'] != null) {
          await prefs.setString('token', data['token']);
        } else if (data['access_token'] != null) {
          await prefs.setString('token', data['access_token']);
        }

        // Lấy thông tin user
        String tokenToUse = data['token'] ?? data['access_token'] ?? '';
        final user = await getCurrentUser(tokenToUse);
        return user;
      }

      throw Exception(data['message'] ?? 'Google login failed on backend');
    } catch (e) {
      throw Exception('Google sign-in failed: $e');
    }
  }

  /// Đăng xuất khỏi Google
  static Future<void> signOutWithGoogle() async {
    try {
      if (!_isGoogleInitialized) {
        await _googleSignIn.initialize();
        _isGoogleInitialized = true;
      }
      await _googleSignIn.signOut();
    } catch (e) {
      print('Google sign out error: $e');
    }
  }
}
