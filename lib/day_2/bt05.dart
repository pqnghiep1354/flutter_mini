import 'package:flutter/material.dart';

class Bt05 extends StatelessWidget {
  const Bt05({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                          text: 'Hello ',
                          style: TextStyle(color: Colors.black),
                        ),
                        TextSpan(
                          text: 'ZendVN',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 44,
                    height: 44,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Horizontal scrollable cards
              SizedBox(
                height: 80,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  separatorBuilder: (_, _) => const SizedBox(width: 10),
                  itemBuilder: (_, _) => _gradientCard(width: 80, height: 80),
                ),
              ),
              const SizedBox(height: 20),

              // List Of Article title
              const Text(
                'List Of Article',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              // Article list
              Expanded(
                child: ListView.separated(
                  itemCount: 8,
                  separatorBuilder: (_, _) => const SizedBox(height: 10),
                  itemBuilder: (_, _) => _articleRow(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _gradientCard({required double width, required double height}) {
    return AspectRatio(
      aspectRatio: 2 / 1,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFBBDEFB), Color(0xFF64B5F6)],
          ),
        ),
      ),
    );
  }

  Widget _articleRow() {
    return Row(
      children: [
        const SizedBox(
          width: 52,
          child: Text(
            '08:AM',
            style: TextStyle(fontSize: 13, color: Colors.black54),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            height: 36,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: const LinearGradient(
                colors: [Color(0xFFBBDEFB), Color(0xFF90CAF9)],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
