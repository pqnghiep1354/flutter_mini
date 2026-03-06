import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import '../../../../models/article_model.dart';
import '../../../../providers/favorites_provider.dart';

class ArticleSliverAppBar extends StatelessWidget {
  final Article article;

  const ArticleSliverAppBar({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 250,
      pinned: true,
      backgroundColor: const Color(0xFF1A1A2E),
      foregroundColor: Colors.white,
      actions: [
        IconButton(
          icon: const Icon(Icons.share_outlined),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Share: ${article.title}'),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
            );
          },
        ),
        Consumer<FavoritesProvider>(
          builder: (context, favorites, child) {
            final isFav = favorites.isFavorite(article.id);
            return IconButton(
              icon: Icon(
                isFav ? Icons.favorite : Icons.favorite_border,
                color: isFav ? Colors.redAccent : Colors.white,
              ),
              onPressed: () {
                favorites.toggleFavorite(article.id);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(isFav
                        ? 'Removed from favorites'
                        : 'Added to favorites ❤️'),
                    behavior: SnackBarBehavior.floating,
                    duration: const Duration(seconds: 1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                );
              },
            );
          },
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: 'article-thumb-${article.id}',
          child: article.thumb != null && article.thumb!.isNotEmpty
              ? CachedNetworkImage(
                  imageUrl: article.thumb!,
                  fit: BoxFit.cover,
                  placeholder: (c, u) => Container(color: Colors.grey[300]),
                  errorWidget: (c, u, e) => Container(
                    color: Colors.grey[300],
                    child:
                        const Icon(Icons.image, size: 48, color: Colors.grey),
                  ),
                )
              : Container(
                  color: const Color(0xFF6C63FF),
                  child: const Icon(Icons.article,
                      size: 64, color: Colors.white54),
                ),
        ),
      ),
    );
  }
}
