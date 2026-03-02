import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'routers/router_custom.dart';
import 'routers/router_name.dart';
import 'themes/app_theme.dart';

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
      theme: AppTheme.dark,
      initialRoute: RouterName.demoSplash,
      routes: RouterCustom.routes,
      onGenerateRoute: RouterCustom.onGenerateRoute,
    );
  }
}
