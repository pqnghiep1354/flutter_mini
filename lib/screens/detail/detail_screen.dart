import 'package:flutter/material.dart';
import '../../models/coffee_model.dart';
import '../../utils/app_colors.dart';
import '../../apps/routers/router_name.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  String _selectedChocolate = 'White Chocolate';
  String _selectedSize = 'S';
  int _quantity = 1;

  final _chocolates = ['White Chocolate', 'Milk Chocolate', 'Dark Cho...'];
  final _sizes = ['S', 'M', 'L'];

  @override
  Widget build(BuildContext context) {
    final coffee = ModalRoute.of(context)?.settings.arguments as CoffeeModel? ?? sampleCoffees[0];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeroImage(context, coffee),
            _buildInfo(coffee),
            _buildDescription(),
            _buildChocolateChoice(),
            _buildSizeChoice(),
            _buildPriceAndBuy(coffee),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroImage(BuildContext context, CoffeeModel coffee) {
    return Stack(
      children: [
        SizedBox(
          height: 280,
          width: double.infinity,
          child: Image.network(
            'https://images.unsplash.com/photo-1461023058943-07fcbe16d735?w=600',
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              height: 280,
              color: Colors.brown.shade300,
              child: const Icon(Icons.coffee, size: 80, color: Colors.white),
            ),
          ),
        ),
        // Overlay gradient
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.2),
                  Colors.black.withOpacity(0.5),
                ],
              ),
            ),
          ),
        ),
        // Back & Home buttons
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _CircleButton(
                  icon: Icons.arrow_back_ios_new_rounded,
                  onTap: () => Navigator.pop(context),
                ),
                Row(
                  children: [
                    _CircleButton(
                      icon: Icons.home_rounded,
                      onTap: () => Navigator.pushNamedAndRemoveUntil(
                        context,
                        RouterName.home,
                        (route) => false,
                      ),
                    ),
                    const SizedBox(width: 10),
                    _CircleButton(
                      icon: Icons.favorite,
                      iconColor: Colors.red,
                      onTap: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        // Coffee name overlay at bottom of image
        Positioned(
          bottom: 16,
          left: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                coffee.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                coffee.subtitle,
                style: const TextStyle(color: Colors.white70, fontSize: 13),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.orange, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    '${coffee.rating} (6,900)',
                    style: const TextStyle(color: Colors.white, fontSize: 13),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: Row(
            children: [
              _InfoChip(label: 'Coffee'),
              const SizedBox(width: 8),
              _InfoChip(label: 'Chocolate'),
              const SizedBox(width: 8),
              _InfoChip(label: 'Medium roasted'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfo(CoffeeModel coffee) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
    );
  }

  Widget _buildDescription() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Drscription',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Coffee is a beloved beverage enjoyed by millions worldwide for its rich flavor, invigorating aroma, and stimulating properties.',
            style: TextStyle(
              fontSize: 13,
              color: AppColors.primary,
              height: 1.6,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChocolateChoice() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Choice of Chocolate',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _chocolates.map((choc) {
                final isSelected = _selectedChocolate == choc;
                return GestureDetector(
                  onTap: () => setState(() => _selectedChocolate = choc),
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primary : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected ? AppColors.primary : Colors.grey.shade300,
                      ),
                    ),
                    child: Text(
                      choc,
                      style: TextStyle(
                        color: isSelected ? Colors.white : AppColors.textDark,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSizeChoice() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Size',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              ..._sizes.map((size) {
                final isSelected = _selectedSize == size;
                return GestureDetector(
                  onTap: () => setState(() => _selectedSize = size),
                  child: Container(
                    margin: const EdgeInsets.only(right: 12),
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primary : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected ? AppColors.primary : Colors.grey.shade300,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        size,
                        style: TextStyle(
                          color: isSelected ? Colors.white : AppColors.textDark,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              }),
              const Spacer(),
              // Quantity
              _QuantityControl(
                quantity: _quantity,
                onDecrease: () {
                  if (_quantity > 1) setState(() => _quantity--);
                },
                onIncrease: () => setState(() => _quantity++),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPriceAndBuy(CoffeeModel coffee) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Price',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                '\$ ${(coffee.price * _quantity).toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              const Spacer(),
              SizedBox(
                width: 160,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Added to cart!')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Buy Now',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color iconColor;

  const _CircleButton({
    required this.icon,
    required this.onTap,
    this.iconColor = Colors.black87,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 18, color: iconColor),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final String label;

  const _InfoChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: const TextStyle(color: Colors.white, fontSize: 10),
      ),
    );
  }
}

class _QuantityControl extends StatelessWidget {
  final int quantity;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;

  const _QuantityControl({
    required this.quantity,
    required this.onDecrease,
    required this.onIncrease,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onDecrease,
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.remove, size: 16),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            '$quantity',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        GestureDetector(
          onTap: onIncrease,
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.add, size: 16, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
