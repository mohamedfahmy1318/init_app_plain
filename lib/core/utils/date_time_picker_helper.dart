import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Date and Time Picker Helper
class DateTimePickerHelper {
  /// Pick a date
  static Future<DateTime?> pickDate({
    required BuildContext context,
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
    String? helpText,
    String? cancelText,
    String? confirmText,
  }) async {
    return await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: firstDate ?? DateTime(1900),
      lastDate: lastDate ?? DateTime(2100),
      helpText: helpText,
      cancelText: cancelText ?? 'إلغاء',
      confirmText: confirmText ?? 'تأكيد',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).primaryColor,
            ),
          ),
          child: child!,
        );
      },
    );
  }

  /// Pick a time
  static Future<TimeOfDay?> pickTime({
    required BuildContext context,
    TimeOfDay? initialTime,
    String? helpText,
    String? cancelText,
    String? confirmText,
  }) async {
    return await showTimePicker(
      context: context,
      initialTime: initialTime ?? TimeOfDay.now(),
      helpText: helpText,
      cancelText: cancelText ?? 'إلغاء',
      confirmText: confirmText ?? 'تأكيد',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).primaryColor,
            ),
          ),
          child: child!,
        );
      },
    );
  }

  /// Pick date and time together
  static Future<DateTime?> pickDateTime({
    required BuildContext context,
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    // Pick date first
    final date = await pickDate(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (date == null) return null;

    // Then pick time
    final time = await pickTime(
      context: context,
      initialTime: initialDate != null
          ? TimeOfDay.fromDateTime(initialDate)
          : TimeOfDay.now(),
    );

    if (time == null) return null;

    // Combine date and time
    return DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
  }

  /// Pick date range
  static Future<DateTimeRange?> pickDateRange({
    required BuildContext context,
    DateTimeRange? initialDateRange,
    DateTime? firstDate,
    DateTime? lastDate,
    String? helpText,
    String? cancelText,
    String? confirmText,
    String? saveText,
  }) async {
    return await showDateRangePicker(
      context: context,
      initialDateRange: initialDateRange,
      firstDate: firstDate ?? DateTime(1900),
      lastDate: lastDate ?? DateTime(2100),
      helpText: helpText ?? 'اختر الفترة',
      cancelText: cancelText ?? 'إلغاء',
      confirmText: confirmText ?? 'تأكيد',
      saveText: saveText ?? 'حفظ',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).primaryColor,
            ),
          ),
          child: child!,
        );
      },
    );
  }

  /// Format date to string
  static String formatDate(
    DateTime date, {
    String pattern = 'yyyy-MM-dd',
    String? locale,
  }) {
    return DateFormat(pattern, locale ?? 'ar').format(date);
  }

  /// Format time to string
  static String formatTime(
    TimeOfDay time, {
    bool use24HourFormat = false,
  }) {
    final hour = use24HourFormat
        ? time.hour.toString().padLeft(2, '0')
        : (time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod)
            .toString()
            .padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    final period = use24HourFormat
        ? ''
        : time.period == DayPeriod.am
            ? ' ص'
            : ' م';

    return '$hour:$minute$period';
  }

  /// Format datetime to string
  static String formatDateTime(
    DateTime dateTime, {
    String pattern = 'yyyy-MM-dd HH:mm',
    String? locale,
  }) {
    return DateFormat(pattern, locale ?? 'ar').format(dateTime);
  }

  /// Get date difference in readable format
  static String getDateDifference(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 365) {
      final years = (difference.inDays / 365).floor();
      return 'منذ $years ${years == 1 ? 'سنة' : 'سنوات'}';
    } else if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return 'منذ $months ${months == 1 ? 'شهر' : 'شهور'}';
    } else if (difference.inDays > 0) {
      return 'منذ ${difference.inDays} ${difference.inDays == 1 ? 'يوم' : 'أيام'}';
    } else if (difference.inHours > 0) {
      return 'منذ ${difference.inHours} ${difference.inHours == 1 ? 'ساعة' : 'ساعات'}';
    } else if (difference.inMinutes > 0) {
      return 'منذ ${difference.inMinutes} ${difference.inMinutes == 1 ? 'دقيقة' : 'دقائق'}';
    } else {
      return 'الآن';
    }
  }

  /// Check if date is today
  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  /// Check if date is yesterday
  static bool isYesterday(DateTime date) {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return date.year == yesterday.year &&
        date.month == yesterday.month &&
        date.day == yesterday.day;
  }

  /// Check if date is this week
  static bool isThisWeek(DateTime date) {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 6));
    
    return date.isAfter(startOfWeek.subtract(const Duration(seconds: 1))) &&
        date.isBefore(endOfWeek.add(const Duration(days: 1)));
  }

  /// Check if date is this month
  static bool isThisMonth(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month;
  }

  /// Get start of day
  static DateTime startOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  /// Get end of day
  static DateTime endOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day, 23, 59, 59, 999);
  }

  /// Get start of month
  static DateTime startOfMonth(DateTime date) {
    return DateTime(date.year, date.month);
  }

  /// Get end of month
  static DateTime endOfMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 0, 23, 59, 59, 999);
  }

  /// Add days to date
  static DateTime addDays(DateTime date, int days) {
    return date.add(Duration(days: days));
  }

  /// Add months to date
  static DateTime addMonths(DateTime date, int months) {
    return DateTime(date.year, date.month + months, date.day);
  }

  /// Add years to date
  static DateTime addYears(DateTime date, int years) {
    return DateTime(date.year + years, date.month, date.day);
  }

  /// Get days between two dates
  static int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return to.difference(from).inDays;
  }
}
