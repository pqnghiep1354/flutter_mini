import 'package:flutter/material.dart';
import '../screens/splash/splash_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/cart/cart_screen.dart';
import '../screens/category/category_screen.dart';
import '../screens/detail/detail_screen.dart';
import 'routers/router_name.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coffee App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFC69B7B),
        ),
      ),
      initialRoute: RouterName.splash,
      routes: {
        RouterName.splash: (context) => const SplashScreen(),
        RouterName.home: (context) => const HomeScreen(),
        RouterName.cart: (context) => const CartScreen(),
        RouterName.category: (context) => const CategoryScreen(),
        RouterName.detail: (context) => const DetailScreen(),
      },
    );
  }
}
