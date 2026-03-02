import 'package:flutter/material.dart';
import '../../models/coffee_model.dart';
import '../../utils/app_colors.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../../widgets/coffee_card.dart';
import '../../apps/routers/router_name.dart';
import 'widgets/category_tab_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = 'Espresso';
  final _categories = ['Espresso', 'Latte', 'Cappuccino', 'Cafetière'];

  List<CoffeeModel> get _filteredCoffees =>
      sampleCoffees.where((c) => c.category == _selectedCategory).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSearchBar(),
                    const SizedBox(height: 16),
                    _buildCategorySection(),
                    const SizedBox(height: 20),
                    _buildSpecialSection(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 0),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Grid menu icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.grid_view_rounded, color: AppColors.primary),
          ),
          // Title
          const Column(
            children: [
              Text(
                'Find the best',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              Text(
                'Coffee to your taste',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
          // Avatar
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

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(color: AppColors.textGrey),
                  prefixIcon: Icon(Icons.search, color: AppColors.textGrey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.tune, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CategoryTabBar(
            categories: _categories,
            onCategorySelected: (cat) {
              setState(() => _selectedCategory = cat);
            },
          ),
        ),
        const SizedBox(height: 16),
        if (_filteredCoffees.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              height: 180,
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.75,
                ),
                itemCount: 2,
                itemBuilder: (context, index) => CoffeeCard(coffee: sampleCoffees[index]),
              ),
            ),
          )
        else
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _filteredCoffees.length,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(
                    right: index < _filteredCoffees.length - 1 ? 12 : 0,
                  ),
                  child: SizedBox(
                    width: 150,
                    child: CoffeeCard(coffee: _filteredCoffees[index]),
                  ),
                ),
              ),
            ),
          ),
        // View all in category
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                RouterName.category,
                arguments: _selectedCategory,
              );
            },
            child: Text(
              'See all in $_selectedCategory →',
              style: const TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSpecialSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Special for you',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                    ),
                    child: Image.network(
                      'https://images.unsplash.com/photo-1461023058943-07fcbe16d735?w=300',
                      height: 120,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: AppColors.brownLight,
                        child: const Icon(Icons.coffee, color: Colors.white, size: 40),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      'Specially mixed and\nbrewd within you\nmust try',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
