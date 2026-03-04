import 'package:flutter/material.dart';
import '../../models/article_model.dart';
import '../../widgets/article_card.dart';

class ArticlesListView extends StatelessWidget {
  final List<Article> articles;
  final void Function(Article) onTap;

  const ArticlesListView({super.key, required this.articles, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: articles.length,
      itemBuilder: (_, i) =>
          ArticleCard(article: articles[i], onTap: () => onTap(articles[i])),
    );
  }
}
