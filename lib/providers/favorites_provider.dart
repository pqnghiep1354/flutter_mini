import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesProvider extends ChangeNotifier {
  final Set<int> _favoriteIds = {};
  bool _loaded = false;

  static const String _key = 'favorite_article_ids';

  Set<int> get favoriteIds => _favoriteIds;

  bool isFavorite(int articleId) => _favoriteIds.contains(articleId);

  Future<void> loadFavorites() async {
    if (_loaded) return;
    final prefs = await SharedPreferences.getInstance();
    final ids = prefs.getStringList(_key) ?? [];
    _favoriteIds.addAll(ids.map(int.parse));
    _loaded = true;
    notifyListeners();
  }

  Future<void> toggleFavorite(int articleId) async {
    if (_favoriteIds.contains(articleId)) {
      _favoriteIds.remove(articleId);
    } else {
      _favoriteIds.add(articleId);
    }
    notifyListeners();
    await _save();
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
        _key, _favoriteIds.map((id) => id.toString()).toList());
  }
}
