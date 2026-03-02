import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/name_provider.dart';
import 'name_list_item.dart';

class NameListContainer extends StatelessWidget {
  const NameListContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Nút xóa tất cả
        Padding(
          padding: const EdgeInsets.only(right: 24, top: 8),
          child: IconButton(
            icon: const Icon(Icons.delete, color: Colors.lightBlue, size: 24),
            tooltip: 'Xóa tất cả',
            onPressed: () {
              context.read<NameProvider>().removeAll();
            },
          ),
        ),
        // Danh sách tên
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF4FC3F7), // Xanh đậm hơn ở trên
                  Color(0xFFB3E5FC), // Xanh nhạt ở dưới
                ],
              ),
            ),
            child: Consumer<NameProvider>(
              builder: (context, nameProvider, child) {
                final names = nameProvider.names;

                if (names.isEmpty) {
                  return const Center(
                    child: Text(
                      'Chưa có tên nào',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: names.length,
                  itemBuilder: (context, index) {
                    return NameListItem(nameModel: names[index]);
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
