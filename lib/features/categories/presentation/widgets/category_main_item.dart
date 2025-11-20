import 'package:Bynona/core/config/app_colors.dart';
import 'package:Bynona/core/config/app_text_styles.dart';
import 'package:Bynona/core/constants/app_images.dart';
import 'package:Bynona/core/widgets/images/custom_assets_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryMainItem extends StatelessWidget {
  const CategoryMainItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 63.h,
      margin: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 13,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(width: 16.w),
          CustomCircularAssetsImage(
            assetPath: AppImages.category1,
            radius: 25.r,
          ),
          SizedBox(width: 12.w),
          Text(
            'الموبيلات',
            style: AppTextStyles.font16DarkBlueSemiBold.copyWith(
              color: Colors.black,
            ),
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios, size: 20.r, color: AppColors.primary),
          SizedBox(width: 16.w),
        ],
      ),
    );
  }
}
