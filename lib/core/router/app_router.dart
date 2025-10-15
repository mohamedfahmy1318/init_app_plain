/// ========================================================
/// App Router - توجيه التطبيق
/// ========================================================
/// يحتوي على جميع routes التطبيق باستخدام go_router
/// ========================================================

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  AppRouter._();

  // ==================== Route Names ====================
  static const String splash = '/';
  static const String coreDemo = '/core-demo';
  static const String mapDemo = '/map-demo';
  static const String chartsDemo = '/charts-demo';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String otp = '/otp';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String notFound = '/not-found';
  static const String brands = '/brands';

  // ==================== Router Configuration ====================
  static final GoRouter router = GoRouter(
    initialLocation: coreDemo,
    debugLogDiagnostics: true,
    errorBuilder: (context, state) => _ErrorScreen(error: state.error),
    routes: [
      // ==================== Onboarding Screen ====================
      GoRoute(
        path: onboarding,
        name: 'onboarding',
        builder: (context, state) =>
            const Scaffold(body: Center(child: Text('Onboarding Screen'))),
      ),

      // ==================== Auth Routes ====================
      GoRoute(
        path: register,
        name: 'register',
        builder: (context, state) =>
            const Scaffold(body: Center(child: Text('Register Screen'))),
      ),

      GoRoute(
        path: forgotPassword,
        name: 'forgotPassword',
        builder: (context, state) =>
            const Scaffold(body: Center(child: Text('Forgot Password Screen'))),
      ),

      GoRoute(
        path: otp,
        name: 'otp',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return Scaffold(
            body: Center(child: Text('OTP Screen - ${extra?['phone'] ?? ""}')),
          );
        },
      ),

      // ==================== Main Routes ====================
      GoRoute(
        path: settings,
        name: 'settings',
        builder: (context, state) =>
            const Scaffold(body: Center(child: Text('Settings Screen'))),
      ),

      // ==================== Not Found ====================
      GoRoute(
        path: notFound,
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
              onPressed: () => AppRouter.go(context, AppRouter.home),
              child: const Text('العودة للرئيسية'),
            ),
          ],
        ),
      ),
    );
  }
}
