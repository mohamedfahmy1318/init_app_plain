import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

/// Log levels
enum LogLevel {
  debug,
  info,
  warning,
  error,
  fatal,
}

/// Advanced Logger Service
class LoggerService {
  static final LoggerService _instance = LoggerService._internal();
  factory LoggerService() => _instance;
  LoggerService._internal();

  late final Logger _logger;
  bool _isInitialized = false;

  /// Initialize logger
  void init({
    LogLevel minLevel = LogLevel.debug,
    bool enableInRelease = false,
  }) {
    if (_isInitialized) return;

    _logger = Logger(
      filter: CustomLogFilter(minLevel, enableInRelease),
      printer: PrettyPrinter(
        methodCount: 2,
        errorMethodCount: 8,
        lineLength: 120,
        colors: true,
        printEmojis: true,
        printTime: true,
      ),
      output: ConsoleOutput(),
    );

    _isInitialized = true;
  }

  /// Log debug message
  void debug(
    dynamic message, {
    dynamic error,
    StackTrace? stackTrace,
    String? tag,
  }) {
    if (!_isInitialized) init();
    final formattedMessage = _formatMessage(message, tag);
    _logger.d(formattedMessage, error: error, stackTrace: stackTrace);
  }

  /// Log info message
  void info(
    dynamic message, {
    dynamic error,
    StackTrace? stackTrace,
    String? tag,
  }) {
    if (!_isInitialized) init();
    final formattedMessage = _formatMessage(message, tag);
    _logger.i(formattedMessage, error: error, stackTrace: stackTrace);
  }

  /// Log warning message
  void warning(
    dynamic message, {
    dynamic error,
    StackTrace? stackTrace,
    String? tag,
  }) {
    if (!_isInitialized) init();
    final formattedMessage = _formatMessage(message, tag);
    _logger.w(formattedMessage, error: error, stackTrace: stackTrace);
  }

  /// Log error message
  void error(
    dynamic message, {
    dynamic error,
    StackTrace? stackTrace,
    String? tag,
  }) {
    if (!_isInitialized) init();
    final formattedMessage = _formatMessage(message, tag);
    _logger.e(formattedMessage, error: error, stackTrace: stackTrace);
  }

  /// Log fatal message
  void fatal(
    dynamic message, {
    dynamic error,
    StackTrace? stackTrace,
    String? tag,
  }) {
    if (!_isInitialized) init();
    final formattedMessage = _formatMessage(message, tag);
    _logger.f(formattedMessage, error: error, stackTrace: stackTrace);
  }

  /// Log network request
  void logRequest(
    String method,
    String url, {
    Map<String, dynamic>? headers,
    dynamic body,
  }) {
    if (!_isInitialized) init();
    
    final buffer = StringBuffer();
    buffer.writeln('🌐 API REQUEST');
    buffer.writeln('Method: $method');
    buffer.writeln('URL: $url');
    
    if (headers != null) {
      buffer.writeln('Headers: $headers');
    }
    
    if (body != null) {
      buffer.writeln('Body: $body');
    }
    
    _logger.d(buffer.toString());
  }

  /// Log network response
  void logResponse(
    int statusCode,
    String url, {
    dynamic response,
    Duration? duration,
  }) {
    if (!_isInitialized) init();
    
    final buffer = StringBuffer();
    buffer.writeln('📥 API RESPONSE');
    buffer.writeln('Status: $statusCode');
    buffer.writeln('URL: $url');
    
    if (duration != null) {
      buffer.writeln('Duration: ${duration.inMilliseconds}ms');
    }
    
    if (response != null) {
      buffer.writeln('Response: $response');
    }
    
    if (statusCode >= 200 && statusCode < 300) {
      _logger.i(buffer.toString());
    } else {
      _logger.e(buffer.toString());
    }
  }

  /// Log BLoC event
  void logBlocEvent(String blocName, String eventName, {dynamic data}) {
    if (!_isInitialized) init();
    
    final buffer = StringBuffer();
    buffer.writeln('📢 BLOC EVENT');
    buffer.writeln('Bloc: $blocName');
    buffer.writeln('Event: $eventName');
    
    if (data != null) {
      buffer.writeln('Data: $data');
    }
    
    _logger.d(buffer.toString());
  }

  /// Log BLoC state
  void logBlocState(String blocName, String stateName, {dynamic data}) {
    if (!_isInitialized) init();
    
    final buffer = StringBuffer();
    buffer.writeln('🎯 BLOC STATE');
    buffer.writeln('Bloc: $blocName');
    buffer.writeln('State: $stateName');
    
    if (data != null) {
      buffer.writeln('Data: $data');
    }
    
    _logger.d(buffer.toString());
  }

  /// Log navigation
  void logNavigation(String from, String to, {dynamic arguments}) {
    if (!_isInitialized) init();
    
    final buffer = StringBuffer();
    buffer.writeln('🧭 NAVIGATION');
    buffer.writeln('From: $from');
    buffer.writeln('To: $to');
    
    if (arguments != null) {
      buffer.writeln('Arguments: $arguments');
    }
    
    _logger.i(buffer.toString());
  }

  /// Format message with tag
  String _formatMessage(dynamic message, String? tag) {
    if (tag != null) {
      return '[$tag] $message';
    }
    return message.toString();
  }

  /// Log to developer console (for Timeline)
  void logTimeline(String message, {Map<String, dynamic>? arguments}) {
    developer.log(
      message,
      name: 'Timeline',
      time: DateTime.now(),
    );
  }
}

/// Custom log filter
class CustomLogFilter extends LogFilter {
  final LogLevel minLevel;
  final bool enableInRelease;

  CustomLogFilter(this.minLevel, this.enableInRelease);

  @override
  bool shouldLog(LogEvent event) {
    // Don't log in release mode unless explicitly enabled
    if (kReleaseMode && !enableInRelease) {
      return false;
    }

    // Check minimum level
    final eventLevel = _getLogLevel(event.level);
    return eventLevel.index >= minLevel.index;
  }

  LogLevel _getLogLevel(Level level) {
    switch (level) {
      case Level.debug:
        return LogLevel.debug;
      case Level.info:
        return LogLevel.info;
      case Level.warning:
        return LogLevel.warning;
      case Level.error:
        return LogLevel.error;
      case Level.fatal:
        return LogLevel.fatal;
      default:
        return LogLevel.debug;
    }
  }
}
