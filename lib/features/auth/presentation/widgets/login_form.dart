import 'package:Bynona/core/config/app_colors.dart';
import 'package:Bynona/core/config/app_text_styles.dart';
import 'package:Bynona/core/widgets/custom_button.dart';
import 'package:Bynona/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Padding(
        padding: EdgeInsets.only(top: 30.h),
        child: Column(
          children: [
            Text(
              'مرحبا بك مرة أخرى!',
              style: AppTextStyles.font16GrayRegular.copyWith(
                color: AppColors.textFourth,
              ),
            ),
            SizedBox(height: 28.h),
            CustomFormField(
              controller: _emailController,
              hint: 'البريد الإلكتروني',
              keyboardType: TextInputType.emailAddress,
            ),
            CustomFormField(
              controller: _passwordController,
              hint: 'كلمه المرور',
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey.shade400,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
              obscureText: _obscurePassword,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    'هل نسيت كلمة المرور؟',
                    style: TextStyle(color: Colors.grey[500], fontSize: 13),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: 'تخطى',
                    onPressed: () {},
                    isOutlined: true,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: CustomButton(text: 'تسجيل الدخول', onPressed: () {}),
                ),
              ],
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}
