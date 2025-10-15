/// ========================================================
/// Empty Widget
/// ========================================================
/// ويدجت لعرض حالة عدم وجود بيانات
/// ========================================================

import 'package:flutter/material.dart';
import 'custom_button.dart';

class EmptyWidget extends StatelessWidget {
  final String message;
  final IconData icon;
  final VoidCallback? onRetry;

  const EmptyWidget({
    super.key,
    this.message = 'لا توجد بيانات',
    this.icon = Icons.inbox_outlined,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 80,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          if (onRetry != null) ...[
            const SizedBox(height: 16),
            CustomButton(
              text: 'إعادة المحاولة',
              onPressed: onRetry,
            ),
          ],
        ],
      ),
    );
  }
}
