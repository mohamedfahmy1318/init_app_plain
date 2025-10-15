/// ========================================================
/// Service Locator - Dependency Injection Container
/// ========================================================
/// مسؤول عن إدارة جميع التبعيات في التطبيق باستخدام get_it
/// ========================================================

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../network/dio_client.dart';
import '../services/storage/secure_storage_service.dart';
import '../services/storage/local_storage_service.dart';
import '../services/storage/hive_service.dart';
import '../services/connectivity_service.dart';
import '../services/notification_service.dart';
import '../services/app_lifecycle_service.dart';
import '../services/cache_manager_service.dart';
import '../services/logger_service.dart';

// Auth Feature

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // ==================== Storage Services ====================
  // Initialize Hive
  await HiveService.instance.init();

  // Register TypeAdapters

  getIt.registerSingleton<HiveService>(HiveService.instance);

  getIt.registerLazySingleton<SecureStorageService>(
    () => SecureStorageService(),
  );

  final localStorageService = LocalStorageService();
  await localStorageService.init();
  getIt.registerSingleton<LocalStorageService>(localStorageService);

  // ==================== Network ====================
  getIt.registerLazySingleton<DioClient>(() => DioClient());

  // ==================== Connectivity Service ====================
  final connectivityService = ConnectivityService();
  await connectivityService.initialize();
  getIt.registerSingleton<ConnectivityService>(connectivityService);

  // ==================== Notification Service ====================
  final notificationService = NotificationService();
  await notificationService.initialize();
  getIt.registerSingleton<NotificationService>(notificationService);

  // ==================== App Lifecycle Service ====================
  final appLifecycleService = AppLifecycleService();
  appLifecycleService.init();
  getIt.registerSingleton<AppLifecycleService>(appLifecycleService);

  // ==================== Cache Manager Service ====================
  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<CacheManagerService>(CacheManagerService(prefs));

  // ==================== Logger Service ====================
  final loggerService = LoggerService();
  loggerService.init();
  getIt.registerSingleton<LoggerService>(loggerService);

  // ==================== Auth Feature ====================
}
