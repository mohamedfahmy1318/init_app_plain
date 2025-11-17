import 'package:Bynona/core/config/app_colors.dart';
import 'package:Bynona/core/config/app_text_styles.dart';
import 'package:Bynona/core/core.dart';
import 'package:Bynona/core/router/routes_name.dart';
import 'package:Bynona/core/widgets/images/custom_assets_image.dart';
import 'package:Bynona/features/splash&onBoarding/presentation/widgets/custom_list_on_boarding_page.dart';
import 'package:Bynona/features/splash&onBoarding/presentation/widgets/custom_page_Indicators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  int currentIndex = 0;
  final PageController pageController = PageController();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  void _nextPage() {
    if (currentIndex < onBoardingPages.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
    } else {
      AppRouter.replace(context, RoutesName.selectAuth);
    }
  }

  // ============================
  // Build PageView for images
  // ============================
  Widget _buildPageView() {
    return PageView.builder(
      controller: pageController,
      onPageChanged: _onPageChanged,
      itemCount: onBoardingPages.length,
      itemBuilder: (context, index) {
        return CustomAssetsImage(
          assetPath: onBoardingPages[index].image,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        );
      },
    );
  }

  // ============================
  // Build Bottom Sheet
  // ============================
  Widget _buildBottomSheet() {
    return Container(
      height: 306.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          topRight: Radius.circular(16.r),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.w),
        child: Column(
          children: [
            SizedBox(height: 20.h),
            _buildPageIndicators(),
            SizedBox(height: 24.h),
            _buildTitle(),
            SizedBox(height: 12.h),
            _buildDescription(),
            const Spacer(),
            _buildButton(),
            SizedBox(height: 45.h),
          ],
        ),
      ),
    );
  }

  // ============================
  // Build Page Indicators
  // ============================
  Widget _buildPageIndicators() {
    return CustomPageIndicators(
      onBoardingPages: onBoardingPages,
      currentIndex: currentIndex,
    );
  }

  // ============================
  // Build Title
  // ============================
  Widget _buildTitle() {
    return Text(
      onBoardingPages[currentIndex].title,
      textAlign: TextAlign.center,
      style: AppTextStyles.font20BlackSemiBold,
    );
  }

  // ============================
  // Build Description
  // ============================
  Widget _buildDescription() {
    return Text(
      onBoardingPages[currentIndex].description,
      textAlign: TextAlign.center,
      style: AppTextStyles.font16GrayRegular.copyWith(
        height: 1.5,
        fontSize: 17.sp,
      ),
    );
  }

  // ============================
  // Build Button
  // ============================
  Widget _buildButton() {
    return CustomButton(
      text: currentIndex == onBoardingPages.length - 1 ? 'ابدأ الآن' : 'التالي',
      onPressed: _nextPage,
      width: double.infinity,
      height: 50.h,
      backgroundColor: AppColors.primary,
      textColor: Colors.white,
    );
  }

  // ============================
  // Build Scaffold
  // ============================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildPageView(),
          Align(alignment: Alignment.bottomCenter, child: _buildBottomSheet()),
        ],
      ),
    );
  }
}
