/// ========================================================
/// App Configuration - مركز إعدادات التطبيق الرئيسية
/// ========================================================
/// يحتوي على جميع الإعدادات الثابتة للتطبيق
///
/// Features:
/// - API endpoints configuration
/// - App versioning
/// - Build modes (dev, staging, production)
/// - Feature flags
/// - Timeout configurations
/// - API keys
/// ========================================================
library;

class AppConfig {
  // Private constructor to prevent instantiation
  AppConfig._();

  // ==================== Build Mode ====================
  static const String _mode = String.fromEnvironment(
    'MODE',
    defaultValue: 'dev',
  );

  static bool get isDevelopment => _mode == 'dev';
  static bool get isStaging => _mode == 'staging';
  static bool get isProduction => _mode == 'production';

  // ==================== App Information ====================
  static const String appName = 'Init App';
  static const String appVersion = '1.0.0';
  static const int buildNumber = 1;

  // ==================== API Configuration ====================
  static String get baseUrl {
    if (isDevelopment) return developmentBaseUrl;
    if (isStaging) return stagingBaseUrl;
    return productionBaseUrl;
  }

  static const String developmentBaseUrl =
      'https://ecommerce.routemisr.com/api/v1';
  static const String stagingBaseUrl = 'https://ecommerce.routemisr.com/api/v1';
  static const String productionBaseUrl =
      'https://ecommerce.routemisr.com/api/v1';

  // ==================== API Endpoints ====================
  static const String authEndpoint = '/auth';
  static const String loginEndpoint = '$authEndpoint/login';
  static const String registerEndpoint = '$authEndpoint/register';
  static const String logoutEndpoint = '$authEndpoint/logout';
  static const String refreshTokenEndpoint = '$authEndpoint/refresh';
  static const String forgotPasswordEndpoint = '$authEndpoint/forgot-password';
  static const String resetPasswordEndpoint = '$authEndpoint/reset-password';
  static const String verifyOtpEndpoint = '$authEndpoint/verify-otp';

  static const String userEndpoint = '/user';
  static const String profileEndpoint = '$userEndpoint/profile';
  static const String updateProfileEndpoint = '$userEndpoint/update';
  static const String uploadImageEndpoint = '$userEndpoint/upload-image';

  // ==================== Timeout Configuration ====================
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 30);

  // ==================== Cache Configuration ====================
  static const Duration cacheValidDuration = Duration(hours: 1);
  static const int maxCacheSize = 100; // MB
  static const int maxCacheObjects = 200;

  // ==================== Pagination ====================
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // ==================== API Keys (يجب تأمينها في production) ====================
  static const String googleMapsApiKey = 'YOUR_GOOGLE_MAPS_API_KEY';
  static const String firebaseApiKey = 'YOUR_FIREBASE_API_KEY';

  // ==================== Storage Keys ====================
  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userIdKey = 'user_id';
  static const String userDataKey = 'user_data';
  static const String languageKey = 'language';
  static const String themeKey = 'theme';
  static const String isFirstTimeKey = 'is_first_time';
  static const String fcmTokenKey = 'fcm_token';
  static const String biometricEnabledKey = 'biometric_enabled';

  // ==================== Feature Flags ====================
  static const bool enableBiometric = true;
  static const bool enablePushNotifications = true;
  static const bool enableAnalytics = true;
  static const bool enableCrashReporting = true;
  static const bool enableRemoteConfig = true;
  static const bool enableDeepLinking = true;
  static const bool enableOfflineMode = true;
  static bool get enableDebugLogs => !isProduction;

  // ==================== Social Media ====================
  static const String facebookUrl = 'https://facebook.com/yourpage';
  static const String twitterUrl = 'https://twitter.com/yourpage';
  static const String instagramUrl = 'https://instagram.com/yourpage';
  static const String linkedinUrl = 'https://linkedin.com/company/yourpage';

  // ==================== Support ====================
  static const String supportEmail = 'support@example.com';
  static const String supportPhone = '+1234567890';
  static const String websiteUrl = 'https://example.com';
  static const String privacyPolicyUrl = 'https://example.com/privacy';
  static const String termsAndConditionsUrl = 'https://example.com/terms';

  // ==================== App Store Links ====================
  static const String appStoreId = 'YOUR_APP_STORE_ID';
  static const String playStoreId = 'com.example.yourapp';
  static const String appStoreUrl = 'https://apps.apple.com/app/id$appStoreId';
  static const String playStoreUrl =
      'https://play.google.com/store/apps/details?id=$playStoreId';

  // ==================== Validation Rules ====================
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 32;
  static const int minUsernameLength = 3;
  static const int maxUsernameLength = 30;
  static const int otpLength = 6;
  static const Duration otpValidityDuration = Duration(minutes: 5);

  // ==================== Date & Time Formats ====================
  static const String dateFormat = 'yyyy-MM-dd';
  static const String timeFormat = 'HH:mm';
  static const String dateTimeFormat = 'yyyy-MM-dd HH:mm:ss';
  static const String displayDateFormat = 'dd MMM yyyy';
  static const String displayDateTimeFormat = 'dd MMM yyyy, HH:mm';

  // ==================== Image Configuration ====================
  static const double maxImageSizeMB = 5.0;
  static const int imageQuality = 85;
  static const int maxImageWidth = 1920;
  static const int maxImageHeight = 1920;

  // ==================== Animation Duration ====================
  static const Duration shortAnimationDuration = Duration(milliseconds: 200);
  static const Duration normalAnimationDuration = Duration(milliseconds: 300);
  static const Duration longAnimationDuration = Duration(milliseconds: 500);

  // ==================== Splash Screen ====================
  static const Duration splashScreenDuration = Duration(seconds: 3);

  // ==================== Default Values ====================
  static const String defaultLanguage = 'ar';
  static const String fallbackLanguage = 'en';
  static const List<String> supportedLanguages = ['ar', 'en'];

  // ==================== Map Configuration ====================
  static const double defaultLatitude = 24.7136; // Riyadh
  static const double defaultLongitude = 46.6753;
  static const double defaultZoom = 14.0;
  static const double minZoom = 5.0;
  static const double maxZoom = 20.0;

  // ==================== Retry Configuration ====================
  static const int maxRetryAttempts = 3;
  static const Duration retryDelay = Duration(seconds: 2);

  // ==================== Debug Settings ====================
  static bool get showDebugBanner => isDevelopment;
  static bool get enableNetworkLogging => !isProduction;
  static bool get enablePerformanceMonitoring => isProduction;
}
