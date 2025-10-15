import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

/// ========================================================
/// Connectivity Helper
/// ========================================================
/// helper للتحقق من الاتصال بالإنترنت
/// يستخدم connectivity_plus و internet_connection_checker_plus
/// ========================================================

class ConnectivityHelper {
  ConnectivityHelper._();

  static final _connectivity = Connectivity();
  static final _internetChecker = InternetConnection();

  /// التحقق من وجود اتصال بالإنترنت (فعلي)
  static Future<bool> hasInternetConnection() async {
    try {
      return await _internetChecker.hasInternetAccess;
    } catch (e) {
      return false;
    }
  }

  /// التحقق من نوع الاتصال (WiFi, Mobile, None)
  static Future<List<ConnectivityResult>> checkConnectivity() async {
    try {
      return await _connectivity.checkConnectivity();
    } catch (e) {
      return [ConnectivityResult.none];
    }
  }

  /// هل متصل بـ WiFi
  static Future<bool> isConnectedToWiFi() async {
    final results = await checkConnectivity();
    return results.contains(ConnectivityResult.wifi);
  }

  /// هل متصل بـ Mobile Data
  static Future<bool> isConnectedToMobile() async {
    final results = await checkConnectivity();
    return results.contains(ConnectivityResult.mobile);
  }

  /// Stream للاستماع لتغييرات الاتصال
  static Stream<List<ConnectivityResult>> get onConnectivityChanged {
    return _connectivity.onConnectivityChanged;
  }

  /// Stream للاستماع لحالة الإنترنت الفعلية
  static Stream<InternetStatus> get onInternetStatusChanged {
    return _internetChecker.onStatusChange;
  }

  /// الانتظار حتى يتوفر الإنترنت
  static Future<void> waitForInternet({
    Duration timeout = const Duration(seconds: 30),
  }) async {
    final completer = Completer<void>();
    StreamSubscription<InternetStatus>? subscription;

    // تحقق أولي
    if (await hasInternetConnection()) {
      completer.complete();
      return completer.future;
    }

    // استمع للتغييرات
    subscription = onInternetStatusChanged.listen((status) {
      if (status == InternetStatus.connected && !completer.isCompleted) {
        subscription?.cancel();
        completer.complete();
      }
    });

    // Timeout
    Future.delayed(timeout, () {
      if (!completer.isCompleted) {
        subscription?.cancel();
        completer.completeError('انتهت مهلة الانتظار للاتصال بالإنترنت');
      }
    });

    return completer.future;
  }

  /// تنفيذ عملية فقط عند توفر الإنترنت
  static Future<T?> executeWhenOnline<T>({
    required Future<T> Function() action,
    VoidCallback? onOffline,
  }) async {
    if (await hasInternetConnection()) {
      return await action();
    } else {
      onOffline?.call();
      return null;
    }
  }

  /// الحصول على سرعة الاتصال (تقريبية)
  static Future<double> getConnectionSpeed() async {
    try {
      final stopwatch = Stopwatch()..start();
      await _internetChecker.hasInternetAccess;
      stopwatch.stop();
      
      // سرعة تقريبية بالميجابت/ثانية
      final milliseconds = stopwatch.elapsedMilliseconds;
      if (milliseconds < 100) return 10.0; // Fast
      if (milliseconds < 300) return 5.0;  // Medium
      return 1.0; // Slow
    } catch (e) {
      return 0.0;
    }
  }
}

/// Callback type
typedef VoidCallback = void Function();
