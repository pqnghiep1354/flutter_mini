import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../config/themes/app_styles.dart';
import '../../../../models/user_model.dart';
import '../../../../providers/auth_provider.dart';

class EditProfileDialog extends StatefulWidget {
  final User user;
  const EditProfileDialog({super.key, required this.user});

  @override
  State<EditProfileDialog> createState() => _EditProfileDialogState();
}

class _EditProfileDialogState extends State<EditProfileDialog> {
  late final TextEditingController nameCtrl;
  late final TextEditingController phoneCtrl;
  late final TextEditingController addressCtrl;

  @override
  void initState() {
    super.initState();
    nameCtrl = TextEditingController(text: widget.user.name);
    phoneCtrl = TextEditingController(text: widget.user.phone ?? '');
    addressCtrl = TextEditingController(text: widget.user.address ?? '');
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    phoneCtrl.dispose();
    addressCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final auth = context.read<AuthProvider>();
    final success = await auth.updateProfile(
      name: nameCtrl.text.trim(),
      phone: phoneCtrl.text.trim(),
      address: addressCtrl.text.trim(),
    );
    if (mounted) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              success ? 'Cập nhật thành công!' : auth.error ?? 'Lỗi cập nhật'),
          backgroundColor: success ? const Color(0xFF43E97B) : Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Chỉnh sửa thông tin'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameCtrl,
              decoration: AppStyles.inputDecoration(
                hint: 'Tên',
                icon: Icons.person_outline,
              ),
            ),
            SizedBox(height: 12.h),
            TextField(
              controller: phoneCtrl,
              keyboardType: TextInputType.phone,
              decoration: AppStyles.inputDecoration(
                hint: 'Điện thoại',
                icon: Icons.phone_outlined,
              ),
            ),
            SizedBox(height: 12.h),
            TextField(
              controller: addressCtrl,
              decoration: AppStyles.inputDecoration(
                hint: 'Địa chỉ',
                icon: Icons.location_on_outlined,
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Hủy'),
        ),
        Consumer<AuthProvider>(
          builder: (context, auth, child) {
            return ElevatedButton(
              onPressed: auth.isLoading ? null : _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6C63FF),
                foregroundColor: Colors.white,
              ),
              child: auth.isLoading
                  ? SizedBox(
                      width: 20.w,
                      height: 20.w,
                      child: const CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white))
                  : const Text('Lưu'),
            );
          },
        ),
      ],
    );
  }
}
