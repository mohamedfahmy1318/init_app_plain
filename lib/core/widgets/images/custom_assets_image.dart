/// ========================================================
/// Custom Assets Image Widget
/// ========================================================
/// Widget مخصص لعرض الصور من Assets
/// يدعم الـ caching، placeholder، error handling
/// ========================================================

import 'package:flutter/material.dart';

class CustomAssetsImage extends StatelessWidget {
  /// مسار الصورة في Assets
  final String assetPath;

  /// عرض الصورة
  final double? width;

  /// ارتفاع الصورة
  final double? height;

  /// كيفية ملء المساحة
  final BoxFit fit;

  /// محاذاة الصورة
  final Alignment alignment;

  /// لون الصورة (color filter)
  final Color? color;

  /// blend mode للون
  final BlendMode? colorBlendMode;

  /// دالة تُنفذ عند الضغط على الصورة
  final VoidCallback? onTap;

  /// widget placeholder أثناء التحميل
  final Widget? placeholder;

  /// widget في حال حدوث خطأ
  final Widget? errorWidget;

  /// إضافة padding حول الصورة
  final EdgeInsetsGeometry? padding;

  /// إضافة margin حول الصورة
  final EdgeInsetsGeometry? margin;

  /// border radius للصورة
  final BorderRadius? borderRadius;

  /// background color للحاوية
  final Color? backgroundColor;

  /// هل الصورة شفافة
  final bool isAntiAlias;

  /// filter quality
  final FilterQuality filterQuality;

  /// semantic label لـ accessibility
  final String? semanticsLabel;

  /// package name إذا كانت الصورة من package خارجي
  final String? package;

  /// هل يتم استخدام cacheWidth
  final int? cacheWidth;

  /// هل يتم استخدام cacheHeight
  final int? cacheHeight;

  const CustomAssetsImage({
    super.key,
    required this.assetPath,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.alignment = Alignment.center,
    this.color,
    this.colorBlendMode,
    this.onTap,
    this.placeholder,
    this.errorWidget,
    this.padding,
    this.margin,
    this.borderRadius,
    this.backgroundColor,
    this.isAntiAlias = true,
    this.filterQuality = FilterQuality.low,
    this.semanticsLabel,
    this.package,
    this.cacheWidth,
    this.cacheHeight,
  });

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;

    try {
      imageWidget = Image.asset(
        assetPath,
        width: width,
        height: height,
        fit: fit,
        alignment: alignment,
        color: color,
        colorBlendMode: colorBlendMode,
        isAntiAlias: isAntiAlias,
        filterQuality: filterQuality,
        semanticLabel: semanticsLabel,
        package: package,
        cacheWidth: cacheWidth,
        cacheHeight: cacheHeight,
        errorBuilder: (context, error, stackTrace) {
          return errorWidget ?? _buildDefaultErrorWidget();
        },
        frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
          if (wasSynchronouslyLoaded) {
            return child;
          }
          return AnimatedOpacity(
            opacity: frame == null ? 0 : 1,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            child: child,
          );
        },
      );
    } catch (e) {
      imageWidget = errorWidget ?? _buildDefaultErrorWidget();
    }

    // إضافة border radius
    if (borderRadius != null) {
      imageWidget = ClipRRect(borderRadius: borderRadius!, child: imageWidget);
    }

    // إضافة padding
    if (padding != null) {
      imageWidget = Padding(padding: padding!, child: imageWidget);
    }

    // إضافة background color
    if (backgroundColor != null) {
      imageWidget = Container(color: backgroundColor, child: imageWidget);
    }

    // إضافة margin
    if (margin != null) {
      imageWidget = Padding(padding: margin!, child: imageWidget);
    }

    // إضافة onTap
    if (onTap != null) {
      imageWidget = InkWell(
        onTap: onTap,
        borderRadius: borderRadius,
        child: imageWidget,
      );
    }

    return imageWidget;
  }

  /// بناء error widget افتراضي
  Widget _buildDefaultErrorWidget() {
    return Container(
      width: width,
      height: height,
      color: Colors.grey[300],
      child: const Icon(
        Icons.broken_image_outlined,
        color: Colors.grey,
        size: 40,
      ),
    );
  }
}

/// ========================================================
/// Custom Circular Assets Image
/// ========================================================
/// Widget لعرض صورة Assets بشكل دائري (للصور الشخصية)
/// ========================================================

class CustomCircularAssetsImage extends StatelessWidget {
  /// مسار الصورة في Assets
  final String assetPath;

  /// نصف قطر الدائرة
  final double radius;

  /// لون الحدود
  final Color? borderColor;

  /// عرض الحدود
  final double borderWidth;

  /// background color
  final Color? backgroundColor;

  /// دالة تُنفذ عند الضغط
  final VoidCallback? onTap;

  /// widget في حال حدوث خطأ
  final Widget? errorWidget;

  /// semantic label
  final String? semanticsLabel;

  const CustomCircularAssetsImage({
    super.key,
    required this.assetPath,
    this.radius = 40,
    this.borderColor,
    this.borderWidth = 0,
    this.backgroundColor,
    this.onTap,
    this.errorWidget,
    this.semanticsLabel,
  });

  @override
  Widget build(BuildContext context) {
    Widget content = CircleAvatar(
      radius: radius,
      backgroundColor: backgroundColor ?? Colors.grey[200],
      backgroundImage: AssetImage(assetPath),
      onBackgroundImageError: (exception, stackTrace) {
        // Handle error silently, will show errorWidget instead
      },
    );

    // إضافة border
    if (borderWidth > 0 && borderColor != null) {
      content = Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: borderColor!, width: borderWidth),
        ),
        child: content,
      );
    }

    // إضافة onTap
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
/// Custom Rounded Assets Image
/// ========================================================
/// Widget لعرض صورة Assets مع حواف مستديرة مخصصة
/// ========================================================

class CustomRoundedAssetsImage extends StatelessWidget {
  /// مسار الصورة في Assets
  final String assetPath;

  /// عرض الصورة
  final double? width;

  /// ارتفاع الصورة
  final double? height;

  /// نصف قطر الحواف المستديرة
  final double borderRadius;

  /// كيفية ملء المساحة
  final BoxFit fit;

  /// لون الحدود
  final Color? borderColor;

  /// عرض الحدود
  final double borderWidth;

  /// background color
  final Color? backgroundColor;

  /// دالة تُنفذ عند الضغط
  final VoidCallback? onTap;

  /// widget في حال حدوث خطأ
  final Widget? errorWidget;

  /// shadow
  final List<BoxShadow>? boxShadow;

  /// semantic label
  final String? semanticsLabel;

  const CustomRoundedAssetsImage({
    super.key,
    required this.assetPath,
    this.width,
    this.height,
    this.borderRadius = 12,
    this.fit = BoxFit.cover,
    this.borderColor,
    this.borderWidth = 0,
    this.backgroundColor,
    this.onTap,
    this.errorWidget,
    this.boxShadow,
    this.semanticsLabel,
  });

  @override
  Widget build(BuildContext context) {
    Widget content = Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: borderWidth > 0 && borderColor != null
            ? Border.all(color: borderColor!, width: borderWidth)
            : null,
        boxShadow: boxShadow,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          borderRadius - (borderWidth > 0 ? borderWidth : 0),
        ),
        child: Image.asset(
          assetPath,
          width: width,
          height: height,
          fit: fit,
          semanticLabel: semanticsLabel,
          errorBuilder: (context, error, stackTrace) {
            return errorWidget ?? _buildDefaultErrorWidget();
          },
        ),
      ),
    );

    // إضافة onTap
    if (onTap != null) {
      content = InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius),
        child: content,
      );
    }

    return content;
  }

  /// بناء error widget افتراضي
  Widget _buildDefaultErrorWidget() {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: const Icon(
        Icons.broken_image_outlined,
        color: Colors.grey,
        size: 40,
      ),
    );
  }
}

/// ========================================================
/// Custom Card Assets Image
/// ========================================================
/// Widget لعرض صورة Assets داخل Card مع معلومات إضافية
/// ========================================================

class CustomCardAssetsImage extends StatelessWidget {
  /// مسار الصورة في Assets
  final String assetPath;

  /// عرض الصورة
  final double? width;

  /// ارتفاع الصورة
  final double? height;

  /// عنوان الصورة (اختياري)
  final String? title;

  /// وصف الصورة (اختياري)
  final String? subtitle;

  /// كيفية ملء المساحة
  final BoxFit fit;

  /// دالة تُنفذ عند الضغط
  final VoidCallback? onTap;

  /// border radius
  final double borderRadius;

  /// elevation للـ card
  final double elevation;

  /// widget في حال حدوث خطأ
  final Widget? errorWidget;

  const CustomCardAssetsImage({
    super.key,
    required this.assetPath,
    this.width,
    this.height,
    this.title,
    this.subtitle,
    this.fit = BoxFit.cover,
    this.onTap,
    this.borderRadius = 12,
    this.elevation = 2,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // الصورة
            Image.asset(
              assetPath,
              width: width,
              height: height,
              fit: fit,
              errorBuilder: (context, error, stackTrace) {
                return errorWidget ??
                    Container(
                      width: width,
                      height: height,
                      color: Colors.grey[300],
                      child: const Icon(
                        Icons.broken_image_outlined,
                        color: Colors.grey,
                        size: 40,
                      ),
                    );
              },
            ),

            // النص (إذا كان موجود)
            if (title != null || subtitle != null)
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (title != null)
                      Text(
                        title!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        subtitle!,
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// ========================================================
/// Custom Animated Assets Image
/// ========================================================
/// Widget لعرض صورة Assets مع animation عند الظهور
/// ========================================================

class CustomAnimatedAssetsImage extends StatefulWidget {
  /// مسار الصورة في Assets
  final String assetPath;

  /// عرض الصورة
  final double? width;

  /// ارتفاع الصورة
  final double? height;

  /// كيفية ملء المساحة
  final BoxFit fit;

  /// border radius
  final BorderRadius? borderRadius;

  /// animation duration
  final Duration duration;

  /// animation curve
  final Curve curve;

  /// دالة تُنفذ عند الضغط
  final VoidCallback? onTap;

  const CustomAnimatedAssetsImage({
    super.key,
    required this.assetPath,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.duration = const Duration(milliseconds: 500),
    this.curve = Curves.easeInOut,
    this.onTap,
  });

  @override
  State<CustomAnimatedAssetsImage> createState() =>
      _CustomAnimatedAssetsImageState();
}

class _CustomAnimatedAssetsImageState extends State<CustomAnimatedAssetsImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget imageWidget = Image.asset(
      widget.assetPath,
      width: widget.width,
      height: widget.height,
      fit: widget.fit,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: widget.width,
          height: widget.height,
          color: Colors.grey[300],
          child: const Icon(
            Icons.broken_image_outlined,
            color: Colors.grey,
            size: 40,
          ),
        );
      },
    );

    if (widget.borderRadius != null) {
      imageWidget = ClipRRect(
        borderRadius: widget.borderRadius!,
        child: imageWidget,
      );
    }

    Widget animatedWidget = FadeTransition(
      opacity: _fadeAnimation,
      child: ScaleTransition(scale: _scaleAnimation, child: imageWidget),
    );

    if (widget.onTap != null) {
      animatedWidget = InkWell(
        onTap: widget.onTap,
        borderRadius: widget.borderRadius,
        child: animatedWidget,
      );
    }

    return animatedWidget;
  }
}
