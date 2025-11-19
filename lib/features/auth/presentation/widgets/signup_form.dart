import 'package:Bynona/core/config/app_colors.dart';
import 'package:Bynona/core/config/app_text_styles.dart';
import 'package:Bynona/core/widgets/custom_button.dart';
import 'package:Bynona/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Padding(
        padding: EdgeInsets.only(top: 30.h),
        child: Column(
          children: [
            Text(
              'ابدأ التسوق الآن!',
              style: AppTextStyles.font16GrayRegular.copyWith(
                color: AppColors.textFourth,
              ),
            ),
            SizedBox(height: 15.h),
            CustomFormField(
              controller: _firstNameController,
              hint: 'الاسم الأول',
            ),
            CustomFormField(
              controller: _lastNameController,
              hint: 'الاسم الأخير',
            ),
            CustomFormField(
              controller: _emailController,
              hint: 'البريد الإلكتروني',
              keyboardType: TextInputType.emailAddress,
            ),
            CustomFormField(
              controller: _phoneController,
              hint: 'رقم الهاتف',
              keyboardType: TextInputType.phone,
              prefixIcon: Container(
                margin: EdgeInsets.only(left: 12.w),
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 24,
                      height: 16,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: const Text('🇪🇬', style: TextStyle(fontSize: 14)),
                    ),
                    SizedBox(width: 4.w),
                    const Text(
                      '+2',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            CustomFormField(
              controller: _passwordController,
              hint: 'كلمه المرور',
              obscureText: _obscurePassword,
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
            ),
            CustomFormField(
              controller: _confirmPasswordController,
              hint: 'تأكيد كلمة المرور',
              obscureText: _obscureConfirmPassword,
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureConfirmPassword
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _obscureConfirmPassword = !_obscureConfirmPassword;
                  });
                },
              ),
            ),
            CustomButton(text: 'قم بالتسجيل', onPressed: () {}),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}
