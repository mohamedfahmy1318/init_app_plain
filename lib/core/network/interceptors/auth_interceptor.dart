/// ========================================================
/// Auth Interceptor - معترض المصادقة
/// ========================================================
/// يضيف التوكن تلقائياً لكل طلب
/// يتعامل مع تحديث التوكن عند انتهاء صلاحيته
/// ========================================================
library;

import 'package:dio/dio.dart';
import '../../services/storage/secure_storage_service.dart';
import '../../config/app_config.dart';

class AuthInterceptor extends Interceptor {
  final SecureStorageService _secureStorage = SecureStorageService();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Get access token from secure storage
    final token = await _secureStorage.read(AppConfig.accessTokenKey);

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Handle token expiration (401)
    if (err.response?.statusCode == 401) {
      final refreshToken = await _secureStorage.read(AppConfig.refreshTokenKey);

      if (refreshToken != null && refreshToken.isNotEmpty) {
        try {
          // Try to refresh the token
          final newAccessToken = await _refreshToken(refreshToken);

          if (newAccessToken != null) {
            // Save new token
            await _secureStorage.write(
              AppConfig.accessTokenKey,
              newAccessToken,
            );

            // Retry the original request with new token
            final opts = Options(
              method: err.requestOptions.method,
              headers: {
                ...err.requestOptions.headers,
                'Authorization': 'Bearer $newAccessToken',
              },
            );

            final cloneReq = await Dio().request(
              err.requestOptions.path,
              options: opts,
              data: err.requestOptions.data,
              queryParameters: err.requestOptions.queryParameters,
            );

            return handler.resolve(cloneReq);
          }
        } catch (e) {
          // If refresh fails, logout user
          await _logout();
        }
      } else {
        // No refresh token, logout user
        await _logout();
      }
    }

    handler.next(err);
  }

  // ==================== Refresh Token ====================
  Future<String?> _refreshToken(String refreshToken) async {
    try {
      final dio = Dio();
      final response = await dio.post(
        '${AppConfig.baseUrl}${AppConfig.refreshTokenEndpoint}',
        data: {'refresh_token': refreshToken},
      );

      if (response.statusCode == 200) {
        final data = response.data;
        return data['access_token'];
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  // ==================== Logout ====================
  Future<void> _logout() async {
    // Clear all tokens
    await _secureStorage.delete(AppConfig.accessTokenKey);
    await _secureStorage.delete(AppConfig.refreshTokenKey);
    await _secureStorage.delete(AppConfig.userIdKey);

    // TODO: Navigate to login screen
    // You can use navigation service here
  }
}
