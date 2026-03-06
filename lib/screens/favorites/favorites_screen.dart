import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../config/routes/app_router.dart';
import '../../providers/favorites_provider.dart';
import '../shared/empty_view.dart';
import 'widgets/favorite_article_item.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: Consumer<FavoritesProvider>(
          builder: (context, favorites, child) {
            return Text('Favorites (${favorites.favoriteIds.length})',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp));
          },
        ),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1A1A2E),
        scrolledUnderElevation: 0,
      ),
      body: Consumer<FavoritesProvider>(
        builder: (context, favorites, child) {
          final ids = favorites.favoriteIds.toList().reversed.toList();
          if (ids.isEmpty) {
            return const EmptyView(
              message: 'No favorites yet\nTap ❤️ on articles to save them',
              icon: Icons.favorite_border,
            );
          }
          return ListView.builder(
            padding: EdgeInsets.all(16.w),
            itemCount: ids.length,
            itemBuilder: (_, i) => FavoriteArticleItem(
              articleId: ids[i],
              onTap: (a) => Navigator.pushNamed(
                  context, AppRouter.articleDetail,
                  arguments: a.id),
              onRemove: () =>
                  favorites.toggleFavorite(ids[i]), // call from provider
            ),
          );
        },
      ),
    );
  }
}
