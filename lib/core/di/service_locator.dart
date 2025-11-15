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

// Home Feature - Hive Adapters

// Home Feature - DataSources & Repository
final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // ==================== Storage Services ====================
  // Initialize Hive
  await HiveService.instance.init();

  // Register TypeAdapters for Home Feature
  //_registerHomeAdapters();
  //_registerProfileAdapters();
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
  /*
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
  */
  /*
  // UseCases
  getIt.registerLazySingleton(() => LoginUseCase(getIt<AuthRepository>()));
  getIt.registerLazySingleton(() => RegisterUseCase(getIt<AuthRepository>()));
  getIt.registerLazySingleton(() => LogoutUseCase(getIt<AuthRepository>()));
  getIt.registerLazySingleton(
    () => GetCurrentUserUseCase(getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton(() => IsLoggedInUseCase(getIt<AuthRepository>()));

  // Cubits
  getIt.registerFactory(() => LoginCubit(loginUseCase: getIt<LoginUseCase>()));
  getIt.registerFactory(
    () => RegisterCubit(registerUseCase: getIt<RegisterUseCase>()),
  );

  // ==================== Home Feature ====================
  // Data Sources
  getIt.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(getIt<DioClient>()),
  );
  getIt.registerLazySingleton<HomeLocalDataSource>(
    () => HomeLocalDataSourceImpl(getIt<HiveService>()),
  );
  getIt.registerLazySingleton<SpecializationLocalDataSource>(
    () => SpecializationLocalDataSourceImpl(getIt<HiveService>()),
  );
  getIt.registerLazySingleton<GetAllDoctorsLocalDataSource>(
    () => GetAllDoctorsLocalDataSourceImpl(getIt<HiveService>()),
  );
  // Repository
  getIt.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(
      remoteDataSource: getIt<HomeRemoteDataSource>(),
      localDataSource: getIt<HomeLocalDataSource>(),
      specializationLocalDataSource: getIt<SpecializationLocalDataSource>(),
      getAllDoctorsLocalDataSource: getIt<GetAllDoctorsLocalDataSource>(),
    ),
  );

  // UseCases
  getIt.registerLazySingleton(
    () => GetHomeDataUseCase(getIt<HomeRepository>()),
  );
  getIt.registerLazySingleton(
    () => GetSpecializationUseCase(getIt<HomeRepository>()),
  );
  getIt.registerLazySingleton(
    () => GetAllDoctorsUseCase(getIt<HomeRepository>()),
  );
  getIt.registerLazySingleton(
    () => GetOneDoctorUseCase(getIt<HomeRepository>()),
  );
  getIt.registerLazySingleton(
    () => GetDoctorSpecialization(getIt<HomeRepository>()),
  );

  // Cubit
  getIt.registerFactory(
    () => HomeCubit(getHomeDataUseCase: getIt<GetHomeDataUseCase>()),
  );
  getIt.registerFactory(
    () => SpecializationCubit(
      getSpecializationUseCase: getIt<GetSpecializationUseCase>(),
    ),
  );
  getIt.registerFactory(
    () => DoctorsCubit(
      getAllDoctorsUseCase: getIt<GetAllDoctorsUseCase>(),
      getOneDoctorUseCase: getIt<GetOneDoctorUseCase>(),
    ),
  );
  getIt.registerFactory(
    () => DoctorsSpecCubit(
      getDoctorsBySpecializationUseCase: getIt<GetDoctorSpecialization>(),
    ),
  );
  // ==================== search Features ====================
  // Data Sources
  getIt.registerLazySingleton<SearchRemoteDataSource>(
    () => SearchRemoteDataSourceImpl(client: getIt<DioClient>()),
  );
  getIt.registerLazySingleton<LocalSearchDataSource>(
    () => LocalSearchDataSourceImpl(getIt<HiveService>()),
  );
  // Repository
  getIt.registerLazySingleton<SearchRepository>(
    () => SearchRepositoryImpl(
      remoteDataSource: getIt<SearchRemoteDataSource>(),
      localDataSource: getIt<LocalSearchDataSource>(),
    ),
  );
  // UseCases
  getIt.registerLazySingleton(
    () => SearchDoctorUseCase(getIt<SearchRepository>()),
  );
  getIt.registerLazySingleton(
    () => GetAllCitiesUseCase(searchRepository: getIt<SearchRepository>()),
  );
  getIt.registerLazySingleton(
    () => FilterDoctorWithCityUseCase(getIt<SearchRepository>()),
  );
  // Cubit

  getIt.registerFactory(
    () => SearchCubit(
      getSearchDoctorUseCase: getIt<SearchDoctorUseCase>(),
      getAllCitiesUseCase: getIt<GetAllCitiesUseCase>(),
      filterDoctorWithCityUseCase: getIt<FilterDoctorWithCityUseCase>(),
    ),
  );
  // ==================== Appointment Features ====================
  /// Data Sources
  getIt.registerLazySingleton<AppointmentRemoteDataSource>(
    () => AppointmentRemoteDataSourceImpl(getIt<DioClient>()),
  );

  // Repository
  getIt.registerLazySingleton<AppointmentRepository>(
    () => AppointmentRepositoryImpl(
      remoteDataSource: getIt<AppointmentRemoteDataSource>(),
    ),
  );
  // UseCases
  getIt.registerLazySingleton(
    () => CreateAppointmentUseCase(getIt<AppointmentRepository>()),
  );
  // Cubit
  getIt.registerFactory(
    () => AppointmentCubit(getIt<CreateAppointmentUseCase>()),
  );
  // ===================== Profile Features ====================
  // data sources
  getIt.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(getIt<DioClient>()),
  );
  getIt.registerLazySingleton<ProfileLocalDataSource>(
    () => ProfileLocalDataSourceImpl(getIt<HiveService>()),
  );
  // repositories
  getIt.registerLazySingleton<ProfileRepository>(
    () => ProfileRepoImpl(
      remoteDataSource: getIt<ProfileRemoteDataSource>(),
      localDataSource: getIt<ProfileLocalDataSource>(),
    ),
  );
  // use cases
  getIt.registerLazySingleton(
    () => GetUserProfileUseCase(getIt<ProfileRepository>()),
  );
  getIt.registerLazySingleton(
    () => UpdateProfileUseCase(getIt<ProfileRepository>()),
  );
  // cubits
  getIt.registerFactory(
    () => ProfileCubit(
      getUserProfileUseCase: getIt<GetUserProfileUseCase>(),
      updateProfileUseCase: getIt<UpdateProfileUseCase>(),
    ),
  );
}

/// ========================================================
/// Register Hive TypeAdapters
/// ========================================================
void _registerHomeAdapters() {
  HiveService.instance.registerAdapter(GovernorateModelAdapter());
  HiveService.instance.registerAdapter(CityModelAdapter());
  HiveService.instance.registerAdapter(SpecializationModelAdapter());
  HiveService.instance.registerAdapter(DoctorModelAdapter());
  HiveService.instance.registerAdapter(SpecializationWithDoctorsModelAdapter());
}

void _registerProfileAdapters() {
  HiveService.instance.registerAdapter(ProfileResponseModelAdapter());
  HiveService.instance.registerAdapter(ProfileModelAdapter());
}
  */
}
