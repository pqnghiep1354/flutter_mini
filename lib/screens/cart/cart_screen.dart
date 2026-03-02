import 'package:flutter/material.dart';
import '../../models/coffee_model.dart';
import '../../utils/app_colors.dart';
import '../../widgets/bottom_nav_bar.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final List<CartItemModel> _items = List.generate(
    4,
    (index) => CartItemModel(
      coffee: sampleCoffees[index % sampleCoffees.length],
      quantity: 1,
      isSelected: index != 2, // 3rd item not selected (swipe to delete example)
    ),
  );

  int _swipedIndex = 2; // Show delete button for 3rd item

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _items.length,
                itemBuilder: (context, index) => _buildCartItem(index),
              ),
            ),
            _buildCheckoutBar(),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 2),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Column(
        children: [
          const Text(
            'Cart',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.primary,
            ),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Items(${_items.length * 5})',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItem(int index) {
    final item = _items[index];
    final isSwipedOpen = _swipedIndex == index;

    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity! < -200) {
          setState(() => _swipedIndex = index);
        } else if (details.primaryVelocity! > 200) {
          setState(() => _swipedIndex = -1);
        }
      },
      child: Stack(
        children: [
          // Delete button behind
          if (isSwipedOpen)
            Positioned.fill(
              child: Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _items.removeAt(index);
                      _swipedIndex = -1;
                    });
                  },
                  child: Container(
                    width: 70,
                    decoration: BoxDecoration(
                      color: AppColors.orange,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(Icons.delete_outline, color: Colors.white, size: 28),
                  ),
                ),
              ),
            ),
          // Card
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            transform: Matrix4.translationValues(
              isSwipedOpen ? -70 : 0,
              0,
              0,
            ),
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.07),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Checkbox
                  GestureDetector(
                    onTap: () {
                      setState(() => item.isSelected = !item.isSelected);
                    },
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: item.isSelected ? AppColors.primary : Colors.transparent,
                        border: Border.all(
                          color: item.isSelected ? AppColors.primary : Colors.grey.shade400,
                        ),
                      ),
                      child: item.isSelected
                          ? const Icon(Icons.check, color: Colors.white, size: 14)
                          : null,
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Coffee image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      item.coffee.imageUrl,
                      width: 72,
                      height: 72,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: 72,
                        height: 72,
                        color: Colors.brown.shade100,
                        child: const Icon(Icons.coffee, color: Colors.brown),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Cappucinno with\nchocolate',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'US \$10.00',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: AppColors.textDark,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Delivery fee: US \$50',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.orange.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Quantity controls
                  Row(
                    children: [
                      _QuantityButton(
                        icon: Icons.remove,
                        onTap: () {
                          if (item.quantity > 1) {
                            setState(() => item.quantity--);
                          }
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          '${item.quantity}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      _QuantityButton(
                        icon: Icons.add,
                        onTap: () => setState(() => item.quantity++),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckoutBar() {
    final total = _items
        .where((i) => i.isSelected)
        .fold<double>(0, (sum, i) => sum + 10.0 * i.quantity);
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 12,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Total', style: TextStyle(color: AppColors.textGrey)),
              Text(
                'US \$${total.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(width: 20),
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'Checkout',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuantityButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _QuantityButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(icon, size: 14),
      ),
    );
  }
}
