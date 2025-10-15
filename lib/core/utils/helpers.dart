/// ========================================================
/// Helpers - مساعدات عامة
/// ========================================================
/// دوال مساعدة غير متوفرة في الـ Helpers المتخصصة
/// ========================================================

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Helpers {
  Helpers._();

  // ==================== Copy to Clipboard ====================
  static Future<void> copyToClipboard(
    String text, {
    String? successMessage,
  }) async {
    try {
      await Clipboard.setData(ClipboardData(text: text));
      debugPrint(successMessage ?? 'تم النسخ');
    } catch (e) {
      debugPrint('Error copying to clipboard: $e');
    }
  }

  /// الحصول من Clipboard
  static Future<String?> getFromClipboard() async {
    try {
      final data = await Clipboard.getData(Clipboard.kTextPlain);
      return data?.text;
    } catch (e) {
      debugPrint('Error getting from clipboard: $e');
      return null;
    }
  }

  // ==================== Hide Keyboard ====================
  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  /// Show Keyboard
  static void showKeyboard(BuildContext context, FocusNode focusNode) {
    FocusScope.of(context).requestFocus(focusNode);
  }

  // ==================== Check Network Image ====================
  static bool isNetworkImage(String? path) {
    if (path == null) return false;
    return path.startsWith('http://') || path.startsWith('https://');
  }

  /// Check if Asset Image
  static bool isAssetImage(String? path) {
    if (path == null) return false;
    return path.startsWith('assets/');
  }

  // ==================== Generate Random String ====================
  static String generateRandomString(int length) {
    const chars =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    final random = DateTime.now().millisecondsSinceEpoch;
    return List.generate(
      length,
      (index) => chars[(random + index) % chars.length],
    ).join();
  }

  // ==================== Wait ====================
  static Future<void> wait(Duration duration) async {
    await Future.delayed(duration);
  }

  // ==================== Vibrate ====================
  static Future<void> vibrate({
    Duration duration = const Duration(milliseconds: 100),
  }) async {
    try {
      await HapticFeedback.vibrate();
    } catch (e) {
      debugPrint('Error vibrating: $e');
    }
  }

  /// Light Haptic Feedback
  static void lightHaptic() {
    HapticFeedback.lightImpact();
  }

  /// Medium Haptic Feedback
  static void mediumHaptic() {
    HapticFeedback.mediumImpact();
  }

  /// Heavy Haptic Feedback
  static void heavyHaptic() {
    HapticFeedback.heavyImpact();
  }

  /// Selection Haptic
  static void selectionHaptic() {
    HapticFeedback.selectionClick();
  }
}
