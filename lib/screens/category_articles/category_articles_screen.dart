import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../config/routes/app_router.dart';
import '../../models/article_model.dart';
import '../../providers/category_articles_provider.dart';
import '../../widgets/shimmer_grid_loading.dart';
import 'widgets/articles_grid_view.dart';
import 'widgets/articles_list_view.dart';
import '../shared/empty_view.dart';
import '../shared/error_view.dart';

class CategoryArticlesScreen extends StatefulWidget {
  final dynamic category;
  const CategoryArticlesScreen({super.key, required this.category});

  @override
  State<CategoryArticlesScreen> createState() => _CategoryArticlesScreenState();
}

class _CategoryArticlesScreenState extends State<CategoryArticlesScreen> {
  // ── Navigation ──
  void _goDetail(Article a) =>
      Navigator.pushNamed(context, AppRouter.articleDetail, arguments: a.id);

  // ── UI ──
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: _buildAppBar(),
      body: Consumer<CategoryArticlesProvider>(
        builder: (context, provider, child) {
          return _buildBody(provider);
        },
      ),
    );
  }

  Widget _buildBody(CategoryArticlesProvider provider) {
    if (provider.isLoading) {
      return const ShimmerGridLoading();
    }
    if (provider.error != null) {
      return ErrorView(
        message: provider.error!,
        onRetry: () => provider.loadArticles(widget.category.id),
      );
    }
    if (provider.articles.isEmpty) {
      return const EmptyView(
        message: 'No articles found',
        icon: Icons.article_outlined,
      );
    }
    return RefreshIndicator(
      onRefresh: () => provider.loadArticles(widget.category.id),
      child: _buildArticles(provider),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.category.name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp)),
          Consumer<CategoryArticlesProvider>(
            builder: (context, provider, child) {
              if (provider.articles.isNotEmpty) {
                return Text('${provider.articles.length} articles',
                    style: TextStyle(fontSize: 12.sp, color: Colors.grey[500]));
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      foregroundColor: const Color(0xFF1A1A2E),
      scrolledUnderElevation: 0,
      actions: [
        Consumer<CategoryArticlesProvider>(
          builder: (context, provider, child) {
            return IconButton(
              icon: Icon(provider.isGrid ? Icons.view_list : Icons.grid_view,
                  size: 24.sp),
              onPressed: () => provider.toggleView(),
            );
          },
        ),
      ],
    );
  }

  Widget _buildArticles(CategoryArticlesProvider provider) {
    if (provider.isGrid) {
      return ArticlesGridView(
        articles: provider.articles,
        onTap: _goDetail,
        onLoadMore: () => provider.loadMore(),
        isLoadingMore: provider.isLoadingMore,
        hasMore: provider.hasMore,
      );
    }
    return ArticlesListView(
      articles: provider.articles,
      onTap: _goDetail,
      onLoadMore: () => provider.loadMore(),
      isLoadingMore: provider.isLoadingMore,
      hasMore: provider.hasMore,
    );
  }
}
