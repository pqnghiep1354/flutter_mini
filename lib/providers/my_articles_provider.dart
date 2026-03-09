import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/article_model.dart';
import '../providers/auth_provider.dart';

class MyArticlesProvider extends ChangeNotifier {
  final AuthProvider _authProvider;
  List<Article> _articles = [];
  bool _isLoading = false;
  String? _error;

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  MyArticlesProvider(this._authProvider) {
    if (_authProvider.isLoggedIn) {
      loadMyArticles();
    }
    _authProvider.addListener(() {
      if (_authProvider.isLoggedIn) {
        loadMyArticles();
      } else {
        _articles.clear();
        notifyListeners();
      }
    });
  }

  List<Article> get articles => _articles;
  bool get isLoading => _isLoading;
  String get error => _error ?? '';

  String get _currentDocId =>
      _authProvider.user?.email ?? _authProvider.user?.id.toString() ?? '';

  Future<void> loadMyArticles() async {
    final docId = _currentDocId;
    if (docId.isEmpty) return;

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final querySnapshot = await _db
          .collection('users')
          .doc(docId)
          .collection('articles')
          .orderBy('createdAt', descending: true)
          .get();

      _articles = querySnapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc
            .id; // Store string ID temporarily if needed, or handle mapping. We'll map to Article keeping int ID constraint in mind.
        // The Article model expects an int ID. For Firestore, it's better to generate a unique int or change the model to string.
        // Assuming we keep int id, we can use a hashcode of the document ID or generate a timestamp.
        return Article(
          id: doc.id.hashCode,
          title: data['title'] ?? '',
          description: data['description'],
          content: data['content'],
          thumb: data['thumb'],
          categoryId: data['categoryId'] ?? 0,
          categoryName: data['categoryName'],
          createdAt: data['createdAt'] != null
              ? (data['createdAt'] as Timestamp).toDate().toString()
              : '',
        );
      }).toList();
    } catch (e) {
      _error = e.toString().replaceFirst('Exception: ', '');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> deleteArticle(int articleId) async {
    final docId = _currentDocId;
    if (docId.isEmpty) return false;

    try {
      // Find the document ID since Article model only holds int IDs
      final querySnapshot =
          await _db.collection('users').doc(docId).collection('articles').get();

      String? docToDelete;
      for (var doc in querySnapshot.docs) {
        if (doc.id.hashCode == articleId) {
          docToDelete = doc.id;
          break;
        }
      }

      if (docToDelete != null) {
        await _db
            .collection('users')
            .doc(docId)
            .collection('articles')
            .doc(docToDelete)
            .delete();
        _articles.removeWhere((a) => a.id == articleId);
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      _error = e.toString().replaceFirst('Exception: ', '');
      notifyListeners();
      return false;
    }
  }

  // Khai báo thêm hàm create/update tạm thời (sẽ thêm repo method nếu cần)
  Future<bool> createArticle(Article article) async {
    final docId = _currentDocId;
    if (docId.isEmpty) return false;

    try {
      await _db.collection('users').doc(docId).collection('articles').add({
        'title': article.title,
        'description': article.description,
        'content': article.content,
        'thumb': article.thumb,
        'categoryId': article.categoryId,
        'categoryName': article.categoryName,
        'authorName': _authProvider.user?.name,
        'createdAt': FieldValue.serverTimestamp(),
      });
      await loadMyArticles();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }
}
