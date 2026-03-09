import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../providers/my_articles_provider.dart';
import '../../widgets/shimmer_grid_loading.dart';
import '../../../widgets/shared/article_item.dart';

class MyArticlesScreen extends StatefulWidget {
  const MyArticlesScreen({super.key});

  @override
  State<MyArticlesScreen> createState() => _MyArticlesScreenState();
}

class _MyArticlesScreenState extends State<MyArticlesScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final isLoggedIn = context.read<AuthProvider>().isLoggedIn;
      if (isLoggedIn) {
        context.read<MyArticlesProvider>().loadMyArticles();
      }
    });
  }

  void _confirmDelete(BuildContext context, int articleId) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Xác nhận xóa'),
        content: const Text('Bạn có chắc chắn muốn xóa bài viết này không?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(ctx);
              final isLoggedIn = context.read<AuthProvider>().isLoggedIn;
              if (isLoggedIn) {
                final success = await context
                    .read<MyArticlesProvider>()
                    .deleteArticle(articleId);
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(success
                          ? 'Trạng thái xóa thành công'
                          : 'Xóa thất bại'),
                      backgroundColor:
                          success ? const Color(0xFF43E97B) : Colors.red,
                    ),
                  );
                }
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Xóa', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final token = context.watch<AuthProvider>().token;
    if (token == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Bài viết của tôi')),
        body: const Center(child: Text('Vui lòng đăng nhập')),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: const Text('Bài viết của tôi',
            style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Consumer<MyArticlesProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.articles.isEmpty) {
            return const ShimmerGridLoading();
          }

          if (provider.error.isNotEmpty && provider.articles.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Lỗi: ${provider.error}',
                      style: const TextStyle(color: Colors.red)),
                  SizedBox(height: 16.h),
                  ElevatedButton(
                    onPressed: () => provider.loadMyArticles(),
                    child: const Text('Thử lại'),
                  ),
                ],
              ),
            );
          }

          if (provider.articles.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.article_outlined, size: 64.w, color: Colors.grey),
                  SizedBox(height: 16.h),
                  const Text('Bạn chưa có bài viết nào.',
                      style: TextStyle(color: Colors.grey, fontSize: 16)),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () => provider.loadMyArticles(),
            child: ListView.separated(
              padding: EdgeInsets.all(16.w),
              itemCount: provider.articles.length,
              separatorBuilder: (context, index) => SizedBox(height: 16.h),
              itemBuilder: (context, index) {
                final article = provider.articles[index];
                return Stack(
                  children: [
                    // Tái sử dụng ArticleItem
                    ArticleItem(article: article),

                    // Nút chức năng Edit / Delete
                    Positioned(
                      top: 8.h,
                      right: 8.w,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 4.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.9),
                          borderRadius: BorderRadius.circular(8.r),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit,
                                  color: Colors.blue, size: 20),
                              constraints: const BoxConstraints(),
                              padding: EdgeInsets.all(4.w),
                              onPressed: () {
                                // Mở màn EditArticleScreen và pass data qua
                                Navigator.pushNamed(
                                  context,
                                  '/edit-article',
                                  arguments: article,
                                ).then((_) => provider.loadMyArticles());
                              },
                            ),
                            SizedBox(width: 4.w),
                            IconButton(
                              icon: const Icon(Icons.delete,
                                  color: Colors.red, size: 20),
                              constraints: const BoxConstraints(),
                              padding: EdgeInsets.all(4.w),
                              onPressed: () =>
                                  _confirmDelete(context, article.id),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
