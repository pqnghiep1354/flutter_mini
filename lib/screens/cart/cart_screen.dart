import 'package:flutter/material.dart';
import '../../models/coffee_model.dart';
import '../../utils/app_colors.dart';
import 'widgets/cart_header.dart';
import 'widgets/cart_item_tile.dart';
import 'widgets/cart_checkout_bar.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late List<CartItem> _items;

  @override
  void initState() {
    super.initState();
    _items = [
      CartItem(coffee: sampleCoffees[6], quantity: 1, chocolateType: 'Milk Chocolate',  size: 'M'),
      CartItem(coffee: sampleCoffees[4], quantity: 2, chocolateType: 'White Chocolate', size: 'L'),
      CartItem(coffee: sampleCoffees[0], quantity: 1, chocolateType: 'Dark Chocolate',  size: 'S'),
      CartItem(coffee: sampleCoffees[9], quantity: 1, chocolateType: 'Milk Chocolate',  size: 'M'),
    ];
  }

  double get _subtotal => _items.where((i) => i.isSelected).fold(0.0, (sum, i) => sum + i.totalPrice);
  int    get _selectedCount => _items.where((i) => i.isSelected).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: SafeArea(
        child: Column(
          children: [
            CartHeader(itemCount: _items.length),
            const SizedBox(height: 16),
            Expanded(
              child: _items.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: _items.length,
                      itemBuilder: (context, index) => CartItemTile(
                        item: _items[index],
                        onDelete:       () => setState(() => _items.removeAt(index)),
                        onToggleSelect: () => setState(() => _items[index].isSelected = !_items[index].isSelected),
                        onIncrease:     () => setState(() => _items[index].quantity++),
                        onDecrease:     () { if (_items[index].quantity > 1) setState(() => _items[index].quantity--); },
                      ),
                    ),
            ),
            CartCheckoutBar(total: _subtotal, selectedCount: _selectedCount),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_bag_outlined, size: 72, color: AppColors.textGrey.withOpacity(0.4)),
          const SizedBox(height: 16),
          const Text('Your cart is empty', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.textGrey)),
          const SizedBox(height: 8),
          const Text('Add some coffee to get started', style: TextStyle(fontSize: 13, color: AppColors.textGrey)),
        ],
      ),
    );
  }
}
