import 'package:flutter/material.dart';
import '../../models/category_model.dart';
import '../../screens/home/home_screen.dart';
import '../../screens/category_articles/category_articles_screen.dart';
import '../../screens/article_detail/article_detail_screen.dart';
import '../../screens/settings/settings_screen.dart';
import '../../screens/auth/login_screen.dart';
import '../../screens/auth/register_screen.dart';
import '../../screens/favorites/favorites_screen.dart';
import '../../screens/search/search_screen.dart';
import '../../screens/profile/profile_screen.dart';
import '../../screens/admin/admin_screen.dart';
import '../../providers/article_detail_provider.dart';
import '../../providers/category_articles_provider.dart';
import 'package:provider/provider.dart';

class AppRouter {
  static const String home = '/';
  static const String categoryArticles = '/category-articles';
  static const String articleDetail = '/article-detail';
  static const String settings = '/settings';
  static const String login = '/login';
  static const String register = '/register';
  static const String favorites = '/favorites';
  static const String search = '/search';
  static const String profile = '/profile';
  static const String admin = '/admin';

  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case home:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
          settings: routeSettings,
        );
      case categoryArticles:
        final category = routeSettings.arguments as Category;
        return MaterialPageRoute(
          builder: (context) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context
                  .read<CategoryArticlesProvider>()
                  .loadArticles(category.id);
            });
            return CategoryArticlesScreen(category: category);
          },
          settings: routeSettings,
        );
      case articleDetail:
        final articleId = routeSettings.arguments as int;
        return MaterialPageRoute(
          builder: (context) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.read<ArticleDetailProvider>().loadDetail(articleId);
            });
            return ArticleDetailScreen(articleId: articleId);
          },
          settings: routeSettings,
        );
      case settings:
        return MaterialPageRoute(
          builder: (_) => const SettingsScreen(),
          settings: routeSettings,
        );
      case login:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
          settings: routeSettings,
        );
      case register:
        return MaterialPageRoute(
          builder: (_) => const RegisterScreen(),
          settings: routeSettings,
        );
      case favorites:
        return MaterialPageRoute(
          builder: (_) => const FavoritesScreen(),
          settings: routeSettings,
        );
      case search:
        return MaterialPageRoute(
          builder: (_) => const SearchScreen(),
          settings: routeSettings,
        );
      case profile:
        return MaterialPageRoute(
          builder: (_) => const ProfileScreen(),
          settings: routeSettings,
        );
      case admin:
        return MaterialPageRoute(
          builder: (_) => const AdminScreen(),
          settings: routeSettings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Route not found')),
          ),
          settings: routeSettings,
        );
    }
  }
}
