import 'package:Bynona/core/constants/app_images.dart';
import 'package:Bynona/core/widgets/images/custom_assets_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BannerItem extends StatelessWidget {
  const BannerItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.w),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.r)),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // Background Image - Full Coverage
          Positioned.fill(
            child: CustomAssetsImage(
              assetPath: AppImages.bannerImage,
              filterQuality: FilterQuality.high,
              fit: BoxFit.cover,
            ),
          ),

          // Dark Overlay for text visibility
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.4),
                    Colors.black.withOpacity(0.5),
                  ],
                ),
              ),
            ),
          ),

          // Top Right Text
          Positioned(
            top: 9.h,
            right: 16.w,
            child: Text(
              'خصومات ضخمة على الموبايلات والاكسسوارات',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    offset: Offset(0, 1),
                    blurRadius: 3.0,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ],
              ),
              textAlign: TextAlign.right,
            ),
          ),

          // Bottom Right Badge
          Positioned(
            bottom: 2.h,
            right: 10.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: const Color(0xFFFDD835),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                'خصومات تصل إلى 50%',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
