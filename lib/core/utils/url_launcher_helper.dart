import 'package:url_launcher/url_launcher.dart';
import 'package:Bynona/core/utils/toast_helper.dart';

/// ========================================================
/// URL Launcher Helper
/// ========================================================
/// helper سهل لفتح الروابط والاتصال والبريد
/// ========================================================

class UrlLauncherHelper {
  UrlLauncherHelper._();

  /// فتح رابط في المتصفح
  static Future<bool> openUrl(String url) async {
    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        return await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        ToastHelper.error('لا يمكن فتح الرابط');
        return false;
      }
    } catch (e) {
      ToastHelper.error('حدث خطأ في فتح الرابط');
      return false;
    }
  }

  /// فتح رابط في WebView داخل التطبيق
  static Future<bool> openUrlInApp(String url) async {
    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        return await launchUrl(uri, mode: LaunchMode.inAppWebView);
      } else {
        ToastHelper.error('لا يمكن فتح الرابط');
        return false;
      }
    } catch (e) {
      ToastHelper.error('حدث خطأ في فتح الرابط');
      return false;
    }
  }

  /// اتصال هاتفي
  static Future<bool> makePhoneCall(String phoneNumber) async {
    try {
      final uri = Uri.parse('tel:$phoneNumber');
      if (await canLaunchUrl(uri)) {
        return await launchUrl(uri);
      } else {
        ToastHelper.error('لا يمكن إجراء المكالمة');
        return false;
      }
    } catch (e) {
      ToastHelper.error('حدث خطأ في الاتصال');
      return false;
    }
  }

  /// إرسال SMS
  static Future<bool> sendSMS(String phoneNumber, {String? message}) async {
    try {
      final uri = Uri.parse(
        'sms:$phoneNumber${message != null ? '?body=${Uri.encodeComponent(message)}' : ''}',
      );
      if (await canLaunchUrl(uri)) {
        return await launchUrl(uri);
      } else {
        ToastHelper.error('لا يمكن إرسال الرسالة');
        return false;
      }
    } catch (e) {
      ToastHelper.error('حدث خطأ في إرسال الرسالة');
      return false;
    }
  }

  /// إرسال بريد إلكتروني
  static Future<bool> sendEmail({
    required String email,
    String? subject,
    String? body,
  }) async {
    try {
      final uri = Uri(
        scheme: 'mailto',
        path: email,
        queryParameters: {
          if (subject != null) 'subject': subject,
          if (body != null) 'body': body,
        },
      );
      if (await canLaunchUrl(uri)) {
        return await launchUrl(uri);
      } else {
        ToastHelper.error('لا يمكن إرسال البريد');
        return false;
      }
    } catch (e) {
      ToastHelper.error('حدث خطأ في إرسال البريد');
      return false;
    }
  }

  /// فتح WhatsApp
  static Future<bool> openWhatsApp(
    String phoneNumber, {
    String? message,
  }) async {
    try {
      // إزالة الأصفار والمسافات من البداية
      phoneNumber = phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');
      if (phoneNumber.startsWith('00')) {
        phoneNumber = '+${phoneNumber.substring(2)}';
      } else if (!phoneNumber.startsWith('+')) {
        phoneNumber = '+$phoneNumber';
      }

      final uri = Uri.parse(
        'https://wa.me/$phoneNumber${message != null ? '?text=${Uri.encodeComponent(message)}' : ''}',
      );
      return await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      ToastHelper.error('حدث خطأ في فتح واتساب');
      return false;
    }
  }

  /// فتح موقع على الخريطة (Google Maps)
  static Future<bool> openMap({
    required double latitude,
    required double longitude,
    String? label,
  }) async {
    try {
      final uri = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude${label != null ? '&query_place_id=$label' : ''}',
      );
      return await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      ToastHelper.error('حدث خطأ في فتح الخريطة');
      return false;
    }
  }

  /// فتح تطبيق في المتجر (Google Play / App Store)
  static Future<bool> openStore(String packageName) async {
    try {
      final uri = Uri.parse(
        'https://play.google.com/store/apps/details?id=$packageName',
      );
      return await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      ToastHelper.error('حدث خطأ في فتح المتجر');
      return false;
    }
  }
}
