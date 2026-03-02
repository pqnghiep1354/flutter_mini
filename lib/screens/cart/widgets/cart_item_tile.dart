import 'package:flutter/material.dart';
import '../../../models/coffee_model.dart';
import '../../../utils/app_colors.dart';
import '../../../widgets/quantity_counter.dart';

class CartItemTile extends StatefulWidget {
  final CartItem item;
  final VoidCallback onDelete;
  final VoidCallback onToggleSelect;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  const CartItemTile({
    super.key,
    required this.item,
    required this.onDelete,
    required this.onToggleSelect,
    required this.onIncrease,
    required this.onDecrease,
  });

  @override
  State<CartItemTile> createState() => _CartItemTileState();
}

class _CartItemTileState extends State<CartItemTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  bool _isOpen = false;

  static const double _deleteWidth = 72;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-_deleteWidth / 375, 0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    if (_isOpen) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
    setState(() => _isOpen = !_isOpen);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity! < -300 && !_isOpen) _toggle();
        if (details.primaryVelocity! > 300 && _isOpen) _toggle();
      },
      child: SizedBox(
        height: 100,
        child: Stack(
          children: [
            // Delete button (behind)
            Positioned(
              right: 0,
              top: 0,
              bottom: 10,
              width: _deleteWidth,
              child: GestureDetector(
                onTap: () {
                  _controller.reverse();
                  setState(() => _isOpen = false);
                  widget.onDelete();
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 8),
                  decoration: BoxDecoration(
                    color: AppColors.orange,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.delete_outline_rounded, color: Colors.white, size: 24),
                      SizedBox(height: 2),
                      Text('Delete', style: TextStyle(color: Colors.white, fontSize: 10)),
                    ],
                  ),
                ),
              ),
            ),
            // Sliding card
            SlideTransition(
              position: _slideAnimation,
              child: _buildCard(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard() {
    final item = widget.item;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Checkbox
          GestureDetector(
            onTap: widget.onToggleSelect,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: item.isSelected ? AppColors.primary : Colors.transparent,
                border: Border.all(
                  color: item.isSelected ? AppColors.primary : Colors.grey.shade400,
                  width: 1.8,
                ),
              ),
              child: item.isSelected
                  ? const Icon(Icons.check_rounded, color: Colors.white, size: 15)
                  : null,
            ),
          ),
          const SizedBox(width: 12),
          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              item.coffee.imageUrl,
              width: 70,
              height: 70,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 70,
                height: 70,
                color: Colors.brown.shade50,
                child: const Icon(Icons.coffee, color: Colors.brown),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item.coffee.name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  '${item.chocolateType} · ${item.size}',
                  style: const TextStyle(fontSize: 11, color: AppColors.textGrey),
                ),
                const SizedBox(height: 6),
                Text(
                  'US \$${item.coffee.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDark,
                  ),
                ),
              ],
            ),
          ),
          // Quantity controls
          QuantityCounter(
            quantity: item.quantity,
            onDecrease: widget.onDecrease,
            onIncrease: widget.onIncrease,
            darkMode: false,
          ),
        ],
      ),
    );
  }
}
