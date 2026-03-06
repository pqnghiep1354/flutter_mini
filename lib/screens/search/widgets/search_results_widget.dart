import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../config/routes/app_router.dart';
import '../../../models/article_model.dart';
import '../../../providers/search_provider.dart';
import '../../shared/empty_view.dart';
import '../../shared/error_view.dart';

class SearchResultsWidget extends StatelessWidget {
  final String searchTerm;

  const SearchResultsWidget({super.key, required this.searchTerm});

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchProvider>(
      builder: (context, search, child) {
        if (searchTerm.isEmpty && search.results.isEmpty) {
          return _buildHint();
        }

        if (search.isLoading && search.results.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (search.error != null && search.results.isEmpty) {
          return ErrorView(
            message: search.error!,
            onRetry: () => search.search(searchTerm),
          );
        }

        if (search.results.isEmpty) {
          return const EmptyView(
            message: 'Không tìm thấy bài viết',
            icon: Icons.search_off,
          );
        }

        return _buildResults(context, search);
      },
    );
  }

  Widget _buildHint() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search, size: 64.sp, color: Colors.grey[300]),
          SizedBox(height: 16.h),
          Text(
            'Nhập từ khóa để tìm bài viết',
            style: TextStyle(color: Colors.grey[500], fontSize: 15.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildResults(BuildContext context, SearchProvider search) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollEndNotification &&
            notification.metrics.pixels >=
                notification.metrics.maxScrollExtent - 200) {
          context.read<SearchProvider>().loadMore();
        }
        return false;
      },
      child: ListView.builder(
        padding: EdgeInsets.all(16.w),
        itemCount: search.results.length + (search.hasMore ? 1 : 0),
        itemBuilder: (_, index) {
          if (index >= search.results.length) {
            return Padding(
              padding: EdgeInsets.all(16.w),
              child: const Center(child: CircularProgressIndicator()),
            );
          }
          return _buildArticleItem(context, search.results[index]);
        },
      ),
    );
  }

  Widget _buildArticleItem(BuildContext context, Article article) {
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
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFF6C63FF).withValues(alpha: 0.1),
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
