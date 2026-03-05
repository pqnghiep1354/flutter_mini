import 'package:flutter/material.dart';
import '../../config/routes/app_router.dart';
import '../../models/article_model.dart';
import '../../repos/article_repo.dart';
import 'widgets/article_detail_content.dart';
import '../shared/error_view.dart';

class ArticleDetailScreen extends StatefulWidget {
  final int articleId;
  const ArticleDetailScreen({super.key, required this.articleId});

  @override
  State<ArticleDetailScreen> createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  late Future<_DetailData> _dataFuture;

  @override
  void initState() {
    super.initState();
    _dataFuture = _loadDetail(widget.articleId);
  }

  Future<_DetailData> _loadDetail(int id) async {
    final results = await Future.wait([
      ArticleRepo.getDetail(id),
      ArticleRepo.getRelated(id, limit: 5),
    ]);
    return _DetailData(
      article: results[0] as Article,
      related: results[1] as List<Article>,
    );
  }

  void _goDetail(Article article) =>
      Navigator.pushNamed(context, AppRouter.articleDetail,
          arguments: article.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<_DetailData>(
        future: _dataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return ErrorView(
              message: snapshot.error.toString(),
              onRetry: () =>
                  setState(() => _dataFuture = _loadDetail(widget.articleId)),
            );
          }
          final data = snapshot.data!;
          return ArticleDetailContent(
            article: data.article,
            related: data.related,
            onRelatedTap: _goDetail,
          );
        },
      ),
    );
  }
}

class _DetailData {
  final Article article;
  final List<Article> related;
  const _DetailData({required this.article, required this.related});
}
