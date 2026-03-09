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
import 'providers/my_articles_provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()..tryAutoLogin()),
        ChangeNotifierProxyProvider<AuthProvider, SettingsProvider>(
          create: (context) => SettingsProvider(context.read<AuthProvider>())
            ..loadSettings()
            ..loadCategories(),
          update: (context, auth, prev) => prev ?? SettingsProvider(auth),
        ),
        ChangeNotifierProxyProvider<AuthProvider, FavoritesProvider>(
          create: (context) => FavoritesProvider(context.read<AuthProvider>()),
          update: (context, auth, prev) => prev ?? FavoritesProvider(auth),
        ),
        ChangeNotifierProvider(create: (_) => HomeProvider()..loadData()),
        ChangeNotifierProvider(create: (_) => ArticleDetailProvider()),
        ChangeNotifierProvider(create: (_) => CategoryArticlesProvider()),
        ChangeNotifierProxyProvider<AuthProvider, MyArticlesProvider>(
          create: (context) => MyArticlesProvider(context.read<AuthProvider>()),
          update: (context, auth, prev) => prev ?? MyArticlesProvider(auth),
        ),
        ChangeNotifierProxyProvider<MyArticlesProvider, AdminProvider>(
          create: (context) =>
              AdminProvider(context.read<MyArticlesProvider>()),
          update: (context, myArticles, prev) =>
              prev ?? AdminProvider(myArticles),
        ),
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
