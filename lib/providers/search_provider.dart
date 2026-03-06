import 'package:flutter/material.dart';
import '../models/article_model.dart';
import '../repos/article_repo.dart';

/// Provider quản lý trạng thái tìm kiếm bài viết
///
/// Luồng dữ liệu:
///   User nhập keyword
///   → SearchProvider.search(keyword)
///   → ArticleRepo.search(keyword)
///   → API trả về List<Article>
///   → cập nhật results, notifyListeners()
///   → UI tự rebuild hiển thị kết quả
class SearchProvider extends ChangeNotifier {
  // ── State (trạng thái) ──

  /// Danh sách kết quả tìm kiếm
  List<Article> results = [];

  /// Đang loading hay không
  bool isLoading = false;

  /// Lỗi (nếu có)
  String? error;

  /// Còn dữ liệu để tải thêm không
  bool hasMore = true;

  /// Từ khóa hiện tại
  String _keyword = '';

  /// Trang hiện tại (dùng cho pagination)
  int _currentPage = 1;

  /// Số bài viết mỗi trang
  static const int _pageSize = 10;

  // ── Methods (phương thức xử lý) ──

  /// Tìm kiếm mới — reset trang về 1, xóa kết quả cũ
  Future<void> search(String keyword) async {
    // Bỏ qua nếu keyword rỗng
    if (keyword.trim().isEmpty) {
      clear();
      return;
    }

    // Reset trạng thái cho lần tìm mới
    _keyword = keyword.trim();
    _currentPage = 1;
    hasMore = true;
    isLoading = true;
    error = null;
    results = [];
    notifyListeners(); // Báo UI: đang loading

    try {
      // Gọi API tìm kiếm
      final data = await ArticleRepo.search(
        _keyword,
        limit: _pageSize,
        page: _currentPage,
      );

      // Cập nhật kết quả
      results = data;

      // Nếu số bài < pageSize → hết dữ liệu
      hasMore = data.length >= _pageSize;
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners(); // Báo UI: đã xong
    }
  }

  /// Tải thêm trang tiếp theo (pagination)
  Future<void> loadMore() async {
    // Bỏ qua nếu đang loading hoặc hết dữ liệu
    if (isLoading || !hasMore) return;

    isLoading = true;
    notifyListeners();

    try {
      _currentPage++;
      final data = await ArticleRepo.search(
        _keyword,
        limit: _pageSize,
        page: _currentPage,
      );

      if (data.isEmpty) {
        hasMore = false;
      } else {
        results.addAll(data); // Thêm vào cuối danh sách
        hasMore = data.length >= _pageSize;
      }
    } catch (e) {
      _currentPage--; // Lùi lại nếu lỗi
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// Xóa toàn bộ kết quả
  void clear() {
    results = [];
    _keyword = '';
    _currentPage = 1;
    hasMore = true;
    error = null;
    isLoading = false;
    notifyListeners();
  }
}
