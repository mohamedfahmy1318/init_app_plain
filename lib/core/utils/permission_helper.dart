/// ========================================================
/// Permission Handler Helper - مساعد إدارة الصلاحيات
/// ========================================================
/// استخدم هذا الملف لطلب الصلاحيات بسهولة
/// ========================================================

import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';

class PermissionHelper {
  // ==================== Camera Permission ====================
  static Future<bool> requestCamera(BuildContext context) async {
    final status = await Permission.camera.request();
    
    if (status.isGranted) {
      return true;
    } else if (status.isDenied) {
      _showPermissionDialog(
        context,
        'إذن الكاميرا',
        'نحتاج الوصول للكاميرا لالتقاط الصور',
      );
      return false;
    } else if (status.isPermanentlyDenied) {
      _showSettingsDialog(context, 'إذن الكاميرا');
      return false;
    }
    return false;
  }

  // ==================== Photos Permission ====================
  static Future<bool> requestPhotos(BuildContext context) async {
    final status = await Permission.photos.request();
    
    if (status.isGranted) {
      return true;
    } else if (status.isDenied) {
      _showPermissionDialog(
        context,
        'إذن الصور',
        'نحتاج الوصول للصور لاختيار الصور من المعرض',
      );
      return false;
    } else if (status.isPermanentlyDenied) {
      _showSettingsDialog(context, 'إذن الصور');
      return false;
    }
    return false;
  }

  // ==================== Location Permission ====================
  static Future<bool> requestLocation(BuildContext context) async {
    final status = await Permission.location.request();
    
    if (status.isGranted) {
      return true;
    } else if (status.isDenied) {
      _showPermissionDialog(
        context,
        'إذن الموقع',
        'نحتاج موقعك لتوفير خدمات أفضل',
      );
      return false;
    } else if (status.isPermanentlyDenied) {
      _showSettingsDialog(context, 'إذن الموقع');
      return false;
    }
    return false;
  }

  // ==================== Location Always Permission ====================
  static Future<bool> requestLocationAlways(BuildContext context) async {
    final status = await Permission.locationAlways.request();
    
    if (status.isGranted) {
      return true;
    } else if (status.isDenied) {
      _showPermissionDialog(
        context,
        'إذن الموقع في الخلفية',
        'نحتاج موقعك في الخلفية لتتبع الطلبات',
      );
      return false;
    } else if (status.isPermanentlyDenied) {
      _showSettingsDialog(context, 'إذن الموقع في الخلفية');
      return false;
    }
    return false;
  }

  // ==================== Notification Permission ====================
  static Future<bool> requestNotification(BuildContext context) async {
    final status = await Permission.notification.request();
    
    if (status.isGranted) {
      return true;
    } else if (status.isDenied) {
      _showPermissionDialog(
        context,
        'إذن الإشعارات',
        'نحتاج إرسال إشعارات لإعلامك بالتحديثات',
      );
      return false;
    } else if (status.isPermanentlyDenied) {
      _showSettingsDialog(context, 'إذن الإشعارات');
      return false;
    }
    return false;
  }

  // ==================== Microphone Permission ====================
  static Future<bool> requestMicrophone(BuildContext context) async {
    final status = await Permission.microphone.request();
    
    if (status.isGranted) {
      return true;
    } else if (status.isDenied) {
      _showPermissionDialog(
        context,
        'إذن الميكروفون',
        'نحتاج الوصول للميكروفون لتسجيل الصوت',
      );
      return false;
    } else if (status.isPermanentlyDenied) {
      _showSettingsDialog(context, 'إذن الميكروفون');
      return false;
    }
    return false;
  }

  // ==================== Multiple Permissions ====================
  static Future<Map<Permission, PermissionStatus>> requestMultiple(
    List<Permission> permissions,
  ) async {
    return await permissions.request();
  }

  // ==================== Check Permission Status ====================
  static Future<bool> isGranted(Permission permission) async {
    final status = await permission.status;
    return status.isGranted;
  }

  // ==================== Check if permission is permanently denied ====================
  static Future<bool> isPermanentlyDenied(Permission permission) async {
    final status = await permission.status;
    return status.isPermanentlyDenied;
  }

  // ==================== Request Camera & Photos (for Image Picker) ====================
  static Future<bool> requestCameraAndPhotos(BuildContext context) async {
    final permissions = await [
      Permission.camera,
      Permission.photos,
    ].request();

    final allGranted = permissions.values.every((status) => status.isGranted);
    
    if (!allGranted) {
      if (!context.mounted) return false;
      _showPermissionDialog(
        context,
        'إذن الكاميرا والصور',
        'نحتاج الوصول للكاميرا والصور لالتقاط واختيار الصور',
      );
      return false;
    }
    
    return true;
  }

  // ==================== Request Location & Notification (for Maps) ====================
  static Future<bool> requestLocationAndNotification(BuildContext context) async {
    final permissions = await [
      Permission.location,
      Permission.notification,
    ].request();

    final allGranted = permissions.values.every((status) => status.isGranted);
    
    if (!allGranted) {
      if (!context.mounted) return false;
      _showPermissionDialog(
        context,
        'إذن الموقع والإشعارات',
        'نحتاج موقعك وإرسال إشعارات لتحسين الخدمة',
      );
      return false;
    }
    
    return true;
  }

  // ==================== Helper: Show Permission Dialog ====================
  static void _showPermissionDialog(
    BuildContext context,
    String title,
    String message,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('حسناً'),
          ),
        ],
      ),
    );
  }

  // ==================== Helper: Show Settings Dialog ====================
  static void _showSettingsDialog(
    BuildContext context,
    String permissionName,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('تم رفض $permissionName بشكل دائم'),
        content: const Text(
          'يجب السماح بالإذن من الإعدادات. هل تريد فتح الإعدادات؟',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              openAppSettings();
            },
            child: const Text('فتح الإعدادات'),
          ),
        ],
      ),
    );
  }

  // ==================== Open App Settings ====================
  static Future<void> openSettings() async {
    await openAppSettings();
  }

  // ==================== Check all permissions status ====================
  static Future<Map<String, bool>> checkAllPermissions() async {
    return {
      'camera': await Permission.camera.isGranted,
      'photos': await Permission.photos.isGranted,
      'location': await Permission.location.isGranted,
      'locationAlways': await Permission.locationAlways.isGranted,
      'notification': await Permission.notification.isGranted,
      'microphone': await Permission.microphone.isGranted,
    };
  }

  // ==================== Request all permissions at once ====================
  static Future<bool> requestAllPermissions(BuildContext context) async {
    final permissions = await [
      Permission.camera,
      Permission.photos,
      Permission.location,
      Permission.notification,
    ].request();

    final deniedPermissions = permissions.entries
        .where((entry) => !entry.value.isGranted)
        .map((entry) => entry.key.toString())
        .toList();

    if (deniedPermissions.isNotEmpty) {
      if (!context.mounted) return false;
      _showPermissionDialog(
        context,
        'بعض الصلاحيات مرفوضة',
        'تم رفض: ${deniedPermissions.join(', ')}\n\nيمكنك السماح بها لاحقاً من الإعدادات',
      );
      return false;
    }

    return true;
  }
}

/// ========================================================
/// Usage Examples - أمثلة الاستخدام
/// ========================================================
/// 
/// 1. طلب صلاحية واحدة:
/// ```dart
/// final granted = await PermissionHelper.requestCamera(context);
/// if (granted) {
///   // Use camera
/// }
/// ```
/// 
/// 2. طلب أكثر من صلاحية:
/// ```dart
/// final granted = await PermissionHelper.requestCameraAndPhotos(context);
/// if (granted) {
///   // Use image picker
/// }
/// ```
/// 
/// 3. التحقق من حالة الصلاحية:
/// ```dart
/// final isGranted = await PermissionHelper.isGranted(Permission.camera);
/// if (isGranted) {
///   // Camera is already granted
/// }
/// ```
/// 
/// 4. فتح الإعدادات:
/// ```dart
/// await PermissionHelper.openSettings();
/// ```
/// 
/// 5. التحقق من كل الصلاحيات:
/// ```dart
/// final statuses = await PermissionHelper.checkAllPermissions();
/// print('Camera: ${statuses['camera']}');
/// print('Location: ${statuses['location']}');
/// ```
/// ========================================================
