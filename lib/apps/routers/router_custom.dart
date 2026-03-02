import 'package:flutter/material.dart';
import 'router_name.dart';
import '../../screens/demo_splash/demo_splash.dart';
import '../../screens/splash/splash_screen.dart';
import '../../screens/root/root_screen.dart';
import '../../screens/category/category_screen.dart';
import '../../screens/detail/detail_screen.dart';

class RouterCustom {
  RouterCustom._();

  static Map<String, WidgetBuilder> get routes => {
    RouterName.demoSplash: (_) => const DemoSplash(),
    RouterName.splash:     (_) => const SplashScreen(),
    RouterName.root:       (_) => const RootScreen(),
    RouterName.category:   (_) => const CategoryScreen(),
    RouterName.detail:     (_) => const DetailScreen(),
  };

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouterName.detail:
        return _slideRoute(const DetailScreen(), settings);
      case RouterName.category:
        return _slideRoute(const CategoryScreen(), settings);
      default:
        return null;
    }
  }

  static PageRouteBuilder<dynamic> _slideRoute(Widget page, RouteSettings settings) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, animation, __, child) {
        final tween = Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
            .chain(CurveTween(curve: Curves.easeInOutCubic));
        return SlideTransition(position: animation.drive(tween), child: child);
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}
