/// ========================================================
/// Main Entry Point - نقطة البداية الرئيسية
/// ========================================================
/// تطبيق Flutter احترافي متكامل مع Clean Architecture
/// ========================================================

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:init_app_flutter/core/base/bloc_observer.dart';
import 'core/config/app_config.dart';
import 'core/config/theme_config.dart';
import 'core/di/service_locator.dart';
import 'core/router/app_router.dart';
import 'core/utils/logger_helper.dart';

void main() async {
  // ==================== Flutter Initialization ====================
  WidgetsFlutterBinding.ensureInitialized();

  // ==================== Error Handling ====================
  // Catch Flutter framework errors
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    LoggerHelper.error(
      'Flutter Error',
      error: details.exception,
      stackTrace: details.stack,
    );
  };

  // ==================== System UI Setup ====================
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  // ==================== Services Initialization ====================
  // Setup dependency injection
  await setupServiceLocator();

  // Setup Hive
  LoggerHelper.info('💾 Initializing Hive...');

  // Setup localization
  await EasyLocalization.ensureInitialized();

  // Setup BLoC observer
  Bloc.observer = AppBlocObserver();

  // ==================== Run App ====================
  LoggerHelper.info('✅ App initialization completed successfully!');

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('ar'), Locale('en')],
      path: 'assets/translations',
      fallbackLocale: const Locale('ar'),
      startLocale: const Locale('ar'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // iPhone X size
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          // ==================== App Info ====================
          title: AppConfig.appName,
          debugShowCheckedModeBanner: AppConfig.showDebugBanner,

          // ==================== Localization ====================
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,

          // ==================== Theme ====================
          theme: ThemeConfig.lightTheme,
          darkTheme: ThemeConfig.darkTheme,
          themeMode: ThemeMode.light, // TODO: Make this dynamic
          // ==================== Routing ====================
          routerConfig: AppRouter.router,

          // ==================== Builder (للتحكم في الـ UI) ====================
          builder: (context, widget) {
            // Handle text scaling
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: TextScaler.linear(
                  1.0,
                ), // منع تكبير النص من الإعدادات
              ),
              child: widget!,
            );
          },
        );
      },
    );
  }
}
