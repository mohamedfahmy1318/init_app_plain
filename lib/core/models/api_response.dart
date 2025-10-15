/// ========================================================
/// API Response Model - نموذج استجابة الـ API الموحد
/// ========================================================
/// يستخدم لتوحيد شكل الاستجابات من الـ API
/// ========================================================
library;

class ApiResponse<T> {
  final bool success;
  final String? message;
  final T? data;
  final Map<String, dynamic>? errors;
  final Map<String, dynamic>? meta;

  ApiResponse({
    required this.success,
    this.message,
    this.data,
    this.errors,
    this.meta,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic)? fromJsonT,
  ) {
    return ApiResponse<T>(
      success: json['success'] ?? true,
      message: json['message'],
      data: json['data'] != null && fromJsonT != null
          ? fromJsonT(json['data'])
          : json['data'],
      errors: json['errors'],
      meta: json['meta'],
    );
  }

  Map<String, dynamic> toJson(dynamic Function(T)? toJsonT) {
    return {
      'success': success,
      if (message != null) 'message': message,
      if (data != null) 'data': toJsonT != null ? toJsonT(data as T) : data,
      if (errors != null) 'errors': errors,
      if (meta != null) 'meta': meta,
    };
  }
}
