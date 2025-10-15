/// ========================================================
/// API Exceptions - استثناءات الـ API
/// ========================================================
/// يحتوي على جميع أنواع الأخطاء المخصصة للـ API
/// ========================================================

import 'package:dio/dio.dart';

abstract class ApiException implements Exception {
  final RequestOptions requestOptions;
  final Response? response;

  ApiException(this.requestOptions, [this.response]);

  String get message;
  int? get statusCode => response?.statusCode;
}

// ==================== Timeout Exception ====================
class TimeoutException extends ApiException {
  TimeoutException(super.requestOptions);

  @override
  String get message => 'انتهت مهلة الاتصال. يرجى المحاولة مرة أخرى.';
}

// ==================== No Internet Exception ====================
class NoInternetException extends ApiException {
  NoInternetException(super.requestOptions);

  @override
  String get message => 'لا يوجد اتصال بالإنترنت. يرجى التحقق من الاتصال.';
}

// ==================== Request Cancelled Exception ====================
class RequestCancelledException extends ApiException {
  RequestCancelledException(super.requestOptions);

  @override
  String get message => 'تم إلغاء الطلب.';
}

// ==================== Bad Request Exception (400) ====================
class BadRequestException extends ApiException {
  BadRequestException(super.requestOptions, super.response);

  @override
  String get message {
    try {
      final data = response?.data;
      if (data is Map && data.containsKey('message')) {
        return data['message'];
      }
      return 'طلب غير صحيح. يرجى التحقق من البيانات المدخلة.';
    } catch (e) {
      return 'طلب غير صحيح. يرجى التحقق من البيانات المدخلة.';
    }
  }
}

// ==================== Unauthorized Exception (401) ====================
class UnauthorizedException extends ApiException {
  UnauthorizedException(super.requestOptions, super.response);

  @override
  String get message => 'انتهت جلسة الدخول. يرجى تسجيل الدخول مرة أخرى.';
}

// ==================== Forbidden Exception (403) ====================
class ForbiddenException extends ApiException {
  ForbiddenException(super.requestOptions, super.response);

  @override
  String get message => 'ليس لديك صلاحية للوصول إلى هذا المحتوى.';
}

// ==================== Not Found Exception (404) ====================
class NotFoundException extends ApiException {
  NotFoundException(super.requestOptions, super.response);

  @override
  String get message => 'المحتوى المطلوب غير موجود.';
}

// ==================== Conflict Exception (409) ====================
class ConflictException extends ApiException {
  ConflictException(super.requestOptions, super.response);

  @override
  String get message {
    try {
      final data = response?.data;
      if (data is Map && data.containsKey('message')) {
        return data['message'];
      }
      return 'يوجد تعارض مع البيانات الموجودة.';
    } catch (e) {
      return 'يوجد تعارض مع البيانات الموجودة.';
    }
  }
}

// ==================== Validation Exception (422) ====================
class ValidationException extends ApiException {
  ValidationException(super.requestOptions, super.response);

  @override
  String get message {
    try {
      final data = response?.data;
      if (data is Map && data.containsKey('errors')) {
        final errors = data['errors'] as Map;
        if (errors.isNotEmpty) {
          final firstError = errors.values.first;
          if (firstError is List && firstError.isNotEmpty) {
            return firstError.first.toString();
          }
          return firstError.toString();
        }
      }
      if (data is Map && data.containsKey('message')) {
        return data['message'];
      }
      return 'البيانات المدخلة غير صحيحة.';
    } catch (e) {
      return 'البيانات المدخلة غير صحيحة.';
    }
  }

  Map<String, dynamic>? get errors {
    try {
      final data = response?.data;
      if (data is Map && data.containsKey('errors')) {
        return data['errors'] as Map<String, dynamic>;
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}

// ==================== Internal Server Exception (500) ====================
class InternalServerException extends ApiException {
  InternalServerException(super.requestOptions, super.response);

  @override
  String get message => 'حدث خطأ في الخادم. يرجى المحاولة مرة أخرى لاحقاً.';
}

// ==================== Unknown Exception ====================
class UnknownException extends ApiException {
  UnknownException(super.requestOptions, super.response);

  @override
  String get message => 'حدث خطأ غير متوقع. يرجى المحاولة مرة أخرى.';
}
