/// ========================================================
/// Logging Interceptor - معترض السجلات
/// ========================================================
/// يطبع تفاصيل الطلبات والردود في وضع التطوير
/// ========================================================

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('┌──────────────────────────────────────────────────');
    debugPrint('│ 🚀 REQUEST: ${options.method} ${options.uri}');
    debugPrint('├──────────────────────────────────────────────────');
    debugPrint('│ Headers:');
    options.headers.forEach((key, value) {
      debugPrint('│   $key: $value');
    });
    if (options.queryParameters.isNotEmpty) {
      debugPrint('│ Query Parameters:');
      options.queryParameters.forEach((key, value) {
        debugPrint('│   $key: $value');
      });
    }
    if (options.data != null) {
      debugPrint('│ Body: ${options.data}');
    }
    debugPrint('└──────────────────────────────────────────────────');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint('┌──────────────────────────────────────────────────');
    debugPrint('│ ✅ RESPONSE: ${response.statusCode} ${response.requestOptions.uri}');
    debugPrint('├──────────────────────────────────────────────────');
    debugPrint('│ Headers:');
    response.headers.map.forEach((key, value) {
      debugPrint('│   $key: $value');
    });
    debugPrint('│ Data: ${response.data}');
    debugPrint('└──────────────────────────────────────────────────');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint('┌──────────────────────────────────────────────────');
    debugPrint('│ ❌ ERROR: ${err.response?.statusCode} ${err.requestOptions.uri}');
    debugPrint('├──────────────────────────────────────────────────');
    debugPrint('│ Error Type: ${err.type}');
    debugPrint('│ Error Message: ${err.message}');
    if (err.response != null) {
      debugPrint('│ Response Data: ${err.response?.data}');
    }
    debugPrint('└──────────────────────────────────────────────────');
    handler.next(err);
  }
}
