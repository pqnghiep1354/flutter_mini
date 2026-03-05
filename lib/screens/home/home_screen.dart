import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/routes/app_router.dart';
import '../../models/category_model.dart';
import '../../models/article_model.dart';
import '../../repos/category_repo.dart';
import '../../repos/article_repo.dart';
import '../../providers/settings_provider.dart';
import '../../widgets/shimmer_loading.dart';
import 'widgets/home_header.dart';
import 'widgets/section_title.dart';
import 'widgets/category_grid.dart';
import 'widgets/popular_articles.dart';
import 'widgets/app_drawer.dart';
import '../shared/error_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<_HomeData> _dataFuture;

  @override
  void initState() {
    super.initState();
    _dataFuture = _loadData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SettingsProvider>().loadSettings();
    });
  }

  Future<_HomeData> _loadData() async {
    final results = await Future.wait([
      CategoryRepo.getAll(),
      ArticleRepo.getPopular(limit: 6),
    ]);
    return _HomeData(
      categories: results[0] as List<Category>,
      popularArticles: results[1] as List<Article>,
    );
  }

  Future<void> _refresh() async {
    setState(() {
      _dataFuture = _loadData();
    });
  }

  void _goCategory(Category c) =>
      Navigator.pushNamed(context, AppRouter.categoryArticles, arguments: c);

  void _goDetail(Article a) =>
      Navigator.pushNamed(context, AppRouter.articleDetail, arguments: a.id);

  void _goSettings() => Navigator.pushNamed(context, AppRouter.settings);

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      drawer: const AppDrawer(),
      body: SafeArea(
        child: FutureBuilder<_HomeData>(
          future: _dataFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const ShimmerLoading();
            }
            if (snapshot.hasError) {
              return ErrorView(
                message: snapshot.error.toString(),
                icon: Icons.cloud_off,
                onRetry: () => _refresh(),
              );
            }
            final data = snapshot.data!;
            final visibleCategories = data.categories
                .where((c) => settings.isCategoryVisible(c.id))
                .toList();

            return RefreshIndicator(
              onRefresh: _refresh,
              child: CustomScrollView(slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                    child: Row(children: [
                      Builder(
                        builder: (ctx) => IconButton(
                          icon: const Icon(Icons.menu,
                              color: Color(0xFF1A1A2E), size: 26),
                          onPressed: () => Scaffold.of(ctx).openDrawer(),
                          padding: const EdgeInsets.only(left: 12),
                        ),
                      ),
                      const Expanded(child: HomeHeader()),
                      IconButton(
                        icon: const Icon(Icons.settings_outlined,
                            color: Color(0xFF6C63FF), size: 26),
                        onPressed: _goSettings,
                        tooltip: 'Settings',
                      ),
                    ]),
                  ),
                ),
                SliverToBoxAdapter(
                    child: SectionTitle(
                        title:
                            'Categories (${visibleCategories.length}/${data.categories.length})',
                        icon: Icons.category)),
                SliverToBoxAdapter(
                    child: visibleCategories.isEmpty
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            child: Center(
                              child: Column(children: [
                                Icon(Icons.filter_list_off,
                                    size: 48, color: Colors.grey[400]),
                                const SizedBox(height: 10),
                                Text('All categories are hidden',
                                    style: TextStyle(
                                        color: Colors.grey[500], fontSize: 14)),
                                const SizedBox(height: 8),
                                TextButton.icon(
                                  onPressed: _goSettings,
                                  icon: const Icon(Icons.settings, size: 18),
                                  label: const Text('Go to Settings'),
                                ),
                              ]),
                            ),
                          )
                        : CategoryGrid(
                            categories: visibleCategories, onTap: _goCategory)),
                if (data.popularArticles.isNotEmpty) ...[
                  const SliverToBoxAdapter(
                      child: SectionTitle(
                          title: 'Popular', icon: Icons.local_fire_department)),
                  SliverToBoxAdapter(
                      child: PopularArticles(
                          articles: data.popularArticles, onTap: _goDetail)),
                ],
                const SliverToBoxAdapter(child: SizedBox(height: 24)),
              ]),
            );
          },
        ),
      ),
    );
  }
}

class _HomeData {
  final List<Category> categories;
  final List<Article> popularArticles;
  const _HomeData({required this.categories, required this.popularArticles});
}
