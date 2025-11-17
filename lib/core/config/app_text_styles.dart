import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  // ==================== Font Families ====================
  static String get primaryFont => GoogleFonts.roboto().fontFamily!;
  //======================= 20pt Styles ====================

  static TextStyle font20BlackSemiBold = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    fontFamily: primaryFont,
  );

  // ==================== 18pt Styles ====================

  // ==================== 16pt Styles ====================

  static TextStyle font16GrayRegular = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    fontFamily: primaryFont,
  );

  // ==================== 14pt Styles ====================
  static TextStyle font14DarkBlueMedium = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    fontFamily: primaryFont,
  );

  static TextStyle font14BlueMedium = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.primary,
    fontFamily: primaryFont,
  );

  static TextStyle font14GrayRegular = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    fontFamily: primaryFont,
  );

  static TextStyle font14WhiteMedium = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: Colors.white,
    fontFamily: primaryFont,
  );

  // ==================== 12pt Styles ====================
  static TextStyle font12GrayRegular = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    fontFamily: primaryFont,
  );

  static TextStyle font12BlueMedium = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.primary,
    fontFamily: primaryFont,
  );

  static TextStyle font12DarkBlueMedium = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    fontFamily: primaryFont,
  );

  static TextStyle font12WhiteMedium = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    color: Colors.white,
    fontFamily: primaryFont,
  );

  // ==================== 10pt Styles ====================
  static TextStyle font10GrayRegular = TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.textThird,
    fontFamily: primaryFont,
  );
}
