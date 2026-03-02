import 'package:flutter/material.dart';
import 'widgets/splash_coffee_image.dart';
import 'widgets/splash_content.dart';
import 'widgets/dive_in_button.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD5C9A5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 32, 24, 40),
          child: const Column(
            children: [
              SplashCoffeeImage(),
              SizedBox(height: 40),
              SplashContent(),
              SizedBox(height: 40),
              DiveInButton(),
            ],
          ),
        ),
      ),
    );
  }
}
