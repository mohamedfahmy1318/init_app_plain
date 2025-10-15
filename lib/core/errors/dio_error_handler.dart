/// ========================================================
/// Dio Error Handler - معالج أخطاء Dio
/// ========================================================
/// Utility class لمعالجة أخطاء Dio بشكل موحد
/// يستخدم في كل الـ Repositories
/// ========================================================

import 'package:dio/dio.dart';
import 'failures.dart';

class DioErrorHandler {
  /// 🔍 التحقق من أخطاء الشبكة
  static bool isNetworkError(DioException error) {
    return error.type == DioExceptionType.connectionError ||
        error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.sendTimeout;
  }

  /// 🔧 تحويل DioException إلى Failure
  static Failure handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetworkFailure('انتهت مهلة الاتصال');

      case DioExceptionType.badResponse:
        return _handleBadResponse(error);

      case DioExceptionType.cancel:
        return const NetworkFailure('تم إلغاء الطلب');

      case DioExceptionType.connectionError:
        return const NetworkFailure('لا يوجد اتصال بالإنترنت');

      case DioExceptionType.badCertificate:
        return const ServerFailure('خطأ في شهادة الأمان');

      case DioExceptionType.unknown:
        return const NetworkFailure('حدث خطأ غير متوقع');
    }
  }

  /// 🔧 معالجة أخطاء الـ Response
  static Failure _handleBadResponse(DioException error) {
    final statusCode = error.response?.statusCode;
    final message = error.response?.data?['message'];

    switch (statusCode) {
      case 400:
        return ServerFailure(message ?? 'طلب غير صحيح');
      case 401:
        return const ServerFailure('غير مصرح لك بالوصول');
      case 403:
        return const ServerFailure('ليس لديك صلاحية للوصول');
      case 404:
        return const ServerFailure('المورد غير موجود');
      case 500:
        return const ServerFailure('خطأ في الخادم');
      case 503:
        return const ServerFailure('الخدمة غير متاحة حالياً');
      default:
        return ServerFailure(message ?? 'خطأ من الخادم');
    }
  }
}

/// 📝 شرح الـ DioErrorHandler:
/// ---------------------------
/// 1. Static class: مش محتاجين instance منها
/// 2. isNetworkError(): بيتحقق لو الخطأ متعلق بالشبكة
/// 3. handleDioError(): بيحول DioException لـ Failure
/// 4. _handleBadResponse(): بيعالج أخطاء الـ HTTP Status Codes
/// 
/// 🎯 الاستخدام:
/// ```dart
/// try {
///   final data = await remoteDataSource.getData();
///   return Right(data);
/// } on DioException catch (e) {
///   return Left(DioErrorHandler.handleDioError(e));
/// }
/// ```
/// 
/// 💡 المميزات:
/// - موحد في كل الـ Repositories
/// - سهل التعديل والصيانة
/// - يدعم جميع أنواع أخطاء Dio
/// - يدعم جميع HTTP Status Codes
