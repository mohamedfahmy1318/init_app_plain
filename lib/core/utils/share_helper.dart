import 'dart:io';
import 'package:share_plus/share_plus.dart';
import 'package:bainona/core/utils/toast_helper.dart';

/// ========================================================
/// Share Helper
/// ========================================================
/// helper سهل للمشاركة باستخدام share_plus
/// ========================================================

class ShareHelper {
  ShareHelper._();

  /// مشاركة نص
  static Future<void> shareText(String text, {String? subject}) async {
    try {
      await Share.share(text, subject: subject);
    } catch (e) {
      ToastHelper.error('حدث خطأ في المشاركة');
    }
  }

  /// مشاركة ملف واحد
  static Future<void> shareFile(
    String filePath, {
    String? text,
    String? subject,
  }) async {
    try {
      final file = File(filePath);
      if (!await file.exists()) {
        ToastHelper.error('الملف غير موجود');
        return;
      }

      await Share.shareXFiles([XFile(filePath)], text: text, subject: subject);
    } catch (e) {
      ToastHelper.error('حدث خطأ في مشاركة الملف');
    }
  }

  /// مشاركة عدة ملفات
  static Future<void> shareFiles(
    List<String> filePaths, {
    String? text,
    String? subject,
  }) async {
    try {
      final xFiles = <XFile>[];

      for (final path in filePaths) {
        final file = File(path);
        if (await file.exists()) {
          xFiles.add(XFile(path));
        }
      }

      if (xFiles.isEmpty) {
        ToastHelper.error('لا توجد ملفات صالحة للمشاركة');
        return;
      }

      await Share.shareXFiles(xFiles, text: text, subject: subject);
    } catch (e) {
      ToastHelper.error('حدث خطأ في مشاركة الملفات');
    }
  }

  /// مشاركة رابط
  static Future<void> shareUrl(
    String url, {
    String? text,
    String? subject,
  }) async {
    try {
      final shareText = text != null ? '$text\n$url' : url;
      await Share.share(shareText, subject: subject);
    } catch (e) {
      ToastHelper.error('حدث خطأ في مشاركة الرابط');
    }
  }

  /// مشاركة تطبيق (مع رابط المتجر)
  static Future<void> shareApp({
    required String appName,
    required String packageName,
    String? message,
  }) async {
    try {
      final storeUrl = Platform.isIOS
          ? 'https://apps.apple.com/app/id$packageName'
          : 'https://play.google.com/store/apps/details?id=$packageName';

      final shareText = message != null
          ? '$message\n\nحمل تطبيق $appName:\n$storeUrl'
          : 'حمل تطبيق $appName:\n$storeUrl';

      await Share.share(shareText);
    } catch (e) {
      ToastHelper.error('حدث خطأ في مشاركة التطبيق');
    }
  }
}
