/// ========================================================
/// Custom Divider
/// ========================================================
/// فاصل قابل للتخصيص
/// ========================================================

import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  final double? height;
  final double? thickness;
  final Color? color;
  final EdgeInsetsGeometry? padding;

  const CustomDivider({
    super.key,
    this.height,
    this.thickness,
    this.color,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Divider(
        height: height,
        thickness: thickness,
        color: color,
      ),
    );
  }
}
