import 'package:Bynona/core/config/app_text_styles.dart';
import 'package:Bynona/core/constants/app_images.dart';
import 'package:Bynona/core/core.dart';
import 'package:Bynona/core/widgets/images/custom_assets_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectAuthPage extends StatelessWidget {
  const SelectAuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomAssetsImage(
            assetPath: AppImages.onBoardingImage3,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(0.27),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 306.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.r),
                  topRight: Radius.circular(10.r),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'مرحبًا بك   ',
                      style: AppTextStyles.font20BlackSemiBold,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'سجّل دخولك أو أنشئ حسابًا جديدًا لتبدأ التسوّق بسهولة.',
                      style: AppTextStyles.font16GrayRegular,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 32.h),
                    CustomButton(
                      text: 'تسجيل الدخول',
                      textColor: Colors.white,
                      onPressed: () {
                        // Navigate to login page
                        AppRouter.replaceNamed(
                          context,
                          'authScreen',
                          extra: {'startWithLogin': true},
                        );
                      },
                    ),
                    SizedBox(height: 16.h),
                    OutlinedButton(
                      onPressed: () {
                        // Navigate to sign up page
                        AppRouter.replaceNamed(
                          context,
                          'authScreen',
                          extra: {'startWithLogin': false},
                        );
                      },
                      child: Text('إنشاء حساب جديد'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
