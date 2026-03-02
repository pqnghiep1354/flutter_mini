import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../apps/routers/router_name.dart';
import '../../utils/app_colors.dart';

class DemoSplash extends StatefulWidget {
  const DemoSplash({super.key});

  @override
  State<DemoSplash> createState() => _DemoSplashState();
}

class _DemoSplashState extends State<DemoSplash> {
  @override
  void initState() {
    super.initState();
    checkUserFirst();
  }

  Future<void> checkUserFirst() async {
    print("checkUserFirst");
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int userCounter = prefs.getInt('userCounter') ?? 0;
    print(userCounter);

    if (!mounted) return;

    if (userCounter == 0) {
      Navigator.pushReplacementNamed(context, RouterName.splash);
    } else {
      Navigator.pushReplacementNamed(context, RouterName.root);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.bgDark,
      body: Center(
        child: CircularProgressIndicator(
          color: AppColors.primary,
          strokeWidth: 2.5,
        ),
      ),
    );
  }
}
