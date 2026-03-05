import 'package:flutter/material.dart';
import '../../../models/article_model.dart';
import '../../../widgets/article_grid_card.dart';

class ArticlesGridView extends StatelessWidget {
  final List<Article> articles;
  final void Function(Article) onTap;
  final VoidCallback? onLoadMore;
  final bool isLoadingMore;
  final bool hasMore;

  const ArticlesGridView({
    super.key,
    required this.articles,
    required this.onTap,
    this.onLoadMore,
    this.isLoadingMore = false,
    this.hasMore = false,
  });

  @override
  Widget build(BuildContext context) {
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
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: CustomScrollView(
          slivers: [
            SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (_, i) => ArticleGridCard(
                  article: articles[i],
                  onTap: () => onTap(articles[i]),
                ),
                childCount: articles.length,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.75,
              ),
            ),
            if (isLoadingMore)
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Center(
                    child: SizedBox(
                      width: 28,
                      height: 28,
                      child: CircularProgressIndicator(strokeWidth: 2.5),
                    ),
                  ),
                ),
              ),
            if (!hasMore && articles.isNotEmpty)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Center(
                    child: Text(
                      'All articles loaded',
                      style: TextStyle(color: Colors.grey[500], fontSize: 13),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
