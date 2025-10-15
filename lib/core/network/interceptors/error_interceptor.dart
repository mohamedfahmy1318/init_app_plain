/// ========================================================
/// Error Interceptor - معترض الأخطاء
/// ========================================================
/// يتعامل مع جميع أخطاء الشبكة ويحولها لرسائل مفهومة
/// ========================================================

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../api_exceptions.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint('❌ Error Type: ${err.type}');
    debugPrint('❌ Error Message: ${err.message}');
    debugPrint('❌ Error Response: ${err.response}');

    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw TimeoutException(err.requestOptions);

      case DioExceptionType.badResponse:
        switch (err.response?.statusCode) {
          case 400:
            throw BadRequestException(
              err.requestOptions,
              err.response,
            );
          case 401:
            throw UnauthorizedException(
              err.requestOptions,
              err.response,
            );
          case 403:
            throw ForbiddenException(
              err.requestOptions,
              err.response,
            );
          case 404:
            throw NotFoundException(
              err.requestOptions,
              err.response,
            );
          case 409:
            throw ConflictException(
              err.requestOptions,
              err.response,
            );
          case 422:
            throw ValidationException(
              err.requestOptions,
              err.response,
            );
          case 500:
          case 501:
          case 502:
          case 503:
            throw InternalServerException(
              err.requestOptions,
              err.response,
            );
          default:
            throw UnknownException(
              err.requestOptions,
              err.response,
            );
        }

      case DioExceptionType.cancel:
        throw RequestCancelledException(err.requestOptions);

      case DioExceptionType.unknown:
        throw NoInternetException(err.requestOptions);

      default:
        throw UnknownException(err.requestOptions, err.response);
    }
  }
}
