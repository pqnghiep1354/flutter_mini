import 'package:flutter/material.dart';
import '../models/article_model.dart';
import '../models/category_model.dart';
import '../repos/article_repo.dart';
import '../repos/category_repo.dart';

class HomeProvider extends ChangeNotifier {
  List<Category> categories = [];
  List<Article> popularArticles = [];
  bool isLoading = false;
  String? error;

  Future<void> loadData() async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      final results = await Future.wait([
        CategoryRepo.getAll(),
        ArticleRepo.getPopular(limit: 6),
      ]);
      categories = results[0] as List<Category>;
      popularArticles = results[1] as List<Article>;
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
