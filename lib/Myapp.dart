import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'config/themes/app_theme.dart';
import 'config/routes/app_router.dart';
import 'providers/settings_provider.dart';
import 'providers/auth_provider.dart';
import 'providers/favorites_provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()..tryAutoLogin()),
        ChangeNotifierProvider(
            create: (_) => FavoritesProvider()..loadFavorites()),
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
