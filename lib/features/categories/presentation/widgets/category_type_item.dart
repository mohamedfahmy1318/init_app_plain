import 'package:Bynona/core/config/app_text_styles.dart';
import 'package:Bynona/core/constants/app_images.dart';
import 'package:Bynona/core/widgets/images/custom_assets_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryTypeItem extends StatelessWidget {
  const CategoryTypeItem({super.key, required this.ontap});

  final VoidCallback ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Card(
        color: Colors.white,
        elevation: 3,
        child: Padding(
          padding: EdgeInsets.all(8.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: CustomAssetsImage(
                  assetPath: AppImages.mobiles,
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'موبايلات ذكيه',
                style: AppTextStyles.font16GrayRegular,
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
