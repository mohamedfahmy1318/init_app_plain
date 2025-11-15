/// ========================================================
/// Custom SVG Image Widget
/// ========================================================
/// Widget مخصص لعرض صور SVG مع خيارات متقدمة
/// يدعم الألوان، الأحجام، والـ placeholder
/// ========================================================

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSvgImage extends StatelessWidget {
  /// مسار ملف الـ SVG
  final String assetPath;

  /// عرض الصورة
  final double? width;

  /// ارتفاع الصورة
  final double? height;

  /// لون الصورة (يمكن تطبيقه على SVG)
  final Color? color;

  /// كيفية ملء المساحة
  final BoxFit fit;

  /// محاذاة الصورة
  final Alignment alignment;

  /// دالة تُنفذ عند الضغط على الصورة
  final VoidCallback? onTap;

  /// نص بديل في حال فشل التحميل
  final Widget? errorWidget;

  /// widget placeholder أثناء التحميل
  final Widget? placeholder;

  /// blend mode للون
  final BlendMode? colorBlendMode;

  /// إضافة padding حول الصورة
  final EdgeInsetsGeometry? padding;

  /// إضافة margin حول الصورة
  final EdgeInsetsGeometry? margin;

  /// border radius للحاوية
  final BorderRadius? borderRadius;

  /// background color للحاوية
  final Color? backgroundColor;

  /// هل يتم السماح بالتفاعل (clickable)
  final bool allowDrawingOutsideViewBox;

  /// semantic label لـ accessibility
  final String? semanticsLabel;

  const CustomSvgImage({
    super.key,
    required this.assetPath,
    this.width,
    this.height,
    this.color,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.onTap,
    this.errorWidget,
    this.placeholder,
    this.colorBlendMode,
    this.padding,
    this.margin,
    this.borderRadius,
    this.backgroundColor,
    this.allowDrawingOutsideViewBox = false,
    this.semanticsLabel,
  });

  @override
  Widget build(BuildContext context) {
    Widget svgWidget = SvgPicture.asset(
      assetPath,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      colorFilter: color != null
          ? ColorFilter.mode(color!, colorBlendMode ?? BlendMode.srcIn)
          : null,
      placeholderBuilder: placeholder != null
          ? (context) => placeholder!
          : (context) => _buildDefaultPlaceholder(),
      semanticsLabel: semanticsLabel,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
    );

    // التأكد من أن الـ SVG له حجم محدد
    if (width == null && height == null) {
      svgWidget = SizedBox(
        width: 24, // حجم افتراضي
        height: 24,
        child: svgWidget,
      );
    }

    // إضافة padding إذا كان موجود
    if (padding != null) {
      svgWidget = Padding(padding: padding!, child: svgWidget);
    }

    // إضافة background color و border radius
    if (backgroundColor != null || borderRadius != null) {
      svgWidget = Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: borderRadius,
        ),
        child: svgWidget,
      );
    }

    // إضافة margin إذا كان موجود
    if (margin != null) {
      svgWidget = Padding(padding: margin!, child: svgWidget);
    }

    // إضافة onTap إذا كان موجود
    if (onTap != null) {
      svgWidget = InkWell(
        onTap: onTap,
        borderRadius: borderRadius,
        child: svgWidget,
      );
    }

    return svgWidget;
  }

  /// بناء placeholder افتراضي
  Widget _buildDefaultPlaceholder() {
    return SizedBox(
      width: width,
      height: height,
      child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
    );
  }
}

/// ========================================================
/// Custom Network SVG Image Widget
/// ========================================================
/// Widget لعرض SVG من الإنترنت
/// ========================================================

class CustomNetworkSvgImage extends StatelessWidget {
  /// رابط الـ SVG على الإنترنت
  final String url;

  /// عرض الصورة
  final double? width;

  /// ارتفاع الصورة
  final double? height;

  /// لون الصورة
  final Color? color;

  /// كيفية ملء المساحة
  final BoxFit fit;

  /// محاذاة الصورة
  final Alignment alignment;

  /// دالة تُنفذ عند الضغط على الصورة
  final VoidCallback? onTap;

  /// widget placeholder أثناء التحميل
  final Widget? placeholder;

  /// widget في حال حدوث خطأ
  final Widget? errorWidget;

  /// blend mode للون
  final BlendMode? colorBlendMode;

  /// إضافة padding حول الصورة
  final EdgeInsetsGeometry? padding;

  /// إضافة margin حول الصورة
  final EdgeInsetsGeometry? margin;

  /// border radius للحاوية
  final BorderRadius? borderRadius;

  /// background color للحاوية
  final Color? backgroundColor;

  /// headers للطلب
  final Map<String, String>? headers;

  /// semantic label لـ accessibility
  final String? semanticsLabel;

  const CustomNetworkSvgImage({
    Key? key,
    required this.url,
    this.width,
    this.height,
    this.color,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.onTap,
    this.placeholder,
    this.errorWidget,
    this.colorBlendMode,
    this.padding,
    this.margin,
    this.borderRadius,
    this.backgroundColor,
    this.headers,
    this.semanticsLabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget svgWidget = SvgPicture.network(
      url,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      colorFilter: color != null
          ? ColorFilter.mode(color!, colorBlendMode ?? BlendMode.srcIn)
          : null,
      placeholderBuilder: placeholder != null
          ? (context) => placeholder!
          : (context) => _buildDefaultPlaceholder(),
      headers: headers,
      semanticsLabel: semanticsLabel,
    );

    // إضافة padding إذا كان موجود
    if (padding != null) {
      svgWidget = Padding(padding: padding!, child: svgWidget);
    }

    // إضافة background color و border radius
    if (backgroundColor != null || borderRadius != null) {
      svgWidget = Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: borderRadius,
        ),
        child: svgWidget,
      );
    }

    // إضافة margin إذا كان موجود
    if (margin != null) {
      svgWidget = Padding(padding: margin!, child: svgWidget);
    }

    // إضافة onTap إذا كان موجود
    if (onTap != null) {
      svgWidget = InkWell(
        onTap: onTap,
        borderRadius: borderRadius,
        child: svgWidget,
      );
    }

    return svgWidget;
  }

  /// بناء placeholder افتراضي
  Widget _buildDefaultPlaceholder() {
    return SizedBox(
      width: width,
      height: height,
      child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
    );
  }
}

/// ========================================================
/// Custom Circular SVG Image
/// ========================================================
/// Widget لعرض SVG بشكل دائري (مثل الصور الشخصية)
/// ========================================================

class CustomCircularSvgImage extends StatelessWidget {
  /// مسار ملف الـ SVG
  final String assetPath;

  /// قطر الدائرة
  final double radius;

  /// لون الصورة
  final Color? color;

  /// لون الحدود
  final Color? borderColor;

  /// عرض الحدود
  final double borderWidth;

  /// دالة تُنفذ عند الضغط على الصورة
  final VoidCallback? onTap;

  /// background color للحاوية
  final Color? backgroundColor;

  /// semantic label لـ accessibility
  final String? semanticsLabel;

  const CustomCircularSvgImage({
    Key? key,
    required this.assetPath,
    this.radius = 40,
    this.color,
    this.borderColor,
    this.borderWidth = 0,
    this.onTap,
    this.backgroundColor,
    this.semanticsLabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget content = CircleAvatar(
      radius: radius,
      backgroundColor: backgroundColor ?? Colors.grey[200],
      child: SvgPicture.asset(
        assetPath,
        width: radius * 1.2,
        height: radius * 1.2,
        fit: BoxFit.cover,
        colorFilter: color != null
            ? ColorFilter.mode(color!, BlendMode.srcIn)
            : null,
        semanticsLabel: semanticsLabel,
      ),
    );

    // إضافة border إذا كان موجود
    if (borderWidth > 0 && borderColor != null) {
      content = Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: borderColor!, width: borderWidth),
        ),
        child: content,
      );
    }

    // إضافة onTap إذا كان موجود
    if (onTap != null) {
      content = InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(radius),
        child: content,
      );
    }

    return content;
  }
}

/// ========================================================
/// Custom Icon SVG
/// ========================================================
/// Widget لعرض SVG كـ icon بسيط
/// ========================================================

class CustomIconSvg extends StatelessWidget {
  /// مسار ملف الـ SVG
  final String assetPath;

  /// حجم الـ icon
  final double size;

  /// لون الـ icon
  final Color? color;

  /// دالة تُنفذ عند الضغط على الـ icon
  final VoidCallback? onTap;

  /// semantic label لـ accessibility
  final String? semanticsLabel;

  const CustomIconSvg({
    Key? key,
    required this.assetPath,
    this.size = 24,
    this.color,
    this.onTap,
    this.semanticsLabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget icon = SvgPicture.asset(
      assetPath,
      width: size,
      height: size,
      fit: BoxFit.contain,
      colorFilter: color != null
          ? ColorFilter.mode(color!, BlendMode.srcIn)
          : null,
      semanticsLabel: semanticsLabel,
    );

    if (onTap != null) {
      icon = InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(size / 2),
        child: Padding(padding: const EdgeInsets.all(4.0), child: icon),
      );
    }

    return icon;
  }
}
