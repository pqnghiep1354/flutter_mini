import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/article_model.dart';
import '../providers/article_detail_provider.dart';
import 'widgets/article_detail_content.dart';
import 'widgets/error_view.dart';

class ArticleDetailScreen extends StatelessWidget {
  final int articleId;
  const ArticleDetailScreen({super.key, required this.articleId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ArticleDetailProvider()..loadDetail(articleId),
      child: _ArticleDetailView(articleId: articleId),
    );
  }
}

class _ArticleDetailView extends StatelessWidget {
  final int articleId;
  const _ArticleDetailView({required this.articleId});

  void _goDetail(BuildContext context, Article article) => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => ArticleDetailScreen(articleId: article.id)),
      );

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ArticleDetailProvider>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : provider.error != null
              ? ErrorView(
                  message: provider.error!,
                  onRetry: () =>
                      context.read<ArticleDetailProvider>().loadDetail(articleId),
                )
              : provider.article == null
                  ? const SizedBox.shrink()
                  : ArticleDetailContent(
                      article: provider.article!,
                      related: provider.related,
                      onRelatedTap: (a) => _goDetail(context, a),
                    ),
    );
  }
}
