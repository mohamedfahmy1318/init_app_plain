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
import '../../features/auth/data/datasources/auth_remote_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/get_auths_usecase.dart';
import '../../features/auth/presentation/cubit/login_cubit.dart';

// Brands Feature
import '../../features/brands/data/datasources/brands_remote_datasource.dart';
import '../../features/brands/data/datasources/brands_local_datasource.dart';
import '../../features/brands/data/models/brand_model.dart';
import '../../features/brands/data/repositories/brands_repository_impl.dart';
import '../../features/brands/domain/repositories/brands_repository.dart';
import '../../features/brands/domain/usecases/get_brands_usecase.dart';
import '../../features/brands/presentation/cubit/brands_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // ==================== Storage Services ====================
  // Initialize Hive
  await HiveService.instance.init();

  // Register TypeAdapters
  HiveService.instance.registerAdapter(BrandModelAdapter());

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
  // Data Sources
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(getIt<DioClient>()),
  );

  // Repositories
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      getIt<AuthRemoteDataSource>(),
      getIt<SecureStorageService>(),
    ),
  );

  // UseCases
  getIt.registerLazySingleton(() => LoginUseCase(getIt<AuthRepository>()));
  getIt.registerLazySingleton(() => LogoutUseCase(getIt<AuthRepository>()));
  getIt.registerLazySingleton(
    () => GetCurrentUserUseCase(getIt<AuthRepository>()),
  );

  // Cubits
  getIt.registerFactory(() => LoginCubit(loginUseCase: getIt<LoginUseCase>()));

  // ==================== Brands Feature ====================
  // Data Sources
  getIt.registerLazySingleton<BrandsRemoteDataSource>(
    () => BrandsRemoteDataSourceImpl(dioClient: getIt<DioClient>()),
  );

  getIt.registerLazySingleton<BrandsLocalDataSource>(
    () => BrandsLocalDataSourceImpl(hiveService: getIt<HiveService>()),
  );

  // Repositories
  getIt.registerLazySingleton<BrandsRepository>(
    () => BrandsRepositoryImpl(
      remoteDataSource: getIt<BrandsRemoteDataSource>(),
      localDataSource: getIt<BrandsLocalDataSource>(),
    ),
  );

  // UseCases
  getIt.registerLazySingleton(
    () => GetBrandsUseCase(getIt<BrandsRepository>()),
  );

  // Cubits
  getIt.registerFactory(
    () => BrandsCubit(getBrandsUseCase: getIt<GetBrandsUseCase>()),
  );
  // ==================== Subcategories Feature ====================
}
