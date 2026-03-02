import 'package:flutter/material.dart';

class SplashCoffeeImage extends StatelessWidget {
  const SplashCoffeeImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.lightBlueAccent.withOpacity(0.7), width: 2.5),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 20, offset: const Offset(0, 10))],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Image.network(
            'https://images.unsplash.com/photo-1497935586351-b67a49e012bf?w=700&q=80',
            fit: BoxFit.cover,
            width: double.infinity,
            loadingBuilder: (_, child, progress) {
              if (progress == null) return child;
              return Container(color: const Color(0xFFC8B99A), child: const Center(child: CircularProgressIndicator(color: Colors.white54)));
            },
            errorBuilder: (_, __, ___) => Container(color: const Color(0xFFC8B99A), child: const Icon(Icons.coffee, size: 80, color: Colors.white60)),
          ),
        ),
      ),
    );
  }
}
