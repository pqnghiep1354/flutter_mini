import 'package:flutter/material.dart';
import '../models/article_model.dart';
import '../repos/article_repo.dart';

class ArticleDetailProvider extends ChangeNotifier {
  Article? article;
  List<Article> related = [];
  bool isLoading = false;
  String? error;

  Future<void> loadDetail(int articleId) async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      final results = await Future.wait([
        ArticleRepo.getDetail(articleId),
        ArticleRepo.getRelated(articleId, limit: 5),
      ]);
      article = results[0] as Article;
      related = results[1] as List<Article>;
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
