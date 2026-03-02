import 'package:flutter/material.dart';
import '../../models/coffee_model.dart';
import '../../utils/app_colors.dart';
import 'widgets/detail_header_image.dart';
import 'widgets/chocolate_selector.dart';
import 'widgets/size_selector.dart';
import 'widgets/detail_bottom_bar.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  String _selectedChocolate = 'Milk Chocolate';
  String _selectedSize = 'M';
  int _quantity = 1;
  bool _descExpanded = false;
  CoffeeModel? _coffee;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Lấy argument 1 lần duy nhất khi route đã sẵn sàng
    _coffee ??= ModalRoute.of(context)?.settings.arguments as CoffeeModel?
        ?? sampleCoffees[0];
  }

  CoffeeModel get coffee => _coffee ?? sampleCoffees[0];

  double get _totalPrice => coffee.price * _quantity;

  @override
  Widget build(BuildContext context) {
    final currentCoffee = coffee;
    return Scaffold(
      backgroundColor: AppColors.bgWhite,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DetailHeaderImage(coffee: currentCoffee),
                  _buildBody(currentCoffee),
                ],
              ),
            ),
          ),
          DetailBottomBar(
            totalPrice: _totalPrice,
            onAddToCart: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildBody(CoffeeModel coffee) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Description section
          const Text(
            'Description',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () => setState(() => _descExpanded = !_descExpanded),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  coffee.description,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textHint,
                    height: 1.7,
                  ),
                  maxLines: _descExpanded ? null : 3,
                  overflow: _descExpanded ? null : TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  _descExpanded ? 'Read less' : 'Read more',
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Divider
          const Divider(color: Color(0xFFEEEEEE), height: 1),
          const SizedBox(height: 24),
          // Chocolate
          ChocolateSelector(
            selected: _selectedChocolate,
            onChanged: (v) => setState(() => _selectedChocolate = v),
          ),
          const SizedBox(height: 24),
          // Divider
          const Divider(color: Color(0xFFEEEEEE), height: 1),
          const SizedBox(height: 24),
          // Size + quantity
          SizeSelector(
            selectedSize: _selectedSize,
            quantity: _quantity,
            onSizeChanged: (v) => setState(() => _selectedSize = v),
            onDecrease: () {
              if (_quantity > 1) setState(() => _quantity--);
            },
            onIncrease: () => setState(() => _quantity++),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
