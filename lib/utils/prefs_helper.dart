import 'package:shared_preferences/shared_preferences.dart';

/// Wrapper đơn giản cho SharedPreferences
class PrefsHelper {
  PrefsHelper._();

  static const String _keyHasSeenSplash = 'has_seen_splash';

  /// Trả về true nếu user đã từng xem splash
  static Future<bool> hasSeenSplash() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyHasSeenSplash) ?? false;
  }

  /// Đánh dấu đã xem splash
  static Future<void> markSplashSeen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyHasSeenSplash, true);
  }

  /// Xoá flag (dùng để debug / reset onboarding)
  static Future<void> resetSplash() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyHasSeenSplash);
  }
}
