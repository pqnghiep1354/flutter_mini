import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../models/article_model.dart';
import '../../../repos/article_repo.dart';
import '../../../widgets/article_card.dart';

class FavoriteArticleItem extends StatelessWidget {
  final int articleId;
  final void Function(Article) onTap;
  final VoidCallback onRemove;

  const FavoriteArticleItem({
    super.key,
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
            height: 100.h,
            margin: EdgeInsets.only(bottom: 12.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14.r),
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
            height: 60.h,
            margin: EdgeInsets.only(bottom: 12.h),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(14.r),
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
            padding: EdgeInsets.only(right: 20.w),
            margin: EdgeInsets.only(bottom: 12.h),
            decoration: BoxDecoration(
              color: Colors.red.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(14.r),
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
