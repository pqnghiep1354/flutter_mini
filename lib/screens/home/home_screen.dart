import 'package:flutter/material.dart';
import '../../models/coffee_model.dart';
import '../../utils/app_colors.dart';
import '../../widgets/bottom_nav_bar.dart';
import 'widgets/home_header.dart';
import 'widgets/home_search_bar.dart';
import 'widgets/category_tab_bar.dart';
import 'widgets/coffee_horizontal_list.dart';
import 'widgets/special_for_you_banner.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = coffeeCategories.first;

  List<CoffeeModel> get _filtered =>
      sampleCoffees.where((c) => c.category == _selectedCategory).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: const HomeHeader()),
            SliverToBoxAdapter(child: const HomeSearchBar()),
            SliverToBoxAdapter(child: const SizedBox(height: 24)),
            // Category tabs
            SliverToBoxAdapter(
              child: CategoryTabBar(
                categories: coffeeCategories,
                selectedCategory: _selectedCategory,
                onCategoryChanged: (cat) => setState(() => _selectedCategory = cat),
              ),
            ),
            SliverToBoxAdapter(child: const SizedBox(height: 18)),
            // Coffee list
            SliverToBoxAdapter(
              child: CoffeeHorizontalList(
                coffees: _filtered,
                category: _selectedCategory,
              ),
            ),
            SliverToBoxAdapter(child: const SizedBox(height: 28)),
            // Special section
            SliverToBoxAdapter(child: const SpecialForYouBanner()),
            SliverToBoxAdapter(child: const SizedBox(height: 30)),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 0),
    );
  }
}
