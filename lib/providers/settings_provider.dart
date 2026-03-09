import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/category_model.dart';
import '../repos/category_repo.dart';
import '../providers/auth_provider.dart';

class SettingsProvider extends ChangeNotifier {
  final AuthProvider _authProvider;
  final Set<int> _hiddenCategoryIds = {};

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ── Category fetching state ──
  List<Category> categories = [];
  bool isCategoriesLoading = false;
  String? categoriesError;

  SettingsProvider(this._authProvider) {
    _authProvider.addListener(loadSettings);
  }

  Set<int> get hiddenCategoryIds => _hiddenCategoryIds;

  bool isCategoryVisible(int categoryId) {
    return !_hiddenCategoryIds.contains(categoryId);
  }

  String get _currentDocId {
    final email = _authProvider.user?.email;
    if (email != null && email.isNotEmpty) return email;
    final id = _authProvider.user?.id;
    if (id != null && id != -1 && id != 0) return id.toString();
    return '';
  }

  Future<void> loadSettings() async {
    final docId = _currentDocId;
    if (docId.isEmpty) {
      _hiddenCategoryIds.clear();
      notifyListeners();
      return;
    }

    try {
      final docSnapshot = await _db.collection('users').doc(docId).get();
      if (docSnapshot.exists) {
        final data = docSnapshot.data();
        if (data != null && data.containsKey('hiddenCategoryIds')) {
          List<dynamic> hiddenList = data['hiddenCategoryIds'];
          _hiddenCategoryIds.clear();
          _hiddenCategoryIds.addAll(hiddenList.map((e) => e as int));
        } else {
          _hiddenCategoryIds.clear();
        }
      } else {
        _hiddenCategoryIds.clear();
      }
    } catch (e) {
      print("Lỗi khi load Settings: \$e");
    }

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
    final docId = _currentDocId;
    if (docId.isEmpty) return;

    try {
      await _db.collection('users').doc(docId).set({
        'hiddenCategoryIds': _hiddenCategoryIds.toList(),
      }, SetOptions(merge: true));
    } catch (e) {
      print("Lỗi khi save Settings: \$e");
    }
  }

  @override
  void dispose() {
    _authProvider.removeListener(loadSettings);
    super.dispose();
  }
}
