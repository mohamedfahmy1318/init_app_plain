import 'package:Bynona/core/config/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomArrangeWidget extends StatelessWidget {
  const CustomArrangeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.reorder, size: 20.sp),
        SizedBox(width: 5.w),
        Text(' ترتيب ب', style: AppTextStyles.font16DarkBlueSemiBold),
      ],
    );
  }
}
