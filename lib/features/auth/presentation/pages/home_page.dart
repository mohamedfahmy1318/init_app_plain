import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/services/storage/secure_storage_service.dart';
import '../../../../core/utils/extensions/context_extensions.dart';
import '../../../../core/widgets/app_widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  /// تسجيل الخروج
  Future<void> _logout(BuildContext context) async {
    try {
      // حذف الـ token من SecureStorage
      final secureStorage = getIt<SecureStorageService>();
      await secureStorage.delete('auth_token');

      // عرض رسالة نجاح
      if (context.mounted) {
        context.showSuccessSnackBar('تم تسجيل الخروج بنجاح');

        // التوجيه لصفحة تسجيل الدخول
        context.go('/login');
      }
    } catch (e) {
      if (context.mounted) {
        context.showErrorSnackBar('حدث خطأ أثناء تسجيل الخروج');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'الرئيسية'),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle_outline,
                size: 100,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 24),
              Text(
                'تم تسجيل الدخول بنجاح!',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              Text(
                'مرحباً بك في التطبيق',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 40),

              // ✨ زر البراندات
              CustomButton(
                text: 'عرض البراندات',
                onPressed: () {
                  context.goNamed('brands');
                },
                icon: const Icon(Icons.store),
                width: 200,
              ),
              const SizedBox(height: 16),
              // ✨ زر التصنيفات الفرعية
              CustomButton(
                text: 'عرض التصنيفات الفرعية',
                onPressed: () {
                  context.goNamed('subcategories');
                },
                icon: const Icon(Icons.category),
                width: 200,
              ),
              CustomButton(
                text: 'تسجيل الخروج',
                onPressed: () =>
                    _logout(context), // ✅ استخدام الـ logout method
                icon: const Icon(Icons.logout),
                isOutlined: true,
                width: 200,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
