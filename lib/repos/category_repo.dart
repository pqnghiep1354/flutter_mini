import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category_model.dart';

class CategoryRepo {
  static const String _base = 'https://apiforlearning.zendvn.com/api/v2';

  static Future<List<Category>> getAll() async {
    final res = await http.get(Uri.parse('$_base/categories_news'));
    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      final List list = data is List ? data : (data['data'] ?? []);
      return list.map((e) => Category.fromJson(e)).toList();
    }
    throw Exception('Failed to load categories');
  }
}
