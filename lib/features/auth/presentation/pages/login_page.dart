import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/base/base_bloc.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/utils/extensions/context_extensions.dart';
import '../../../../core/widgets/app_widgets.dart';
import '../cubit/login_cubit.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LoginCubit>(),
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                context.colorScheme.primary.withOpacity(0.8),
                context.colorScheme.secondary.withOpacity(0.8),
              ],
            ),
          ),
          child: SafeArea(
            child: BlocConsumer<LoginCubit, BaseState>(
              listener: (context, state) {
                if (state is LoginSuccessState) {
                  final user = state.data;
                  context.showSuccessSnackBar('مرحباً ${user.name}!');
                  context.goNamed(
                    'brands',
                  ); // ✅ استخدام اسم الـ route من app_router.dart
                }
                if (state is ErrorState) {
                  context.showErrorSnackBar(state.message);
                }
              },
              builder: (context, state) {
                final cubit = context.read<LoginCubit>();
                final isLoading = state is LoadingState;

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 50),

                      // Logo
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 15,
                              spreadRadius: 3,
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.shopping_bag,
                          size: 60,
                          color: context.colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Welcome Text
                      Text(
                        'مرحباً بك',
                        style: context.textTheme.headlineLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'سجل الدخول للمتابعة',
                        style: context.textTheme.bodyLarge?.copyWith(
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 50),

                      // Login Form
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            // Email Field
                            CustomTextField(
                              controller: cubit.emailController,
                              keyboardType: TextInputType.emailAddress,
                              label: 'البريد الإلكتروني',
                              hint: 'أدخل بريدك الإلكتروني',
                              prefixIcon: const Icon(Icons.email_outlined),
                              validator: (_) => cubit.emailError,
                              onChanged: cubit.validateEmail,
                              enabled: !isLoading,
                            ),
                            const SizedBox(height: 20),

                            // Password Field
                            BlocBuilder<LoginCubit, BaseState>(
                              buildWhen: (previous, current) =>
                                  current is PasswordVisibilityChangedState ||
                                  current is ValidationState,
                              builder: (context, state) {
                                return CustomTextField(
                                  controller: cubit.passwordController,
                                  obscureText: cubit.obscurePassword,
                                  label: 'كلمة المرور',
                                  hint: 'أدخل كلمة المرور',
                                  prefixIcon: const Icon(Icons.lock_outline),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      cubit.obscurePassword
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                    ),
                                    onPressed: cubit.togglePasswordVisibility,
                                  ),
                                  validator: (_) => cubit.passwordError,
                                  onChanged: cubit.validatePassword,
                                  enabled: !isLoading,
                                );
                              },
                            ),
                            const SizedBox(height: 12),

                            // Forgot Password
                            Align(
                              alignment: Alignment.centerLeft,
                              child: TextButton(
                                onPressed: isLoading
                                    ? null
                                    : () {
                                        context.showInfoSnackBar(
                                          'قريباً: استعادة كلمة المرور',
                                        );
                                      },
                                child: const Text('نسيت كلمة المرور؟'),
                              ),
                            ),
                            const SizedBox(height: 24),

                            // Login Button
                            CustomButton(
                              text: 'تسجيل الدخول',
                              onPressed: cubit.login,
                              isLoading: isLoading,
                              width: double.infinity,
                              height: 56,
                              icon: const Icon(Icons.login),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Sign Up Link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'ليس لديك حساب؟ ',
                            style: TextStyle(color: Colors.white70),
                          ),
                          TextButton(
                            onPressed: isLoading
                                ? null
                                : () {
                                    context.showInfoSnackBar('قريباً: التسجيل');
                                  },
                            child: const Text(
                              'إنشاء حساب',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
