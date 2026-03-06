import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../config/routes/app_router.dart';
import '../../../models/article_model.dart';
import '../../../models/category_model.dart';
import '../../../providers/home_provider.dart';
import '../../../providers/settings_provider.dart';
import '../../../widgets/shimmer_loading.dart';
import '../../shared/error_view.dart';
import 'category_grid.dart';
import 'popular_articles.dart';
import 'section_title.dart';

class HomeContentWidget extends StatelessWidget {
  const HomeContentWidget({super.key});

  void _goCategory(BuildContext context, Category c) {
    Navigator.pushNamed(context, AppRouter.categoryArticles, arguments: c);
  }

  void _goDetail(BuildContext context, Article a) {
    Navigator.pushNamed(context, AppRouter.articleDetail, arguments: a.id);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<HomeProvider, SettingsProvider>(
      builder: (context, home, settings, child) {
        if (home.isLoading) {
          return const SliverFillRemaining(child: ShimmerLoading());
        }
        if (home.error != null) {
          return SliverFillRemaining(
            child: ErrorView(
              message: home.error!,
              icon: Icons.cloud_off,
              onRetry: () => home.loadData(),
            ),
          );
        }

        final visible = home.categories
            .where((c) => settings.isCategoryVisible(c.id))
            .toList();

        return SliverMainAxisGroup(
          slivers: [
            SliverToBoxAdapter(
              child: SectionTitle(
                title:
                    'Categories (${visible.length}/${home.categories.length})',
                icon: Icons.category,
              ),
            ),
            SliverToBoxAdapter(
              child: visible.isEmpty
                  ? _buildEmptyCategories(context)
                  : CategoryGrid(
                      categories: visible,
                      onTap: (c) => _goCategory(context, c),
                    ),
            ),
            if (home.popularArticles.isNotEmpty) ...[
              const SliverToBoxAdapter(
                child: SectionTitle(
                    title: 'Popular', icon: Icons.local_fire_department),
              ),
              SliverToBoxAdapter(
                child: PopularArticles(
                  articles: home.popularArticles,
                  onTap: (a) => _goDetail(context, a),
                ),
              ),
            ],
            SliverToBoxAdapter(child: SizedBox(height: 24.h)),
          ],
        );
      },
    );
  }

  Widget _buildEmptyCategories(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Center(
        child: Column(
          children: [
            Icon(Icons.filter_list_off, size: 48.sp, color: Colors.grey[400]),
            SizedBox(height: 10.h),
            Text(
              'All categories are hidden',
              style: TextStyle(color: Colors.grey[500], fontSize: 14.sp),
            ),
            SizedBox(height: 8.h),
            TextButton.icon(
              onPressed: () => Navigator.pushNamed(context, AppRouter.settings),
              icon: Icon(Icons.settings, size: 18.sp),
              label: const Text('Go to Settings'),
            ),
          ],
        ),
      ),
    );
  }
}
