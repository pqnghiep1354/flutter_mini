import 'package:flutter/material.dart';
import '../../../models/article_model.dart';
import '../../../widgets/article_card.dart';

class ArticlesListView extends StatelessWidget {
  final List<Article> articles;
  final void Function(Article) onTap;
  final VoidCallback? onLoadMore;
  final bool isLoadingMore;
  final bool hasMore;

  const ArticlesListView({
    super.key,
    required this.articles,
    required this.onTap,
    this.onLoadMore,
    this.isLoadingMore = false,
    this.hasMore = false,
  });

  @override
  Widget build(BuildContext context) {
    // Total items = articles + optional loading/end indicator
    final itemCount = articles.length + (isLoadingMore || !hasMore ? 1 : 0);

    return NotificationListener<ScrollNotification>(
      onNotification: (scrollInfo) {
        if (onLoadMore != null &&
            !isLoadingMore &&
            hasMore &&
            scrollInfo.metrics.pixels >=
                scrollInfo.metrics.maxScrollExtent - 200) {
          onLoadMore!();
        }
        return false;
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: itemCount,
        itemBuilder: (_, i) {
          if (i < articles.length) {
            return ArticleCard(
              article: articles[i],
              onTap: () => onTap(articles[i]),
            );
          }
          // Footer: loading or end message
          if (isLoadingMore) {
            return const Padding(
              padding: EdgeInsets.all(20),
              child: Center(
                child: SizedBox(
                  width: 28,
                  height: 28,
                  child: CircularProgressIndicator(strokeWidth: 2.5),
                ),
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Text(
                'All articles loaded',
                style: TextStyle(color: Colors.grey[500], fontSize: 13),
              ),
            ),
          );
        },
      ),
    );
  }
}
