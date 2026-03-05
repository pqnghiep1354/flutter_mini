import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/routes/app_router.dart';
import '../../models/article_model.dart';
import '../../providers/favorites_provider.dart';
import '../../repos/article_repo.dart';
import '../../widgets/article_card.dart';
import '../shared/empty_view.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<FavoritesProvider>();
    final ids = favorites.favoriteIds.toList().reversed.toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: Text('Favorites (${ids.length})',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1A1A2E),
        scrolledUnderElevation: 0,
      ),
      body: ids.isEmpty
          ? const EmptyView(
              message: 'No favorites yet\nTap ❤️ on articles to save them',
              icon: Icons.favorite_border,
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: ids.length,
              itemBuilder: (_, i) => _FavoriteArticleItem(
                articleId: ids[i],
                onTap: (a) => Navigator.pushNamed(
                    context, AppRouter.articleDetail,
                    arguments: a.id),
                onRemove: () => favorites.toggleFavorite(ids[i]),
              ),
            ),
    );
  }
}

class _FavoriteArticleItem extends StatelessWidget {
  final int articleId;
  final void Function(Article) onTap;
  final VoidCallback onRemove;

  const _FavoriteArticleItem({
    required this.articleId,
    required this.onTap,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Article>(
      future: ArticleRepo.getDetail(articleId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            height: 100,
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Center(
                child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2))),
          );
        }
        if (snapshot.hasError) {
          return Container(
            height: 60,
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(14),
            ),
            child: ListTile(
              title: Text('Article #$articleId',
                  style: const TextStyle(color: Colors.grey)),
              trailing: IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                onPressed: onRemove,
              ),
            ),
          );
        }
        final article = snapshot.data!;
        return Dismissible(
          key: Key('fav-$articleId'),
          direction: DismissDirection.endToStart,
          onDismissed: (_) => onRemove(),
          background: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.red.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.delete, color: Colors.red),
          ),
          child: ArticleCard(
            article: article,
            onTap: () => onTap(article),
          ),
        );
      },
    );
  }
}
