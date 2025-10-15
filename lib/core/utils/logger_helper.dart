import 'package:logger/logger.dart';

/// ========================================================
/// Logger Helper
/// ========================================================
/// helper للطباعة المنظمة في الـ Console
/// يستخدم package logger
/// ========================================================

class LoggerHelper {
  LoggerHelper._();

  static final _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
    ),
  );

  static final _simpleLogger = Logger(
    printer: SimplePrinter(),
  );

  /// Debug - معلومات للتطوير
  static void debug(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    _logger.d(message, error: error, stackTrace: stackTrace);
  }

  /// Info - معلومات عامة
  static void info(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    _logger.i(message, error: error, stackTrace: stackTrace);
  }

  /// Warning - تحذير
  static void warning(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    _logger.w(message, error: error, stackTrace: stackTrace);
  }

  /// Error - خطأ
  static void error(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }

  /// Fatal - خطأ فادح
  static void fatal(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    _logger.f(message, error: error, stackTrace: stackTrace);
  }

  /// Trace - تتبع
  static void trace(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    _logger.t(message, error: error, stackTrace: stackTrace);
  }

  /// Simple log بدون تنسيق
  static void simple(dynamic message) {
    _simpleLogger.d(message);
  }

  /// Log للـ API Request
  static void apiRequest({
    required String method,
    required String url,
    Map<String, dynamic>? headers,
    dynamic body,
  }) {
    _logger.i(
      '🌐 API REQUEST\n'
      'Method: $method\n'
      'URL: $url\n'
      '${headers != null ? 'Headers: $headers\n' : ''}'
      '${body != null ? 'Body: $body' : ''}',
    );
  }

  /// Log للـ API Response
  static void apiResponse({
    required int statusCode,
    required String url,
    dynamic data,
    dynamic error,
  }) {
    if (statusCode >= 200 && statusCode < 300) {
      _logger.i(
        '✅ API RESPONSE\n'
        'Status: $statusCode\n'
        'URL: $url\n'
        'Data: $data',
      );
    } else {
      _logger.e(
        '❌ API ERROR\n'
        'Status: $statusCode\n'
        'URL: $url\n'
        'Error: $error',
      );
    }
  }

  /// Log للـ Navigation
  static void navigation(String from, String to) {
    _logger.i('🧭 Navigation: $from → $to');
  }

  /// Log للـ Bloc Events
  static void blocEvent(String blocName, String eventName) {
    _logger.d('🎯 Bloc Event: $blocName → $eventName');
  }

  /// Log للـ Bloc States
  static void blocState(String blocName, String stateName) {
    _logger.i('📊 Bloc State: $blocName → $stateName');
  }

  /// Log للـ Cache
  static void cache(String operation, String key, {dynamic value}) {
    _logger.d(
      '💾 Cache $operation\n'
      'Key: $key\n'
      '${value != null ? 'Value: $value' : ''}',
    );
  }

  /// Log للـ Performance
  static void performance(String operation, Duration duration) {
    _logger.i(
      '⚡ Performance\n'
      'Operation: $operation\n'
      'Duration: ${duration.inMilliseconds}ms',
    );
  }

  /// قياس وقت تنفيذ عملية
  static Future<T> measureTime<T>({
    required String operation,
    required Future<T> Function() action,
  }) async {
    final stopwatch = Stopwatch()..start();
    try {
      final result = await action();
      stopwatch.stop();
      performance(operation, stopwatch.elapsed);
      return result;
    } catch (e) {
      stopwatch.stop();
      error('Error in $operation after ${stopwatch.elapsed}', error: e);
      rethrow;
    }
  }
}
