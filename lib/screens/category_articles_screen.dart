import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/category_model.dart';
import '../models/article_model.dart';
import '../providers/category_articles_provider.dart';
import '../widgets/shimmer_loading.dart';
import 'widgets/articles_grid_view.dart';
import 'widgets/articles_list_view.dart';
import 'widgets/empty_view.dart';
import 'widgets/error_view.dart';
import 'article_detail_screen.dart';

class CategoryArticlesScreen extends StatelessWidget {
  final Category category;
  const CategoryArticlesScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CategoryArticlesProvider()..loadArticles(category.id),
      child: _CategoryArticlesView(category: category),
    );
  }
}

class _CategoryArticlesView extends StatelessWidget {
  final Category category;
  const _CategoryArticlesView({required this.category});

  void _goDetail(BuildContext context, Article article) => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => ArticleDetailScreen(articleId: article.id)),
      );

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CategoryArticlesProvider>();
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(category.name,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            if (!provider.isLoading && provider.articles.isNotEmpty)
              Text('${provider.articles.length} articles',
                  style: TextStyle(fontSize: 12, color: Colors.grey[500])),
          ],
        ),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1A1A2E),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(provider.isGrid ? Icons.view_list : Icons.grid_view),
            onPressed: () =>
                context.read<CategoryArticlesProvider>().toggleView(),
          ),
        ],
      ),
      body: provider.isLoading
          ? const ShimmerGridLoading()
          : provider.error != null
              ? ErrorView(
                  message: provider.error!,
                  onRetry: () => context
                      .read<CategoryArticlesProvider>()
                      .loadArticles(category.id),
                )
              : provider.articles.isEmpty
                  ? const EmptyView(
                      message: 'No articles found',
                      icon: Icons.article_outlined,
                    )
                  : RefreshIndicator(
                      onRefresh: () => context
                          .read<CategoryArticlesProvider>()
                          .loadArticles(category.id),
                      child: provider.isGrid
                          ? ArticlesGridView(
                              articles: provider.articles,
                              onTap: (a) => _goDetail(context, a),
                            )
                          : ArticlesListView(
                              articles: provider.articles,
                              onTap: (a) => _goDetail(context, a),
                            ),
                    ),
    );
  }
}
