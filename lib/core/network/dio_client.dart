/// ========================================================
/// Dio Client - عميل الشبكة الرئيسي
/// ========================================================
/// مسؤول عن جميع طلبات الشبكة باستخدام Dio
/// ========================================================

import 'package:dio/dio.dart';
import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import '../config/app_config.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/error_interceptor.dart';
import 'interceptors/logging_interceptor.dart';

class DioClient {
  static DioClient? _instance;
  late Dio _dio;

  DioClient._() {
    _dio = Dio(_baseOptions);
    _setupInterceptors();
  }

  factory DioClient() {
    _instance ??= DioClient._();
    return _instance!;
  }

  Dio get dio => _dio;

  // ==================== Base Options ====================
  static BaseOptions get _baseOptions => BaseOptions(
    baseUrl: AppConfig.baseUrl,
    connectTimeout: AppConfig.connectionTimeout,
    receiveTimeout: AppConfig.receiveTimeout,
    sendTimeout: AppConfig.sendTimeout,
    headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
    responseType: ResponseType.json,
    validateStatus: (status) => status != null && status < 500,
  );

  // ==================== Setup Interceptors ====================
  void _setupInterceptors() {
    _dio.interceptors.clear();

    // Auth Interceptor - للتعامل مع التوكن
    _dio.interceptors.add(AuthInterceptor());

    // Error Interceptor - للتعامل مع الأخطاء
    _dio.interceptors.add(ErrorInterceptor());

    // Logging Interceptor - للطباعة في وضع التطوير
    if (AppConfig.enableNetworkLogging) {
      _dio.interceptors.add(LoggingInterceptor());

      // Beautiful logging with awesome_dio_interceptor
      _dio.interceptors.add(
        AwesomeDioInterceptor(
          logRequestTimeout: false,
          logRequestHeaders: true,
          logResponseHeaders: false,
        ),
      );
    }
  }

  // ==================== GET Request ====================
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException {
      rethrow;
    }
  }

  // ==================== POST Request ====================
  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException {
      rethrow;
    }
  }

  // ==================== PUT Request ====================
  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException {
      rethrow;
    }
  }

  // ==================== DELETE Request ====================
  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } on DioException {
      rethrow;
    }
  }

  // ==================== PATCH Request ====================
  Future<Response> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException {
      rethrow;
    }
  }

  // ==================== Download File ====================
  Future<Response> download(
    String urlPath,
    String savePath, {
    ProgressCallback? onReceiveProgress,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    bool deleteOnError = true,
    String lengthHeader = Headers.contentLengthHeader,
    Options? options,
  }) async {
    try {
      final response = await _dio.download(
        urlPath,
        savePath,
        onReceiveProgress: onReceiveProgress,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        deleteOnError: deleteOnError,
        lengthHeader: lengthHeader,
        options: options,
      );
      return response;
    } on DioException {
      rethrow;
    }
  }

  // ==================== Upload File ====================
  Future<Response> uploadFile(
    String path,
    String filePath, {
    String? fileName,
    Map<String, dynamic>? data,
    ProgressCallback? onSendProgress,
    CancelToken? cancelToken,
  }) async {
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(filePath, filename: fileName),
        if (data != null) ...data,
      });

      final response = await _dio.post(
        path,
        data: formData,
        onSendProgress: onSendProgress,
        cancelToken: cancelToken,
      );
      return response;
    } on DioException {
      rethrow;
    }
  }

  // ==================== Update Base URL ====================
  void updateBaseUrl(String baseUrl) {
    _dio.options.baseUrl = baseUrl;
  }

  // ==================== Update Headers ====================
  void updateHeaders(Map<String, dynamic> headers) {
    _dio.options.headers.addAll(headers);
  }

  // ==================== Clear Headers ====================
  void clearHeaders() {
    _dio.options.headers.clear();
  }

  // ==================== Add Interceptor ====================
  void addInterceptor(Interceptor interceptor) {
    _dio.interceptors.add(interceptor);
  }

  // ==================== Remove Interceptor ====================
  void removeInterceptor(Interceptor interceptor) {
    _dio.interceptors.remove(interceptor);
  }
}
