import 'package:bainona/core/router/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../pages/map_demo/map_demo_page.dart';
import '../pages/core_demo/presentation/pages/charts_demo_page.dart';

class AppRouter {
  AppRouter._();

  // ==================== Router Configuration ====================
  static final GoRouter router = GoRouter(
    initialLocation: RoutesName.coreDemo,
    debugLogDiagnostics: true,
    errorBuilder: (context, state) => _ErrorScreen(error: state.error),
    routes: [
      // ==================== Map Demo Page ====================
      GoRoute(
        path: RoutesName.mapDemo,
        name: 'mapDemo',
        builder: (context, state) => const MapDemoPage(),
      ),

      // ==================== Charts Demo Page ====================
      GoRoute(
        path: RoutesName.chartsDemo,
        name: 'chartsDemo',
        builder: (context, state) => const ChartsDemoPage(),
      ),

      // ==================== Splash Screen ====================

      /*GoRoute(
        path:  RoutesName.splash,
        name: 'splash',
        builder: (context, state) => const SplashPage(),
      ),*/

      // ==================== Onboarding Screen ====================
      GoRoute(
        path: RoutesName.onboarding,
        name: 'onboarding',
        builder: (context, state) =>
            const Scaffold(body: Center(child: Text('Onboarding Screen'))),
      ),

      // ==================== Auth Routes ====================
      /*GoRoute(
        path:  RoutesName.login,
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),*/
      GoRoute(
        path: RoutesName.register,
        name: 'register',
        builder: (context, state) =>
            const Scaffold(body: Center(child: Text('Register Screen'))),
      ),

      GoRoute(
        path: RoutesName.forgotPassword,
        name: 'forgotPassword',
        builder: (context, state) =>
            const Scaffold(body: Center(child: Text('Forgot Password Screen'))),
      ),

      GoRoute(
        path: RoutesName.otp,
        name: 'otp',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return Scaffold(
            body: Center(child: Text('OTP Screen - ${extra?['phone'] ?? ""}')),
          );
        },
      ),

      // ==================== Main Routes ====================
      /*GoRoute(
        path:  RoutesName.home,
        name: 'home',
        builder: (context, state) => const HomePage(),
      ),*/
      GoRoute(
        path: RoutesName.settings,
        name: 'settings',
        builder: (context, state) =>
            const Scaffold(body: Center(child: Text('Settings Screen'))),
      ),

      // ==================== Not Found ====================
      GoRoute(
        path: RoutesName.notFound,
        name: 'notFound',
        builder: (context, state) =>
            const Scaffold(body: Center(child: Text('Page Not Found'))),
      ),
    ],
  );

  // ==================== Navigation Methods ====================
  static void go(BuildContext context, String path) {
    context.go(path);
  }

  static void push(BuildContext context, String path) {
    context.push(path);
  }

  static void pop(BuildContext context) {
    context.pop();
  }

  static void replace(BuildContext context, String path) {
    context.replace(path);
  }

  static void goNamed(
    BuildContext context,
    String name, {
    Map<String, String> pathParameters = const {},
    Map<String, dynamic> queryParameters = const {},
    Object? extra,
  }) {
    context.goNamed(
      name,
      pathParameters: pathParameters,
      queryParameters: queryParameters,
      extra: extra,
    );
  }

  static void pushNamed(
    BuildContext context,
    String name, {
    Map<String, String> pathParameters = const {},
    Map<String, dynamic> queryParameters = const {},
    Object? extra,
  }) {
    context.pushNamed(
      name,
      pathParameters: pathParameters,
      queryParameters: queryParameters,
      extra: extra,
    );
  }
}

// ==================== Error Screen ====================
class _ErrorScreen extends StatelessWidget {
  final Exception? error;

  const _ErrorScreen({this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('خطأ')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 80, color: Colors.red),
            const SizedBox(height: 16),
            const Text(
              'حدث خطأ',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              error?.toString() ?? 'خطأ غير معروف',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => AppRouter.go(context, RoutesName.home),
              child: const Text('العودة للرئيسية'),
            ),
          ],
        ),
      ),
    );
  }
}
