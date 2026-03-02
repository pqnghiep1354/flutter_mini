import 'package:flutter/material.dart';
import '../cart/cart_screen.dart';
import '../home/home_screen.dart';
import '../../widgets/bottom_nav_bar.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int currentIndex = 0;

  final List<Widget> screens = const [
    HomeScreen(),
    HomeScreen(),   // Wishlist placeholder
    CartScreen(),
    HomeScreen(),   // Notifications placeholder
    HomeScreen(),   // Profile placeholder
  ];

  void handleOntapItem(int index) {
    setState(() => currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: currentIndex,
        onTapItem: handleOntapItem,
      ),
    );
  }
}
