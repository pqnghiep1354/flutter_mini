import 'package:flutter/material.dart';
import '../models/article_model.dart';
import '../repos/article_repo.dart';

/// Provider quản lý trạng thái tạo bài viết (Admin)
///
/// Luồng dữ liệu:
///   Admin nhập thông tin bài viết (title, content, categoryId)
///   → AdminProvider.createArticle(token, ...)
///   → ArticleRepo.create(token, ...)
///   → API tạo bài
///   → notifyListeners() → UI cập nhật (success/error)
class AdminProvider extends ChangeNotifier {
  // ── State ──

  /// Đang gửi bài hay không
  bool isLoading = false;

  /// Lỗi (nếu có)
  String? error;

  /// Tạo thành công hay chưa
  bool success = false;

  /// Bài viết vừa tạo (dùng để hiển thị kết quả)
  Article? createdArticle;

  // ── Methods ──

  /// Tạo bài viết mới
  Future<bool> createArticle(
    String token, {
    required String title,
    required String description,
    required String content,
    required int categoryId,
    String? thumb,
  }) async {
    isLoading = true;
    error = null;
    success = false;
    notifyListeners(); // Báo UI: đang loading

    try {
      // Gọi API tạo bài viết
      createdArticle = await ArticleRepo.create(
        token,
        title: title,
        description: description,
        content: content,
        categoryId: categoryId,
        thumb: thumb,
      );

      success = true;
      isLoading = false;
      notifyListeners(); // Báo UI: thành công
      return true;
    } catch (e) {
      error = e.toString().replaceFirst('Exception: ', '');
      isLoading = false;
      notifyListeners(); // Báo UI: lỗi
      return false;
    }
  }

  /// Reset trạng thái để tạo bài mới
  void reset() {
    isLoading = false;
    error = null;
    success = false;
    createdArticle = null;
    notifyListeners();
  }
}
