import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../config/themes/app_styles.dart';
import '../../../../providers/auth_provider.dart';

class ChangePasswordDialog extends StatefulWidget {
  const ChangePasswordDialog({super.key});

  @override
  State<ChangePasswordDialog> createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<ChangePasswordDialog> {
  final oldPwCtrl = TextEditingController();
  final newPwCtrl = TextEditingController();

  @override
  void dispose() {
    oldPwCtrl.dispose();
    newPwCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final auth = context.read<AuthProvider>();
    final success = await auth.changePassword(
      oldPassword: oldPwCtrl.text,
      newPassword: newPwCtrl.text,
    );
    if (mounted) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(success
              ? 'Đổi mật khẩu thành công!'
              : auth.error ?? 'Lỗi đổi mật khẩu'),
          backgroundColor: success ? const Color(0xFF43E97B) : Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Đổi mật khẩu'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: oldPwCtrl,
            obscureText: true,
            decoration: AppStyles.inputDecoration(
              hint: 'Mật khẩu cũ',
              icon: Icons.lock_outline,
            ),
          ),
          SizedBox(height: 12.h),
          TextField(
            controller: newPwCtrl,
            obscureText: true,
            decoration: AppStyles.inputDecoration(
              hint: 'Mật khẩu mới',
              icon: Icons.lock,
            ),
          ),
        ],
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
                  : const Text('Xác nhận'),
            );
          },
        ),
      ],
    );
  }
}
