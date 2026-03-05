import 'package:flutter/material.dart';
import '../models/article_model.dart';
import '../repos/article_repo.dart';

class CategoryArticlesProvider extends ChangeNotifier {
  List<Article> articles = [];
  bool isLoading = false;
  bool isLoadingMore = false;
  bool isGrid = true;
  bool hasMore = true;
  String? error;

  int _currentPage = 1;
  static const int _pageSize = 10;
  int? _categoryId;

  Future<void> loadArticles(int categoryId) async {
    _categoryId = categoryId;
    _currentPage = 1;
    hasMore = true;
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      articles = await ArticleRepo.getByCategory(
        categoryId,
        limit: _pageSize,
        page: _currentPage,
      );
      hasMore = articles.length >= _pageSize;
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadMore() async {
    if (isLoadingMore || !hasMore || _categoryId == null) return;

    isLoadingMore = true;
    notifyListeners();
    try {
      _currentPage++;
      final newArticles = await ArticleRepo.getByCategory(
        _categoryId!,
        limit: _pageSize,
        page: _currentPage,
      );
      if (newArticles.isEmpty) {
        hasMore = false;
      } else {
        articles.addAll(newArticles);
        hasMore = newArticles.length >= _pageSize;
      }
    } catch (e) {
      _currentPage--; // revert on error
      error = e.toString();
    } finally {
      isLoadingMore = false;
      notifyListeners();
    }
  }

  void toggleView() {
    isGrid = !isGrid;
    notifyListeners();
  }
}
