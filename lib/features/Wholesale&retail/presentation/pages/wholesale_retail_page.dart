import 'package:Bynona/core/config/app_colors.dart';
import 'package:Bynona/core/config/app_text_styles.dart';
import 'package:Bynona/core/constants/app_images.dart';
import 'package:Bynona/core/core.dart';
import 'package:Bynona/core/router/routes_name.dart';
import 'package:Bynona/core/utils/utils.dart';
import 'package:Bynona/core/widgets/images/custom_assets_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WholesaleAndRetailPage extends StatelessWidget {
  const WholesaleAndRetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(height: 35.h),
            CustomAssetsImage(
              assetPath: AppImages.logoApp,
              width: 168.w,
              height: 168.h,
              filterQuality: FilterQuality.high,
            ),
            SizedBox(height: 10.h),
            Text(
              'اختار نوع التسوق الخاص بك',
              style: AppTextStyles.font20BlackSemiBold,
            ),
            SizedBox(height: 8.h),
            Text(
              'هل ترغب بالشراء بالجملة أم\n بالتجزئة؟',
              textAlign: TextAlign.center,
              style: AppTextStyles.font16DarkBlueSemiBold,
            ),
            SizedBox(height: 20.h),
            CustomButton(
              text: 'جملة',
              onPressed: () {},
              isOutlined: true,

              backgroundColor: AppColors.background,
              textColor: AppColors.textThird,
            ),
            SizedBox(height: 20.h),
            CustomButton(
              text: 'قطاعي',
              onPressed: () {},
              isOutlined: true,

              backgroundColor: AppColors.background,
              textColor: AppColors.textThird,
            ),
            Spacer(),
            CustomButton(
              text: ' استمرار',
              onPressed: () {
                AppRouter.replace(context, RoutesName.main);
              },
              backgroundColor: AppColors.primary,
            ),
            SizedBox(height: 60.h),
          ],
        ).paddingR(horizontal: 16),
      ),
    );
  }
}
