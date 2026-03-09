import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import '../../config/routes/app_router.dart';
import '../../models/article_model.dart';
import '../../providers/favorites_provider.dart';

class ArticleItem extends StatelessWidget {
  final Article article;
  final bool isMyArticle;

  const ArticleItem({
    super.key,
    required this.article,
    this.isMyArticle = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 12.h),
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, AppRouter.articleDetail,
            arguments: article.id),
        borderRadius: BorderRadius.circular(12.r),
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: article.thumb != null
                    ? CachedNetworkImage(
                        imageUrl: article.thumb!,
                        width: 80.w,
                        height: 80.w,
                        fit: BoxFit.cover,
                        placeholder: (_, __) => Container(
                          width: 80.w,
                          height: 80.w,
                          color: Colors.grey[200],
                          child: Icon(Icons.image,
                              color: Colors.grey[400], size: 30.sp),
                        ),
                        errorWidget: (_, __, ___) => Container(
                          width: 80.w,
                          height: 80.w,
                          color: Colors.grey[200],
                          child: Icon(Icons.broken_image,
                              color: Colors.grey[400], size: 30.sp),
                        ),
                      )
                    : Container(
                        width: 80.w,
                        height: 80.w,
                        color: Colors.grey[200],
                        child: Icon(Icons.article,
                            color: Colors.grey[400], size: 30.sp),
                      ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                        color: const Color(0xFF1A1A2E),
                      ),
                    ),
                    if (article.description != null) ...[
                      SizedBox(height: 4.h),
                      Text(
                        article.description!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style:
                            TextStyle(color: Colors.grey[600], fontSize: 12.sp),
                      ),
                    ],
                    if (article.categoryName != null) ...[
                      SizedBox(height: 6.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 2.h),
                            decoration: BoxDecoration(
                              color: const Color(0xFF6C63FF)
                                  .withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: Text(
                              article.categoryName!,
                              style: TextStyle(
                                color: const Color(0xFF6C63FF),
                                fontSize: 11.sp,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Consumer<FavoritesProvider>(
                            builder: (context, favs, child) {
                              final isFav = favs.isFavorite(article.id);
                              return InkWell(
                                onTap: () => favs.toggleFavorite(article.id),
                                borderRadius: BorderRadius.circular(20.r),
                                child: Padding(
                                  padding: EdgeInsets.all(4.w),
                                  child: Icon(
                                    isFav
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color:
                                        isFav ? Colors.red : Colors.grey[400],
                                    size: 20.sp,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
