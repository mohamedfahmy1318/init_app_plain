import 'package:Bynona/core/config/app_colors.dart';
import 'package:Bynona/features/auth/presentation/widgets/logo.dart';
import 'package:Bynona/features/auth/presentation/widgets/triangel_printer.dart'
    hide Logo;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class YellowHeader extends StatelessWidget {
  final bool isLogin;
  final Function(bool) onTabChanged;

  const YellowHeader({
    super.key,
    required this.isLogin,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(color: AppColors.primary),
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: EdgeInsets.only(top: 40.h, bottom: 20.h),
              child: Column(
                children: [
                  const Logo(),
                  SizedBox(height: 50.h),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => onTabChanged(false),
                          child: Text(
                            'قم بالتسجيل',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: !isLogin ? Colors.black : Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => onTabChanged(true),
                          child: Text(
                            'تسجيل الدخول',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: isLogin ? Colors.black : Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            child: Row(
              children: [
                // Triangle for "قم بالتسجيل" (Register)
                Expanded(
                  child: Center(
                    child: AnimatedOpacity(
                      opacity: !isLogin ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 200),
                      child: CustomPaint(
                        size: const Size(24, 14),
                        painter: TrianglePainter(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                // Triangle for "تسجيل الدخول" (Login)
                Expanded(
                  child: Center(
                    child: AnimatedOpacity(
                      opacity: isLogin ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 200),
                      child: CustomPaint(
                        size: const Size(24, 14),
                        painter: TrianglePainter(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
