import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchFieldWidget extends StatelessWidget {
  final TextEditingController searchCtrl;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;

  const SearchFieldWidget({
    super.key,
    required this.searchCtrl,
    required this.onChanged,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchCtrl,
      autofocus: true,
      onChanged: onChanged,
      style: TextStyle(fontSize: 16.sp),
      decoration: InputDecoration(
        hintText: 'Tìm kiếm bài viết...',
        hintStyle: TextStyle(color: Colors.grey[400], fontSize: 15.sp),
        border: InputBorder.none,
        suffixIcon: searchCtrl.text.isNotEmpty
            ? IconButton(
                icon: Icon(Icons.close, size: 20.sp),
                onPressed: onClear,
              )
            : null,
      ),
    );
  }
}
