import 'package:flutter/material.dart';

class Screen4 extends StatefulWidget {
  const Screen4({super.key});

  @override
  State<Screen4> createState() => _Screen4State();
}

class _Screen4State extends State<Screen4> {
  final List<DonutItem> items = [
    DonutItem(
      name: 'Chocolate',
      brand: "Dunkin's",
      price: 5,
      rating: 4.9,
      imageUrl:
          'https://images.unsplash.com/photo-1551024601-bec78aea704b?w=200',
    ),
    DonutItem(
      name: 'Filled',
      brand: 'Dunkins',
      price: 5,
      rating: 4.9,
      imageUrl:
          'https://images.unsplash.com/photo-1558961363-fa8fdf82db35?w=200',
    ),
    DonutItem(
      name: 'Careemy',
      brand: "Dunkin's",
      price: 5,
      rating: 4.9,
      imageUrl:
          'https://images.unsplash.com/photo-1556913396-7a3c459ef68e?w=200',
    ),
    DonutItem(
      name: 'Decadent',
      brand: "Dunkin's",
      price: 5,
      rating: 4.9,
      imageUrl:
          'https://images.unsplash.com/photo-1551024601-bec78aea704b?w=200',
    ),
    DonutItem(
      name: 'Careemy',
      brand: "Dunkin's",
      price: 5,
      rating: 4.9,
      imageUrl:
          'https://images.unsplash.com/photo-1556913396-7a3c459ef68e?w=200',
    ),
    DonutItem(
      name: 'Decadent',
      brand: "Dunkin's",
      price: 5,
      rating: 4.9,
      imageUrl:
          'https://images.unsplash.com/photo-1551024601-bec78aea704b?w=200',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Screen 4',
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.85,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) => _DonutCard(item: items[index]),
      ),
    );
  }
}

class _DonutCard extends StatefulWidget {
  final DonutItem item;
  const _DonutCard({required this.item});

  @override
  State<_DonutCard> createState() => _DonutCardState();
}

class _DonutCardState extends State<_DonutCard> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Donut image
                Center(
                  child: Image.network(
                    widget.item.imageUrl,
                    width: double.infinity,
                    height: 110,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => Container(
                      height: 110,
                      color: Colors.pink.shade50,
                      child: const Icon(
                        Icons.donut_large,
                        size: 60,
                        color: Colors.pinkAccent,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                // Name
                Text(
                  widget.item.name,
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                // Brand
                Text(
                  widget.item.brand,
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                ),
                const Spacer(),
                // Bottom row: heart + rating
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => setState(() => isFavorite = !isFavorite),
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.grey,
                        size: 20,
                      ),
                    ),
                    const Spacer(),
                    const Icon(Icons.star, color: Colors.amber, size: 16),
                    const SizedBox(width: 2),
                    Text(
                      widget.item.rating.toString(),
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Price badge
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFFCE4EC),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '\$${widget.item.price}',
                style: const TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DonutItem {
  final String name;
  final String brand;
  final int price;
  final double rating;
  final String imageUrl;

  const DonutItem({
    required this.name,
    required this.brand,
    required this.price,
    required this.rating,
    required this.imageUrl,
  });
}
