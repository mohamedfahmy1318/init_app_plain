/// ========================================================
/// Custom Badge
/// ========================================================
/// شارة لعرض الأرقام (عدد العناصر، الإشعارات، إلخ)
/// ========================================================

import 'package:flutter/material.dart';

class CustomBadge extends StatelessWidget {
  final String value;
  final Widget child;
  final Color? backgroundColor;
  final Color? textColor;

  const CustomBadge({
    super.key,
    required this.value,
    required this.child,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Badge(
      label: Text(
        value,
        style: TextStyle(
          color: textColor ?? Colors.white,
          fontSize: 12,
        ),
      ),
      backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.error,
      child: child,
    );
  }
}
