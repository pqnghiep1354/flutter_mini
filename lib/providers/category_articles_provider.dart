import 'package:flutter/material.dart';
import '../models/article_model.dart';
import '../repos/article_repo.dart';

class CategoryArticlesProvider extends ChangeNotifier {
  List<Article> articles = [];
  bool isLoading = false;
  bool isGrid = true;
  String? error;

  Future<void> loadArticles(int categoryId) async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      articles = await ArticleRepo.getByCategory(categoryId, limit: 20);
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void toggleView() {
    isGrid = !isGrid;
    notifyListeners();
  }
}
