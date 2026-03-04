import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/category_model.dart';
import '../models/article_model.dart';
import '../providers/home_provider.dart';
import '../widgets/shimmer_loading.dart';
import 'widgets/home_header.dart';
import 'widgets/section_title.dart';
import 'widgets/category_grid.dart';
import 'widgets/popular_articles.dart';
import 'widgets/error_view.dart';
import 'category_articles_screen.dart';
import 'article_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeProvider>().loadData();
    });
  }

  void _goCategory(Category c) => Navigator.push(context,
      MaterialPageRoute(builder: (_) => CategoryArticlesScreen(category: c)));

  void _goDetail(Article a) => Navigator.push(context,
      MaterialPageRoute(builder: (_) => ArticleDetailScreen(articleId: a.id)));

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeProvider>();
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: SafeArea(
        child: provider.isLoading
            ? const ShimmerLoading()
            : provider.error != null
                ? ErrorView(
                    message: provider.error!,
                    icon: Icons.cloud_off,
                    onRetry: () => context.read<HomeProvider>().loadData(),
                  )
                : RefreshIndicator(
                    onRefresh: () => context.read<HomeProvider>().loadData(),
                    child: CustomScrollView(slivers: [
                      const SliverToBoxAdapter(child: HomeHeader()),
                      const SliverToBoxAdapter(
                          child: SectionTitle(
                              title: 'Categories', icon: Icons.category)),
                      SliverToBoxAdapter(
                          child: CategoryGrid(
                              categories: provider.categories,
                              onTap: _goCategory)),
                      if (provider.popularArticles.isNotEmpty) ...[
                        const SliverToBoxAdapter(
                            child: SectionTitle(
                                title: 'Popular',
                                icon: Icons.local_fire_department)),
                        SliverToBoxAdapter(
                            child: PopularArticles(
                                articles: provider.popularArticles,
                                onTap: _goDetail)),
                      ],
                      const SliverToBoxAdapter(child: SizedBox(height: 24)),
                    ]),
                  ),
      ),
    );
  }
}
