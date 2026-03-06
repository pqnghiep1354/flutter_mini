import 'package:flutter/material.dart';
import '../../../models/article_model.dart';
import 'article_sliver_app_bar.dart';
import 'article_sliver_body.dart';

class ArticleDetailContent extends StatelessWidget {
  final Article article;
  final List<Article> related;
  final void Function(Article) onRelatedTap;

  const ArticleDetailContent({
    super.key,
    required this.article,
    required this.related,
    required this.onRelatedTap,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        ArticleSliverAppBar(article: article),
        ArticleSliverBody(
          article: article,
          related: related,
          onRelatedTap: onRelatedTap,
        ),
      ],
    );
  }
}
