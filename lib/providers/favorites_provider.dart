import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../providers/auth_provider.dart';

class FavoritesProvider extends ChangeNotifier {
  final AuthProvider _authProvider;
  Set<int> _favoriteIds = {};

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  FavoritesProvider(this._authProvider) {
    _loadFavorites();
    // Nghe sự thay đổi của auth_provider để nạp lại favorites tương ứng với user
    _authProvider.addListener(_loadFavorites);
  }

  Set<int> get favoriteIds => _favoriteIds;

  bool isFavorite(int articleId) {
    return _favoriteIds.contains(articleId);
  }

  String get _currentDocId {
    // Dùng email làm doc id (giống bên đăng ký), nếu không có thì dùng id
    final email = _authProvider.user?.email;
    if (email != null && email.isNotEmpty) return email;
    final id = _authProvider.user?.id;
    if (id != null && id != -1 && id != 0) return id.toString();
    return '';
  }

  Future<void> _loadFavorites() async {
    final docId = _currentDocId;
    if (docId.isEmpty) {
      _favoriteIds = {};
      notifyListeners();
      return;
    }

    try {
      final docSnapshot = await _db.collection('users').doc(docId).get();
      if (docSnapshot.exists) {
        final data = docSnapshot.data();
        if (data != null && data.containsKey('favorites')) {
          List<dynamic> favList = data['favorites'];
          _favoriteIds = favList.map((e) => e as int).toSet();
        } else {
          _favoriteIds = {};
        }
      } else {
        _favoriteIds = {};
      }
    } catch (e) {
      print("Lỗi khi load Favorites: \$e");
    }
    notifyListeners();
  }

  Future<void> toggleFavorite(int articleId) async {
    final docId = _currentDocId;
    if (docId.isEmpty) {
      return; // Yêu cầu đăng nhập
    }

    if (_favoriteIds.contains(articleId)) {
      _favoriteIds.remove(articleId);
    } else {
      _favoriteIds.add(articleId);
    }
    notifyListeners();

    try {
      await _db.collection('users').doc(docId).set({
        'favorites': _favoriteIds.toList(),
      }, SetOptions(merge: true));
    } catch (e) {
      print("Lỗi khi save Favorites: \$e");
    }
  }

  @override
  void dispose() {
    _authProvider.removeListener(_loadFavorites);
    super.dispose();
  }
}
