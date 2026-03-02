import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../apps/routers/router_name.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.splashBg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 40),
              // Coffee image with border
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.lightBlueAccent,
                      width: 2.5,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.network(
                      'https://images.unsplash.com/photo-1497935586351-b67a49e012bf?w=600',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      errorBuilder: (_, __, ___) => Container(
                        color: Colors.brown.shade200,
                        child: const Center(
                          child: Icon(Icons.coffee, size: 80, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Title
              const Text(
                'Stay Focused',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Get the cup filled of your choice to stay focused and awake. Diffrent type of coffee menu, hot lottee cappucino',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.textDark.withOpacity(0.7),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 40),
              // Dive In button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, RouterName.home);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 0,
                  ),
                  icon: const Text(
                    'Dive In',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  label: const Icon(Icons.arrow_forward, size: 18),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
