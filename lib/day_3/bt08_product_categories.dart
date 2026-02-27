import 'package:flutter/material.dart';

class Bt08ProductCategories extends StatelessWidget {
  const Bt08ProductCategories({super.key});

  static const _categories = [
    {
      'name': 'Fruits',
      'items': 10,
      'icon': Icons.lunch_dining,
      'color': 0xFF4DB6AC,
    },
    {'name': 'Vegetables', 'items': 15, 'icon': Icons.eco, 'color': 0xFF1565C0},
    {
      'name': 'Bakery',
      'items': 8,
      'icon': Icons.breakfast_dining,
      'color': 0xFF388E3C,
    },
    {'name': 'Dairy', 'items': 12, 'icon': Icons.icecream, 'color': 0xFFE91E8C},
    {'name': 'Mushroom', 'items': 6, 'icon': Icons.forest, 'color': 0xFFF57C00},
    {'name': 'Fish', 'items': 9, 'icon': Icons.set_meal, 'color': 0xFF00695C},
    {
      'name': 'Pizzas',
      'items': 7,
      'icon': Icons.local_pizza,
      'color': 0xFF795548,
    },
    {
      'name': 'Chicken',
      'items': 11,
      'icon': Icons.egg_alt,
      'color': 0xFF7B1FA2,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        title: const Text(
          'Categories',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: const [
          Icon(Icons.more_vert, color: Colors.black),
          SizedBox(width: 8),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1,
        ),
        itemCount: _categories.length,
        itemBuilder: (_, i) => _categoryCard(_categories[i]),
      ),
    );
  }

  Widget _categoryCard(Map cat) {
    return Container(
      decoration: BoxDecoration(
        color: Color(cat['color'] as int),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(cat['icon'] as IconData, color: Colors.white, size: 48),
          const SizedBox(height: 10),
          Text(
            cat['name'] as String,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${cat['items']} Items',
            style: TextStyle(color: Colors.white70, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
