import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class AuthRepo {
  static const String _base = 'https://apiforlearning.zendvn.com/api/v2';

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
}
