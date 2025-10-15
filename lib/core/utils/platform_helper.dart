import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// Platform Helper for platform-specific operations
class PlatformHelper {
  static final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  /// Check if running on Android
  static bool get isAndroid => !kIsWeb && Platform.isAndroid;

  /// Check if running on iOS
  static bool get isIOS => !kIsWeb && Platform.isIOS;

  /// Check if running on Web
  static bool get isWeb => kIsWeb;

  /// Check if running on Desktop
  static bool get isDesktop => isWindows || isMacOS || isLinux;

  /// Check if running on Windows
  static bool get isWindows => !kIsWeb && Platform.isWindows;

  /// Check if running on macOS
  static bool get isMacOS => !kIsWeb && Platform.isMacOS;

  /// Check if running on Linux
  static bool get isLinux => !kIsWeb && Platform.isLinux;

  /// Check if running on Mobile
  static bool get isMobile => isAndroid || isIOS;

  /// Get platform name
  static String get platformName {
    if (isWeb) return 'Web';
    if (isAndroid) return 'Android';
    if (isIOS) return 'iOS';
    if (isWindows) return 'Windows';
    if (isMacOS) return 'macOS';
    if (isLinux) return 'Linux';
    return 'Unknown';
  }

  /// Get device info
  static Future<Map<String, dynamic>> getDeviceInfo() async {
    if (isAndroid) {
      final androidInfo = await _deviceInfo.androidInfo;
      return {
        'platform': 'Android',
        'model': androidInfo.model,
        'brand': androidInfo.brand,
        'device': androidInfo.device,
        'manufacturer': androidInfo.manufacturer,
        'version': androidInfo.version.release,
        'sdkInt': androidInfo.version.sdkInt,
        'isPhysicalDevice': androidInfo.isPhysicalDevice,
      };
    } else if (isIOS) {
      final iosInfo = await _deviceInfo.iosInfo;
      return {
        'platform': 'iOS',
        'model': iosInfo.model,
        'name': iosInfo.name,
        'systemName': iosInfo.systemName,
        'systemVersion': iosInfo.systemVersion,
        'isPhysicalDevice': iosInfo.isPhysicalDevice,
        'identifierForVendor': iosInfo.identifierForVendor,
      };
    } else if (isWeb) {
      final webInfo = await _deviceInfo.webBrowserInfo;
      return {
        'platform': 'Web',
        'browserName': webInfo.browserName.name,
        'browserPlatform': webInfo.platform,
        'userAgent': webInfo.userAgent,
      };
    } else if (isWindows) {
      final windowsInfo = await _deviceInfo.windowsInfo;
      return {
        'platform': 'Windows',
        'computerName': windowsInfo.computerName,
        'numberOfCores': windowsInfo.numberOfCores,
        'systemMemoryInMegabytes': windowsInfo.systemMemoryInMegabytes,
      };
    } else if (isMacOS) {
      final macOsInfo = await _deviceInfo.macOsInfo;
      return {
        'platform': 'macOS',
        'model': macOsInfo.model,
        'hostName': macOsInfo.hostName,
        'arch': macOsInfo.arch,
        'kernelVersion': macOsInfo.kernelVersion,
      };
    } else if (isLinux) {
      final linuxInfo = await _deviceInfo.linuxInfo;
      return {
        'platform': 'Linux',
        'name': linuxInfo.name,
        'version': linuxInfo.version,
        'id': linuxInfo.id,
        'machineId': linuxInfo.machineId,
      };
    }

    return {'platform': 'Unknown'};
  }

  /// Get app info
  static Future<Map<String, String>> getAppInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return {
      'appName': packageInfo.appName,
      'packageName': packageInfo.packageName,
      'version': packageInfo.version,
      'buildNumber': packageInfo.buildNumber,
    };
  }

  /// Execute platform-specific code
  static T platformSwitch<T>({
    required T android,
    required T ios,
    required T web,
    T? windows,
    T? macOS,
    T? linux,
    T? fallback,
  }) {
    if (isAndroid) return android;
    if (isIOS) return ios;
    if (isWeb) return web;
    if (isWindows && windows != null) return windows;
    if (isMacOS && macOS != null) return macOS;
    if (isLinux && linux != null) return linux;
    return fallback ?? android;
  }

  /// Get platform-specific padding for safe areas
  static EdgeInsets getPlatformPadding(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return EdgeInsets.only(
      top: mediaQuery.padding.top,
      bottom: mediaQuery.padding.bottom,
    );
  }

  /// Get status bar height
  static double getStatusBarHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }

  /// Get bottom safe area height
  static double getBottomSafeAreaHeight(BuildContext context) {
    return MediaQuery.of(context).padding.bottom;
  }

  /// Check if device has notch
  static bool hasNotch(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return padding.top > 24; // Usually status bar is 24dp
  }

  /// Get device screen size category
  static ScreenSize getScreenSize(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final diagonal = _calculateDiagonal(size.width, size.height);

    if (diagonal < 7) {
      return ScreenSize.small;
    } else if (diagonal < 10) {
      return ScreenSize.medium;
    } else if (diagonal < 12) {
      return ScreenSize.large;
    } else {
      return ScreenSize.extraLarge;
    }
  }

  /// Calculate diagonal screen size in inches
  static double _calculateDiagonal(double width, double height) {
    return (width * width + height * height) / 160; // Approximate
  }

  /// Get device orientation
  static Orientation getOrientation(BuildContext context) {
    return MediaQuery.of(context).orientation;
  }

  /// Check if device is in landscape mode
  static bool isLandscape(BuildContext context) {
    return getOrientation(context) == Orientation.landscape;
  }

  /// Check if device is in portrait mode
  static bool isPortrait(BuildContext context) {
    return getOrientation(context) == Orientation.portrait;
  }

  /// Get device pixel ratio
  static double getPixelRatio(BuildContext context) {
    return MediaQuery.of(context).devicePixelRatio;
  }

  /// Check if device is tablet
  static bool isTablet(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final diagonal = _calculateDiagonal(size.width, size.height);
    return diagonal >= 7;
  }

  /// Get text scale factor
  static double getTextScaleFactor(BuildContext context) {
    return MediaQuery.of(context).textScaleFactor;
  }

  /// Format storage size
  static String formatBytes(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(2)} KB';
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB';
  }

  /// Get device language
  static String getDeviceLanguage() {
    return Platform.localeName;
  }

  /// Get device locale
  static Locale getDeviceLocale() {
    final localeName = Platform.localeName;
    final parts = localeName.split('_');
    return Locale(parts[0], parts.length > 1 ? parts[1] : null);
  }

  /// Show platform-specific dialog
  static Future<T?> showPlatformDialog<T>({
    required BuildContext context,
    required String title,
    required String message,
    String confirmText = 'OK',
    String? cancelText,
  }) {
    if (isIOS) {
      return showDialog<T>(
        context: context,
        builder: (context) => AlertDialog.adaptive(
          title: Text(title),
          content: Text(message),
          actions: [
            if (cancelText != null)
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(cancelText),
              ),
            TextButton(
              onPressed: () => Navigator.pop(context, true as T),
              child: Text(confirmText),
            ),
          ],
        ),
      );
    }

    return showDialog<T>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          if (cancelText != null)
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(cancelText),
            ),
          TextButton(
            onPressed: () => Navigator.pop(context, true as T),
            child: Text(confirmText),
          ),
        ],
      ),
    );
  }
}

/// Screen size categories
enum ScreenSize {
  small, // Phone
  medium, // Large phone / Small tablet
  large, // Tablet
  extraLarge, // Large tablet / Desktop
}
