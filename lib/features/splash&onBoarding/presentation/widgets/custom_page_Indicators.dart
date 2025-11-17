import 'package:Bynona/core/config/app_colors.dart';
import 'package:Bynona/features/splash&onBoarding/data/model/on_boarding_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomPageIndicators extends StatelessWidget {
  const CustomPageIndicators({
    super.key,
    required List<OnBoardingDataModel> onBoardingPages,
    required int currentIndex,
  }) : _onBoardingPages = onBoardingPages,
       _currentIndex = currentIndex;

  final List<OnBoardingDataModel> _onBoardingPages;
  final int _currentIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _onBoardingPages.length,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          width: _currentIndex == index ? 48.w : 48.w,
          height: 8.h,
          decoration: BoxDecoration(
            color: _currentIndex == index
                ? AppColors.primary
                : AppColors.indicatorColor,
            borderRadius: BorderRadius.circular(20.r),
          ),
        ),
      ),
    );
  }
}
