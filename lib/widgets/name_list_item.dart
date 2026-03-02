import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/name_model.dart';
import '../providers/name_provider.dart';

class NameListItem extends StatelessWidget {
  final NameModel nameModel;

  const NameListItem({super.key, required this.nameModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Row(
        children: [
          // Nút xóa từng item
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.white, size: 20),
            onPressed: () {
              context.read<NameProvider>().removeName(nameModel.id);
            },
          ),
          const SizedBox(width: 4),
          // Tên
          Expanded(
            child: Text(
              nameModel.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
