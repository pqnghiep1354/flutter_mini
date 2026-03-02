import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'routers/router_name.dart';
import '../screens/splash/splash_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/cart/cart_screen.dart';
import '../screens/category/category_screen.dart';
import '../screens/detail/detail_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    return MaterialApp(
      title: 'Coffee Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: const Color(0xFF1A1A1A),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFC58B60),
          brightness: Brightness.dark,
        ),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      initialRoute: RouterName.splash,
      routes: {
        RouterName.splash:   (_) => const SplashScreen(),
        RouterName.home:     (_) => const HomeScreen(),
        RouterName.cart:     (_) => const CartScreen(),
        RouterName.category: (_) => const CategoryScreen(),
        RouterName.detail:   (_) => const DetailScreen(),
      },
    );
  }
}
