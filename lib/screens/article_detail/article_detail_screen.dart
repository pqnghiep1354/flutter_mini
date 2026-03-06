import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/routes/app_router.dart';
import '../../models/article_model.dart';
import '../../providers/article_detail_provider.dart';
import 'widgets/article_detail_content.dart';
import '../shared/error_view.dart';

class ArticleDetailScreen extends StatefulWidget {
  final int articleId;
  const ArticleDetailScreen({super.key, required this.articleId});

  @override
  State<ArticleDetailScreen> createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  // ── Navigation ──
  void _goDetail(Article a) =>
      Navigator.pushNamed(context, AppRouter.articleDetail, arguments: a.id);

  // ── UI ──
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<ArticleDetailProvider>(
        builder: (context, provider, child) {
          return _buildBody(provider);
        },
      ),
    );
  }

  Widget _buildBody(ArticleDetailProvider provider) {
    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (provider.error != null) {
      return ErrorView(
        message: provider.error!,
        onRetry: () => provider.loadDetail(widget.articleId),
      );
    }
    if (provider.article == null) {
      return const Center(child: Text('Article not found'));
    }
    return ArticleDetailContent(
      article: provider.article!,
      related: provider.related,
      onRelatedTap: _goDetail,
    );
  }
}
