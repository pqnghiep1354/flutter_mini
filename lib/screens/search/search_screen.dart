import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/search_provider.dart';
import 'widgets/search_field_widget.dart';
import 'widgets/search_results_widget.dart';

/// Màn hình định tuyến: HIỂN THỊ UI, KHÔNG XỬ LÝ LOGIC.
/// Tối ưu UI: Không dùng context.watch ở build to nhất
/// mà lấy context.read() để gọi hàm và dùng Consumer bọc vùng dữ liệu thay đổi.
/// Clean Code: SearchField và SearchResults được tách thành các file riêng.
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchCtrl = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _searchCtrl.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  // Ghi nhận input người dùng và gọi hàm tương ứng trong Provider
  void _onSearchChanged(String value) {
    setState(
        () {}); // Thay đổi trạng thái UI của TextField để hiển thị nút clear
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      context.read<SearchProvider>().search(value);
    });
  }

  void _clearSearch() {
    _searchCtrl.clear();
    setState(() {}); // Thay đổi trạng thái UI của TextField để ẩn nút clear
    context.read<SearchProvider>().clear();
  }

  @override
  Widget build(BuildContext context) {
    // KHÔNG dùng context.watch ở đây để tránh rebuild nguyên cả màn hình AppBar
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1A1A2E),
        title: SearchFieldWidget(
          searchCtrl: _searchCtrl,
          onChanged: _onSearchChanged,
          onClear: _clearSearch,
        ),
      ),
      // Chỉ truyền Context xuống, vùng Body sẽ tự đăng ký lắng nghe Provider thông qua Consumer
      body: SearchResultsWidget(searchTerm: _searchCtrl.text),
    );
  }
}
