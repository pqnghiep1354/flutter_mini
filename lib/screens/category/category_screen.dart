import 'package:flutter/material.dart';
import '../../models/coffee_model.dart';
import '../../utils/app_colors.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../../widgets/coffee_card.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryName = ModalRoute.of(context)?.settings.arguments as String? ?? 'Espresso';
    final coffees = sampleCoffees.where((c) => c.category == categoryName).toList();

    // If less than 6, pad with sample
    final displayCoffees = coffees.length >= 4
        ? coffees
        : [...coffees, ...sampleCoffees.take(6 - coffees.length)];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(context, categoryName),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                    childAspectRatio: 0.72,
                  ),
                  itemCount: displayCoffees.length,
                  itemBuilder: (context, index) => CoffeeCard(coffee: displayCoffees[index]),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 0),
    );
  }

  Widget _buildAppBar(BuildContext context, String category) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
            ),
          ),
          Text(
            category,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          CircleAvatar(
            radius: 20,
            backgroundColor: AppColors.brownLight,
            child: ClipOval(
              child: Image.network(
                'https://i.pravatar.cc/80',
                width: 40,
                height: 40,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    const Icon(Icons.person, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
