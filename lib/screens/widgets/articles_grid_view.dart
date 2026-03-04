import 'package:flutter/material.dart';
import '../../models/article_model.dart';
import '../../widgets/article_grid_card.dart';

class ArticlesGridView extends StatelessWidget {
  final List<Article> articles;
  final void Function(Article) onTap;

  const ArticlesGridView({super.key, required this.articles, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.75),
        itemCount: articles.length,
        itemBuilder: (_, i) =>
            ArticleGridCard(article: articles[i], onTap: () => onTap(articles[i])),
      ),
    );
  }
}
