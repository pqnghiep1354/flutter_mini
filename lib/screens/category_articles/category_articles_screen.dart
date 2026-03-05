import 'package:flutter/material.dart';
import '../../config/routes/app_router.dart';
import '../../models/category_model.dart';
import '../../models/article_model.dart';
import '../../repos/article_repo.dart';
import '../../widgets/shimmer_loading.dart';
import 'widgets/articles_grid_view.dart';
import 'widgets/articles_list_view.dart';
import '../shared/empty_view.dart';
import '../shared/error_view.dart';

class CategoryArticlesScreen extends StatefulWidget {
  final Category category;
  const CategoryArticlesScreen({super.key, required this.category});

  @override
  State<CategoryArticlesScreen> createState() => _CategoryArticlesScreenState();
}

class _CategoryArticlesScreenState extends State<CategoryArticlesScreen> {
  static const int _pageSize = 10;

  late Future<List<Article>> _initialFuture;
  final List<Article> _articles = [];
  int _currentPage = 1;
  bool _isLoadingMore = false;
  bool _hasMore = true;
  bool _isGrid = true;
  bool _initialLoaded = false;

  @override
  void initState() {
    super.initState();
    _initialFuture = _fetchPage(1);
  }

  Future<List<Article>> _fetchPage(int page) {
    return ArticleRepo.getByCategory(
      widget.category.id,
      limit: _pageSize,
      page: page,
    );
  }

  void _onInitialData(List<Article> data) {
    if (!_initialLoaded) {
      _articles.addAll(data);
      _hasMore = data.length >= _pageSize;
      _initialLoaded = true;
    }
  }

  Future<void> _loadMore() async {
    if (_isLoadingMore || !_hasMore) return;

    setState(() => _isLoadingMore = true);
    try {
      _currentPage++;
      final newArticles = await _fetchPage(_currentPage);
      setState(() {
        if (newArticles.isEmpty) {
          _hasMore = false;
        } else {
          _articles.addAll(newArticles);
          _hasMore = newArticles.length >= _pageSize;
        }
      });
    } catch (_) {
      _currentPage--;
    } finally {
      setState(() => _isLoadingMore = false);
    }
  }

  Future<void> _refresh() async {
    setState(() {
      _articles.clear();
      _currentPage = 1;
      _hasMore = true;
      _initialLoaded = false;
      _initialFuture = _fetchPage(1);
    });
  }

  void _toggleView() => setState(() => _isGrid = !_isGrid);

  void _goDetail(Article article) =>
      Navigator.pushNamed(context, AppRouter.articleDetail,
          arguments: article.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.category.name,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            if (_articles.isNotEmpty)
              Text('${_articles.length} articles',
                  style: TextStyle(fontSize: 12, color: Colors.grey[500])),
          ],
        ),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1A1A2E),
        scrolledUnderElevation: 0,
        actions: [
          IconButton(
            icon: Icon(_isGrid ? Icons.view_list : Icons.grid_view),
            onPressed: _toggleView,
          ),
        ],
      ),
      body: FutureBuilder<List<Article>>(
        future: _initialFuture,
        builder: (context, snapshot) {
          // Loading state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const ShimmerGridLoading();
          }

          // Error state
          if (snapshot.hasError) {
            return ErrorView(
              message: snapshot.error.toString(),
              onRetry: () => _refresh(),
            );
          }

          // Data loaded — populate articles list on first load
          if (snapshot.hasData) {
            _onInitialData(snapshot.data!);
          }

          // Empty state
          if (_articles.isEmpty) {
            return const EmptyView(
              message: 'No articles found',
              icon: Icons.article_outlined,
            );
          }

          // Articles view with load more
          return RefreshIndicator(
            onRefresh: _refresh,
            child: _isGrid
                ? ArticlesGridView(
                    articles: _articles,
                    onTap: _goDetail,
                    onLoadMore: _loadMore,
                    isLoadingMore: _isLoadingMore,
                    hasMore: _hasMore,
                  )
                : ArticlesListView(
                    articles: _articles,
                    onTap: _goDetail,
                    onLoadMore: _loadMore,
                    isLoadingMore: _isLoadingMore,
                    hasMore: _hasMore,
                  ),
          );
        },
      ),
    );
  }
}
