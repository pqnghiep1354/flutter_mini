import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article_model.dart';

class ArticleRepo {
  static const String _base = 'https://apiforlearning.zendvn.com/api/v2';

  static Future<List<Article>> getByCategory(int categoryId,
      {int limit = 20, int page = 1}) async {
    final res = await http.get(Uri.parse(
        '$_base/categories_news/$categoryId/articles?limit=$limit&page=$page'));
    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      final List list = data is List ? data : (data['data'] ?? []);
      return list.map((e) => Article.fromJson(e)).toList();
    }
    throw Exception('Failed to load articles');
  }

  static Future<Article> getDetail(int id) async {
    final res = await http.get(Uri.parse('$_base/articles/$id'));
    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      final d = data is Map<String, dynamic> && data.containsKey('data')
          ? data['data']
          : data;
      return Article.fromJson(d);
    }
    throw Exception('Failed to load article detail');
  }

  static Future<List<Article>> getRelated(int id, {int limit = 5}) async {
    final res = await http.get(Uri.parse('$_base/articles/$id/related?limit=$limit'));
    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      final List list = data is List ? data : (data['data'] ?? []);
      return list.map((e) => Article.fromJson(e)).toList();
    }
    throw Exception('Failed to load related articles');
  }

  static Future<List<Article>> getPopular({int limit = 6}) async {
    final res = await http.get(Uri.parse('$_base/articles/popular?limit=$limit'));
    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      final List list = data is List ? data : (data['data'] ?? []);
      return list.map((e) => Article.fromJson(e)).toList();
    }
    throw Exception('Failed to load popular articles');
  }
}
