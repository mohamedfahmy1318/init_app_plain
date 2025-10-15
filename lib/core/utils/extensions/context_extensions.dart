/// ========================================================
/// Context Extensions - امتدادات الـ Context
/// ========================================================

import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  // ==================== Theme ====================
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colorScheme => theme.colorScheme;

  // ==================== MediaQuery ====================
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get screenSize => mediaQuery.size;
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;
  EdgeInsets get padding => mediaQuery.padding;
  EdgeInsets get viewInsets => mediaQuery.viewInsets;
  double get statusBarHeight => padding.top;
  double get bottomBarHeight => padding.bottom;

  // ==================== Navigation ====================
  NavigatorState get navigator => Navigator.of(this);
  
  void pop<T>([T? result]) => navigator.pop(result);
  
  Future<T?> push<T>(Widget page) => navigator.push<T>(
        MaterialPageRoute(builder: (_) => page),
      );
  
  Future<T?> pushReplacement<T>(Widget page) => navigator.pushReplacement<T, dynamic>(
        MaterialPageRoute(builder: (_) => page),
      );
  
  Future<T?> pushAndRemoveUntil<T>(Widget page) => navigator.pushAndRemoveUntil<T>(
        MaterialPageRoute(builder: (_) => page),
        (route) => false,
      );

  // ==================== Snackbar ====================
  void showSnackBar(
    String message, {
    Color? backgroundColor,
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        duration: duration,
        action: action,
      ),
    );
  }

  void showSuccessSnackBar(String message) {
    showSnackBar(message, backgroundColor: Colors.green);
  }

  void showErrorSnackBar(String message) {
    showSnackBar(message, backgroundColor: Colors.red);
  }

  void showInfoSnackBar(String message) {
    showSnackBar(message, backgroundColor: Colors.blue);
  }

  // ==================== Dialog ====================
  Future<T?> showCustomDialog<T>({
    required Widget child,
    bool barrierDismissible = true,
  }) {
    return showDialog<T>(
      context: this,
      barrierDismissible: barrierDismissible,
      builder: (_) => child,
    );
  }

  Future<bool?> showConfirmDialog({
    String title = 'تأكيد',
    required String message,
    String confirmText = 'تأكيد',
    String cancelText = 'إلغاء',
  }) {
    return showDialog<bool>(
      context: this,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => navigator.pop(false),
            child: Text(cancelText),
          ),
          ElevatedButton(
            onPressed: () => navigator.pop(true),
            child: Text(confirmText),
          ),
        ],
      ),
    );
  }

  // ==================== Loading Dialog ====================
  void showLoadingDialog({String? message}) {
    showDialog(
      context: this,
      barrierDismissible: false,
      builder: (_) => WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          content: Row(
            children: [
              const CircularProgressIndicator(),
              const SizedBox(width: 16),
              Text(message ?? 'جاري التحميل...'),
            ],
          ),
        ),
      ),
    );
  }

  void hideLoadingDialog() {
    navigator.pop();
  }

  // ==================== Bottom Sheet ====================
  Future<T?> showCustomBottomSheet<T>({
    required Widget child,
    bool isDismissible = true,
    bool enableDrag = true,
  }) {
    return showModalBottomSheet<T>(
      context: this,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => child,
    );
  }

  // ==================== Keyboard ====================
  void hideKeyboard() {
    FocusScope.of(this).unfocus();
  }

  bool get isKeyboardVisible => viewInsets.bottom > 0;
}
