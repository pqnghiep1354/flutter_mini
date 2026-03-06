import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'config/themes/app_theme.dart';
import 'config/routes/app_router.dart';
import 'providers/settings_provider.dart';
import 'providers/auth_provider.dart';
import 'providers/favorites_provider.dart';
import 'providers/home_provider.dart';
import 'providers/article_detail_provider.dart';
import 'providers/category_articles_provider.dart';
import 'providers/search_provider.dart';
import 'providers/admin_provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => SettingsProvider()
              ..loadSettings()
              ..loadCategories()),
        ChangeNotifierProvider(create: (_) => AuthProvider()..tryAutoLogin()),
        ChangeNotifierProvider(
            create: (_) => FavoritesProvider()..loadFavorites()),
        ChangeNotifierProvider(create: (_) => HomeProvider()..loadData()),
        ChangeNotifierProvider(create: (_) => ArticleDetailProvider()),
        ChangeNotifierProvider(create: (_) => CategoryArticlesProvider()),
        ChangeNotifierProvider(create: (_) => SearchProvider()),
        ChangeNotifierProvider(create: (_) => AdminProvider()),
      ],
      child: MaterialApp(
        title: 'Articles Hub',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        initialRoute: AppRouter.home,
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}
