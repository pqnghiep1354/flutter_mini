import 'package:flutter/material.dart';
import '../../models/article_model.dart';
import '../../widgets/article_card.dart';

class PopularArticles extends StatelessWidget {
  final List<Article> articles;
  final void Function(Article) onTap;

  const PopularArticles({super.key, required this.articles, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: articles
            .map((a) => ArticleCard(article: a, onTap: () => onTap(a)))
            .toList(),
      ),
    );
  }
}
