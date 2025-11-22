import 'package:Bynona/core/config/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomFilteringWidget extends StatelessWidget {
  const CustomFilteringWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.filter_list, size: 20.sp),
        SizedBox(width: 5.w),
        Text(' تصفيه', style: AppTextStyles.font16DarkBlueSemiBold),
      ],
    );
  }
}
