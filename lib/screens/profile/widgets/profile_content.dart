import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../models/user_model.dart';
import 'change_password_dialog.dart';
import 'edit_profile_dialog.dart';

class ProfileContent extends StatelessWidget {
  final User user;
  const ProfileContent({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50.r,
            backgroundColor: const Color(0xFF6C63FF).withValues(alpha: 0.1),
            child:
                Icon(Icons.person, size: 50.sp, color: const Color(0xFF6C63FF)),
          ),
          SizedBox(height: 16.h),
          Text(user.name,
              style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1A1A2E))),
          SizedBox(height: 4.h),
          Text(user.email,
              style: TextStyle(color: Colors.grey[500], fontSize: 14.sp)),
          SizedBox(height: 32.h),
          _buildInfoCard(
            items: [
              _InfoItem(
                  icon: Icons.person_outline, label: 'Tên', value: user.name),
              _InfoItem(
                  icon: Icons.email_outlined,
                  label: 'Email',
                  value: user.email),
              _InfoItem(
                  icon: Icons.phone_outlined,
                  label: 'Điện thoại',
                  value: user.phone ?? 'Chưa cập nhật'),
              _InfoItem(
                  icon: Icons.location_on_outlined,
                  label: 'Địa chỉ',
                  value: user.address ?? 'Chưa cập nhật'),
            ],
          ),
          SizedBox(height: 24.h),
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: ElevatedButton.icon(
              onPressed: () => _showEditDialog(context, user),
              icon: Icon(Icons.edit, size: 20.sp),
              label: const Text('Chỉnh sửa thông tin'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6C63FF),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r)),
                elevation: 0,
              ),
            ),
          ),
          SizedBox(height: 12.h),
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: OutlinedButton.icon(
              onPressed: () => _showChangePasswordDialog(context),
              icon: Icon(Icons.lock_outline, size: 20.sp),
              label: const Text('Đổi mật khẩu'),
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF6C63FF),
                side: const BorderSide(color: Color(0xFF6C63FF)),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({required List<_InfoItem> items}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        children: items.asMap().entries.map((entry) {
          final item = entry.value;
          final isLast = entry.key == items.length - 1;
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                child: Row(
                  children: [
                    Icon(item.icon,
                        color: const Color(0xFF6C63FF), size: 22.sp),
                    SizedBox(width: 12.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.label,
                            style: TextStyle(
                                color: Colors.grey[500], fontSize: 12.sp)),
                        SizedBox(height: 2.h),
                        Text(item.value,
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: const Color(0xFF1A1A2E))),
                      ],
                    ),
                  ],
                ),
              ),
              if (!isLast) Divider(height: 1, indent: 50.w),
            ],
          );
        }).toList(),
      ),
    );
  }

  void _showEditDialog(BuildContext context, User user) {
    showDialog(
      context: context,
      builder: (_) => EditProfileDialog(user: user),
    );
  }

  void _showChangePasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => const ChangePasswordDialog(),
    );
  }
}

class _InfoItem {
  final IconData icon;
  final String label;
  final String value;
  const _InfoItem(
      {required this.icon, required this.label, required this.value});
}
