import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/category_model.dart';
import '../repos/category_repo.dart';

class SettingsProvider extends ChangeNotifier {
  final Set<int> _hiddenCategoryIds = {};
  bool _loaded = false;

  // ── Category fetching state ──
  List<Category> categories = [];
  bool isCategoriesLoading = false;
  String? categoriesError;

  static const String _key = 'hidden_category_ids';

  Set<int> get hiddenCategoryIds => _hiddenCategoryIds;

  bool isCategoryVisible(int categoryId) {
    return !_hiddenCategoryIds.contains(categoryId);
  }

  Future<void> loadSettings() async {
    if (_loaded) return;
    final prefs = await SharedPreferences.getInstance();
    final ids = prefs.getStringList(_key) ?? [];
    _hiddenCategoryIds.addAll(ids.map(int.parse));
    _loaded = true;
    notifyListeners();
  }

  /// Gọi API lấy danh sách categories
  Future<void> loadCategories() async {
    isCategoriesLoading = true;
    categoriesError = null;
    notifyListeners();
    try {
      categories = await CategoryRepo.getAll();
    } catch (e) {
      categoriesError = e.toString();
    } finally {
      isCategoriesLoading = false;
      notifyListeners();
    }
  }

  Future<void> toggleCategory(int categoryId) async {
    if (_hiddenCategoryIds.contains(categoryId)) {
      _hiddenCategoryIds.remove(categoryId);
    } else {
      _hiddenCategoryIds.add(categoryId);
    }
    notifyListeners();
    await _save();
  }

  Future<void> showAll() async {
    _hiddenCategoryIds.clear();
    notifyListeners();
    await _save();
  }

  Future<void> hideAll(List<int> allIds) async {
    _hiddenCategoryIds.addAll(allIds);
    notifyListeners();
    await _save();
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
        _key, _hiddenCategoryIds.map((id) => id.toString()).toList());
  }
}
