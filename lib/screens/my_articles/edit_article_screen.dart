import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../models/article_model.dart';
import '../../../models/category_model.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/settings_provider.dart';
import '../../../repos/article_repo.dart';
import '../../../config/themes/app_styles.dart';

class EditArticleScreen extends StatefulWidget {
  final Article article;
  const EditArticleScreen({super.key, required this.article});

  @override
  State<EditArticleScreen> createState() => _EditArticleScreenState();
}

class _EditArticleScreenState extends State<EditArticleScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleCtrl;
  late final TextEditingController _descCtrl;
  late final TextEditingController _contentCtrl;
  late final TextEditingController _thumbCtrl;
  int? _selectedCategoryId;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _titleCtrl = TextEditingController(text: widget.article.title);
    _descCtrl = TextEditingController(text: widget.article.description ?? '');
    _contentCtrl = TextEditingController(text: widget.article.content ?? '');
    _thumbCtrl = TextEditingController(text: widget.article.thumb ?? '');
    _selectedCategoryId = widget.article.categoryId;
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _descCtrl.dispose();
    _contentCtrl.dispose();
    _thumbCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedCategoryId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng chọn danh mục'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final auth = context.read<AuthProvider>();
    if (!auth.isLoggedIn || auth.token == null) return;

    setState(() => _isLoading = true);

    try {
      await ArticleRepo.update(
        auth.token!,
        widget.article.id,
        title: _titleCtrl.text.trim(),
        description: _descCtrl.text.trim(),
        content: _contentCtrl.text.trim(),
        categoryId: _selectedCategoryId!,
        thumb:
            _thumbCtrl.text.trim().isNotEmpty ? _thumbCtrl.text.trim() : null,
      );

      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Cập nhật bài viết thành công!'),
            backgroundColor: const Color(0xFF43E97B),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
        );
        Navigator.pop(context, true); // Pop out with success flag
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceFirst('Exception: ', '')),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: Text('Sửa bài viết',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp)),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1A1A2E),
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Tiêu đề',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                      color: const Color(0xFF1A1A2E))),
              SizedBox(height: 8.h),
              TextFormField(
                controller: _titleCtrl,
                validator: (v) => v == null || v.trim().isEmpty
                    ? 'Vui lòng nhập tiêu đề'
                    : null,
                style: TextStyle(fontSize: 15.sp),
                decoration: AppStyles.inputDecoration(
                  hint: 'Nhập tiêu đề bài viết',
                  icon: Icons.title,
                ),
              ),
              SizedBox(height: 20.h),
              Text('Danh mục',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                      color: const Color(0xFF1A1A2E))),
              SizedBox(height: 8.h),
              Selector<SettingsProvider, List<Category>>(
                selector: (context, settings) => settings.categories,
                builder: (context, categories, child) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<int>(
                        value: _selectedCategoryId,
                        hint: Text('Chọn danh mục',
                            style: TextStyle(
                                color: Colors.grey[400], fontSize: 15.sp)),
                        isExpanded: true,
                        icon: Icon(Icons.expand_more, size: 24.sp),
                        items: categories.map((Category c) {
                          return DropdownMenuItem<int>(
                            value: c.id,
                            child: Text(c.name),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() => _selectedCategoryId = value);
                        },
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 20.h),
              Text('Link ảnh (tùy chọn)',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                      color: const Color(0xFF1A1A2E))),
              SizedBox(height: 8.h),
              TextFormField(
                controller: _thumbCtrl,
                style: TextStyle(fontSize: 15.sp),
                decoration: AppStyles.inputDecoration(
                  hint: 'https://example.com/image.jpg',
                  icon: Icons.image_outlined,
                ),
              ),
              SizedBox(height: 20.h),
              Text('Mô tả ngắn',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                      color: const Color(0xFF1A1A2E))),
              SizedBox(height: 8.h),
              TextFormField(
                controller: _descCtrl,
                validator: (v) => v == null || v.trim().isEmpty
                    ? 'Vui lòng nhập mô tả'
                    : null,
                style: TextStyle(fontSize: 15.sp),
                decoration: AppStyles.inputDecoration(
                  hint: 'Nhập mô tả ngắn gọn...',
                  icon: Icons.description_outlined,
                ),
              ),
              SizedBox(height: 20.h),
              Text('Nội dung',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                      color: const Color(0xFF1A1A2E))),
              SizedBox(height: 8.h),
              TextFormField(
                controller: _contentCtrl,
                maxLines: 10,
                validator: (v) => v == null || v.trim().isEmpty
                    ? 'Vui lòng nhập nội dung'
                    : null,
                style: TextStyle(fontSize: 15.sp),
                decoration: AppStyles.inputDecoration(
                  hint: 'Nhập nội dung bài viết...',
                  icon: Icons.article_outlined,
                ),
              ),
              SizedBox(height: 32.h),
              SizedBox(
                width: double.infinity,
                height: 52.h,
                child: ElevatedButton.icon(
                  onPressed: _isLoading ? null : _submit,
                  icon: _isLoading
                      ? SizedBox(
                          width: 20.w,
                          height: 20.w,
                          child: const CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white))
                      : Icon(Icons.save, size: 22.sp),
                  label: Text(_isLoading ? 'Đang lưu...' : 'Lưu Thay Đổi',
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.w600)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6C63FF),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.r)),
                    elevation: 0,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
