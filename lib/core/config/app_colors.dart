import 'package:flutter/material.dart';

class AppColors {
  // Private constructor to prevent instantiation
  AppColors._();

  // ==================== Primary Colors ====================
  static const Color primary = Color(0xFF247CFF);
  static const Color primary80 = Color(0xff5096FF); // 80% opacity/tint
  static const Color primary60 = Color(0xff7CB0FF); // 60% opacity/tint
  static const Color primary40 = Color(0xffD3E5FF); // 40% opacity/tint
  static const Color primary20 = Color(0xFFEAF2FF); // 20% opacity/tint

  static const Color primaryLight = Color(0xFF7FB8FF);
  static const Color primaryDark = Color(0xFF1A5EC2);

  // ==================== Semantic Colors ====================
  // Success (Green)
  static const Color success = Color(0xFF22C55E);
  static const Color successLight = Color(0xFFE9FAEF);
  static const Color successDark = Color(0xFF16A34A);

  // Error (Red)
  static const Color error = Color(0xffFF4C5E);
  static const Color errorLight = Color(0xFFFFE5E8);
  static const Color errorDark = Color(0xFFDC2626);

  // Warning (Yellow)
  static const Color warning = Color(0xffFFD600);
  static const Color warning90 = Color(0xFFFFDD2A);
  static const Color warning70 = Color(0xFFFFE455);
  static const Color warning50 = Color(0xFFFFEA80);
  static const Color warning30 = Color(0xFFFFF1AA);

  // Info (Blue)
  static const Color info = Color(0xFF247CFF);
  static const Color infoLight = Color(0xFFEAF2FF);

  // ==================== Background Colors ====================
  static const Color background = Color(0xFFFAFAFB);
  static const Color backgroundSecondary = Color(0xFFFDFDFF);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF8F9FD);

  // ==================== Text Colors ====================
  static const Color textPrimary = Color(0xFF1F2937);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textTertiary = Color(0xFF9CA3AF);
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  static const Color textDisabled = Color(0xFFD1D5DB);

  // ==================== Border & Divider Colors ====================
  static const Color border = Color(0xFFE5E7EB);
  static const Color borderLight = Color(0xFFF3F4F6);
  static const Color divider = Color(0xFFE5E7EB);
}
