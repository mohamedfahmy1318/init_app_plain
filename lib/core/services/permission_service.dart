/// ========================================================
/// Permission Service - خدمة الصلاحيات
/// ========================================================
/// إدارة صلاحيات التطبيق
/// ========================================================

import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  PermissionService._();

  // ==================== Request Single Permission ====================
  static Future<bool> requestPermission(Permission permission) async {
    final status = await permission.request();
    return status.isGranted;
  }

  // ==================== Request Multiple Permissions ====================
  static Future<Map<Permission, bool>> requestPermissions(
    List<Permission> permissions,
  ) async {
    final statuses = await permissions.request();
    return statuses.map((key, value) => MapEntry(key, value.isGranted));
  }

  // ==================== Check Permission ====================
  static Future<bool> checkPermission(Permission permission) async {
    final status = await permission.status;
    return status.isGranted;
  }

  // ==================== Check Multiple Permissions ====================
  static Future<Map<Permission, bool>> checkPermissions(
    List<Permission> permissions,
  ) async {
    final results = <Permission, bool>{};
    for (final permission in permissions) {
      results[permission] = await checkPermission(permission);
    }
    return results;
  }

  // ==================== Open Settings ====================
  static Future<bool> openSettings() async {
    return await openAppSettings();
  }

  // ==================== Camera Permission ====================
  static Future<bool> requestCameraPermission() async {
    return await requestPermission(Permission.camera);
  }

  static Future<bool> checkCameraPermission() async {
    return await checkPermission(Permission.camera);
  }

  // ==================== Photos Permission ====================
  static Future<bool> requestPhotosPermission() async {
    return await requestPermission(Permission.photos);
  }

  static Future<bool> checkPhotosPermission() async {
    return await checkPermission(Permission.photos);
  }

  // ==================== Location Permission ====================
  static Future<bool> requestLocationPermission() async {
    return await requestPermission(Permission.location);
  }

  static Future<bool> checkLocationPermission() async {
    return await checkPermission(Permission.location);
  }

  static Future<bool> requestLocationAlwaysPermission() async {
    return await requestPermission(Permission.locationAlways);
  }

  // ==================== Storage Permission ====================
  static Future<bool> requestStoragePermission() async {
    return await requestPermission(Permission.storage);
  }

  static Future<bool> checkStoragePermission() async {
    return await checkPermission(Permission.storage);
  }

  // ==================== Notification Permission ====================
  static Future<bool> requestNotificationPermission() async {
    return await requestPermission(Permission.notification);
  }

  static Future<bool> checkNotificationPermission() async {
    return await checkPermission(Permission.notification);
  }

  // ==================== Microphone Permission ====================
  static Future<bool> requestMicrophonePermission() async {
    return await requestPermission(Permission.microphone);
  }

  static Future<bool> checkMicrophonePermission() async {
    return await checkPermission(Permission.microphone);
  }

  // ==================== Contacts Permission ====================
  static Future<bool> requestContactsPermission() async {
    return await requestPermission(Permission.contacts);
  }

  static Future<bool> checkContactsPermission() async {
    return await checkPermission(Permission.contacts);
  }

  // ==================== Bluetooth Permission ====================
  static Future<bool> requestBluetoothPermission() async {
    return await requestPermission(Permission.bluetooth);
  }

  static Future<bool> checkBluetoothPermission() async {
    return await checkPermission(Permission.bluetooth);
  }
}
