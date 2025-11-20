import 'package:Bynona/core/utils/extensions/widget_extensions.dart';
import 'package:Bynona/core/widgets/app_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('نسيت كلمة المرور'),
      ),
      body: Column(
        children: [
          SizedBox(height: 40.h),
          CustomFormField(
            controller: _emailController,
            hint: 'البريد الإلكتروني',
          ),
          Spacer(),
          CustomButton(
            text: 'إرسال',
            onPressed: () {
              // Handle send action
            },
          ),
          SizedBox(height: 40.h),
        ],
      ).padding(horizontal: 12.w),
    );
  }
}
