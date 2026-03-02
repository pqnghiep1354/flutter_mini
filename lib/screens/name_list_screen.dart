import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/name_provider.dart';
import '../widgets/name_input_field.dart';
import '../widgets/submit_button.dart';
import '../widgets/name_list_container.dart';

class NameListScreen extends StatefulWidget {
  const NameListScreen({super.key});

  @override
  State<NameListScreen> createState() => _NameListScreenState();
}

class _NameListScreenState extends State<NameListScreen> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    final text = _nameController.text;
    if (text.trim().isNotEmpty) {
      context.read<NameProvider>().addName(text);
      _nameController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Provider',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        leading: const Padding(
          padding: EdgeInsets.only(left: 8),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Bt12',
              style: TextStyle(color: Colors.lightBlue, fontSize: 14),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          const SizedBox(height: 16),
          // Ô nhập tên
          NameInputField(controller: _nameController),
          const SizedBox(height: 12),
          // Nút submit
          SubmitButton(onPressed: _handleSubmit),
          const SizedBox(height: 8),
          // Danh sách tên (chiếm phần còn lại)
          const Expanded(
            child: NameListContainer(),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
