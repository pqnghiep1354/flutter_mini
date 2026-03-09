import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../providers/search_provider.dart';
import '../../shared/empty_view.dart';
import '../../shared/error_view.dart';
import '../../../widgets/shared/article_item.dart';

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
          return ArticleItem(article: search.results[index]);
        },
      ),
    );
  }
}
