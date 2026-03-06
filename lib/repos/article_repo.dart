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
    final res =
        await http.get(Uri.parse('$_base/articles/$id/related?limit=$limit'));
    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      final List list = data is List ? data : (data['data'] ?? []);
      return list.map((e) => Article.fromJson(e)).toList();
    }
    throw Exception('Failed to load related articles');
  }

  static Future<List<Article>> getPopular({int limit = 6}) async {
    final res =
        await http.get(Uri.parse('$_base/articles/popular?limit=$limit'));
    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      final List list = data is List ? data : (data['data'] ?? []);
      return list.map((e) => Article.fromJson(e)).toList();
    }
    throw Exception('Failed to load popular articles');
  }

  /// Tìm kiếm bài viết theo từ khóa
  /// API: GET /articles/search?q=keyword&limit=10&page=1
  static Future<List<Article>> search(
    String keyword, {
    int limit = 10,
    int page = 1,
  }) async {
    final res = await http.get(
      Uri.parse('$_base/articles/search?q=$keyword&limit=$limit&page=$page'),
    );
    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      final List list = data is List ? data : (data['data'] ?? []);
      return list.map((e) => Article.fromJson(e)).toList();
    }
    throw Exception('Failed to search articles');
  }

  /// Tạo bài viết mới
  /// API: POST /articles/create — cần Bearer token
  static Future<Article> create(
    String token, {
    required String title,
    required String description,
    required String content,
    required int categoryId,
    String? thumb,
  }) async {
    final body = <String, String>{
      'title': title,
      'description': description,
      'content': content,
      'category_id': categoryId.toString(),
    };
    if (thumb != null && thumb.isNotEmpty) body['thumb'] = thumb;

    final res = await http.post(
      Uri.parse('$_base/articles/create'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: body,
    );
    final data = json.decode(res.body);
    if (res.statusCode == 200 || res.statusCode == 201) {
      final d = data is Map<String, dynamic> && data.containsKey('data')
          ? data['data']
          : data;
      return Article.fromJson(d);
    }
    throw Exception(data['message'] ?? 'Failed to create article');
  }
}
