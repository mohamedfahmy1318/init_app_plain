import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// ========================================================
/// Widget Extensions
/// ========================================================
/// Extensions مفيدة للـ Widgets
/// ========================================================

extension WidgetExtensions on Widget {
  /// إضافة Padding
  Widget padding({
    double? all,
    double? horizontal,
    double? vertical,
    double? top,
    double? bottom,
    double? left,
    double? right,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        top: top ?? vertical ?? all ?? 0,
        bottom: bottom ?? vertical ?? all ?? 0,
        left: left ?? horizontal ?? all ?? 0,
        right: right ?? horizontal ?? all ?? 0,
      ),
      child: this,
    );
  }

  /// إضافة Padding responsive
  Widget paddingR({
    double? all,
    double? horizontal,
    double? vertical,
    double? top,
    double? bottom,
    double? left,
    double? right,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        top: (top ?? vertical ?? all ?? 0).h,
        bottom: (bottom ?? vertical ?? all ?? 0).h,
        left: (left ?? horizontal ?? all ?? 0).w,
        right: (right ?? horizontal ?? all ?? 0).w,
      ),
      child: this,
    );
  }

  /// إضافة Margin (باستخدام Container)
  Widget margin({
    double? all,
    double? horizontal,
    double? vertical,
    double? top,
    double? bottom,
    double? left,
    double? right,
  }) {
    return Container(
      margin: EdgeInsets.only(
        top: top ?? vertical ?? all ?? 0,
        bottom: bottom ?? vertical ?? all ?? 0,
        left: left ?? horizontal ?? all ?? 0,
        right: right ?? horizontal ?? all ?? 0,
      ),
      child: this,
    );
  }

  /// Center
  Widget get center => Center(child: this);

  /// Align
  Widget align(Alignment alignment) => Align(alignment: alignment, child: this);

  /// Expanded
  Widget get expanded => Expanded(child: this);

  /// Flexible
  Widget flexible({int flex = 1, FlexFit fit = FlexFit.loose}) =>
      Flexible(flex: flex, fit: fit, child: this);

  /// SafeArea
  Widget get safeArea => SafeArea(child: this);

  /// Opacity
  Widget opacity(double opacity) => Opacity(opacity: opacity, child: this);

  /// Visibility
  Widget visible(bool visible) => Visibility(visible: visible, child: this);

  /// Clickable (GestureDetector)
  Widget onTap(VoidCallback onTap) =>
      GestureDetector(onTap: onTap, child: this);

  /// Hero animation
  Widget hero(String tag) => Hero(tag: tag, child: this);

  /// Card wrapper
  Widget card({
    double? elevation,
    Color? color,
    EdgeInsetsGeometry? margin,
    BorderRadius? borderRadius,
  }) {
    return Card(
      elevation: elevation,
      color: color,
      margin: margin,
      shape: borderRadius != null
          ? RoundedRectangleBorder(borderRadius: borderRadius)
          : null,
      child: this,
    );
  }

  /// Container wrapper
  Widget container({
    double? width,
    double? height,
    Color? color,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Decoration? decoration,
    AlignmentGeometry? alignment,
  }) {
    return Container(
      width: width,
      height: height,
      color: color,
      padding: padding,
      margin: margin,
      decoration: decoration,
      alignment: alignment,
      child: this,
    );
  }

  /// Rounded corners
  Widget cornerRadius(double radius) =>
      ClipRRect(borderRadius: BorderRadius.circular(radius), child: this);

  /// Circular shape
  Widget get circular => ClipOval(child: this);

  /// Rotate
  Widget rotate(double angle) => Transform.rotate(angle: angle, child: this);

  /// Scale
  Widget scale(double scale) => Transform.scale(scale: scale, child: this);

  /// Shimmer effect (مع الحاجة لـ shimmer package)
  Widget shimmer() => this; // يمكن تفعيله مع shimmer package

  /// Scrollable
  Widget get scrollable => SingleChildScrollView(child: this);

  /// SliverToBoxAdapter (للـ CustomScrollView)
  Widget get sliverBox => SliverToBoxAdapter(child: this);

  /// Positioned (للـ Stack)
  Widget positioned({
    double? top,
    double? bottom,
    double? left,
    double? right,
  }) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: this,
    );
  }

  /// FittedBox
  Widget fit({BoxFit fit = BoxFit.contain}) => FittedBox(fit: fit, child: this);

  /// Tooltip
  Widget tooltip(String message) => Tooltip(message: message, child: this);

  /// InkWell (مع Ripple effect)
  Widget inkWell({required VoidCallback onTap, BorderRadius? borderRadius}) {
    return InkWell(onTap: onTap, borderRadius: borderRadius, child: this);
  }

  /// Constrained
  Widget constrained({
    double? maxWidth,
    double? maxHeight,
    double? minWidth,
    double? minHeight,
  }) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: maxWidth ?? double.infinity,
        maxHeight: maxHeight ?? double.infinity,
        minWidth: minWidth ?? 0,
        minHeight: minHeight ?? 0,
      ),
      child: this,
    );
  }

  /// Aspect Ratio
  Widget aspectRatio(double ratio) =>
      AspectRatio(aspectRatio: ratio, child: this);

  /// Fractionally sized
  Widget fractionalSize({double? widthFactor, double? heightFactor}) {
    return FractionallySizedBox(
      widthFactor: widthFactor,
      heightFactor: heightFactor,
      child: this,
    );
  }

  /// Ignore pointer
  Widget ignorePointer({bool ignoring = true}) =>
      IgnorePointer(ignoring: ignoring, child: this);

  /// Absorb pointer
  Widget absorbPointer({bool absorbing = true}) =>
      AbsorberPointer(absorbing: absorbing, child: this);
}

/// Custom AbsorberPointer (typo fix)
class AbsorberPointer extends StatelessWidget {
  final bool absorbing;
  final Widget child;

  const AbsorberPointer({
    super.key,
    required this.absorbing,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(absorbing: absorbing, child: child);
  }
}
