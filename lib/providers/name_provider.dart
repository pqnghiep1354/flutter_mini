import 'package:flutter/foundation.dart';
import '../models/name_model.dart';

class NameProvider extends ChangeNotifier {
  final List<NameModel> _names = [];

  List<NameModel> get names => List.unmodifiable(_names);

  /// Thêm tên mới vào danh sách
  void addName(String name) {
    if (name.trim().isEmpty) return;
    final newName = NameModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name.trim(),
    );
    _names.add(newName);
    notifyListeners();
  }

  /// Xóa một tên theo id
  void removeName(String id) {
    _names.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  /// Xóa tất cả tên
  void removeAll() {
    _names.clear();
    notifyListeners();
  }
}
