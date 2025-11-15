import 'package:flutter/material.dart';
import 'package:bainona/core/widgets/app_widgets.dart';

/// ========================================================
/// Dialog Helper
/// ========================================================
/// helper لعرض Dialogs بسهولة
/// يدعم Loading, Success, Error, Confirmation
/// ========================================================

class DialogHelper {
  DialogHelper._();

  /// Loading Dialog
  static void showLoading(
    BuildContext context, {
    String message = 'جاري التحميل...',
    bool barrierDismissible = false,
  }) {
    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => WillPopScope(
        onWillPop: () async => barrierDismissible,
        child: Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 16),
                Text(
                  message,
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Success Dialog
  static void showSuccess(
    BuildContext context, {
    required String message,
    String? title,
    VoidCallback? onOk,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: title != null
            ? Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.green),
              )
            : null,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 64),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
        actions: [
          CustomButton(
            text: 'حسنًا',
            onPressed: () {
              Navigator.of(context).pop();
              onOk?.call();
            },
          ),
        ],
      ),
    );
  }

  /// Error Dialog
  static void showError(
    BuildContext context, {
    required String message,
    String? title,
    VoidCallback? onOk,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: title != null
            ? Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red),
              )
            : null,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error, color: Colors.red, size: 64),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
        actions: [
          CustomButton(
            text: 'حسنًا',
            onPressed: () {
              Navigator.of(context).pop();
              onOk?.call();
            },
          ),
        ],
      ),
    );
  }

  /// Confirmation Dialog
  static void showConfirmation(
    BuildContext context, {
    required String message,
    String? title,
    String confirmText = 'تأكيد',
    String cancelText = 'إلغاء',
    required VoidCallback onConfirm,
    VoidCallback? onCancel,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: title != null ? Text(title, textAlign: TextAlign.center) : null,
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16),
        ),
        actions: [
          CustomButton(
            text: cancelText,
            isOutlined: true,
            onPressed: () {
              Navigator.of(context).pop();
              onCancel?.call();
            },
          ),
          const SizedBox(width: 8),
          CustomButton(
            text: confirmText,
            onPressed: () {
              Navigator.of(context).pop();
              onConfirm.call();
            },
          ),
        ],
      ),
    );
  }

  /// Custom Dialog
  static void showCustom(
    BuildContext context, {
    required Widget content,
    String? title,
    List<Widget>? actions,
    bool barrierDismissible = true,
  }) {
    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => AlertDialog(
        title: title != null ? Text(title, textAlign: TextAlign.center) : null,
        content: content,
        actions: actions,
      ),
    );
  }

  /// إخفاء أي Dialog مفتوح
  static void hide(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }
}
