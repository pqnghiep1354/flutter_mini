import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              _box(50, 50, radius: 12),
              const SizedBox(width: 12),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                _box(160, 20, radius: 6),
                const SizedBox(height: 8),
                _box(200, 14, radius: 6),
              ]),
            ]),
            const SizedBox(height: 28),
            _box(120, 18, radius: 6),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: 1.4,
              ),
              itemCount: 4,
              itemBuilder: (_, __) =>
                  _box(double.infinity, double.infinity, radius: 16),
            ),
            const SizedBox(height: 28),
            _box(100, 18, radius: 6),
            const SizedBox(height: 16),
            ...List.generate(
                3,
                (_) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Row(children: [
                        _box(120, 90, radius: 16),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _box(double.infinity, 14, radius: 6),
                              const SizedBox(height: 8),
                              _box(double.infinity, 14, radius: 6),
                              const SizedBox(height: 8),
                              _box(80, 12, radius: 6),
                            ],
                          ),
                        ),
                      ]),
                    )),
          ],
        ),
      ),
    );
  }

  static Widget _box(double w, double h, {double radius = 8}) {
    return Container(
      width: w,
      height: h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
