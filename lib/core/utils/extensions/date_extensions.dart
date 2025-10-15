/// ========================================================
/// Date Extensions - امتدادات التواريخ
/// ========================================================

extension DateTimeExtension on DateTime {
  // ==================== Formatting ====================
  String get toDateString => '$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';
  
  String get toTimeString => '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  
  String get toDateTimeString => '$toDateString $toTimeString';

  // ==================== Comparisons ====================
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year && month == yesterday.month && day == yesterday.day;
  }

  bool get isTomorrow {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return year == tomorrow.year && month == tomorrow.month && day == tomorrow.day;
  }

  // ==================== Relative Time ====================
  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inSeconds < 60) {
      return 'منذ ${difference.inSeconds} ثانية';
    } else if (difference.inMinutes < 60) {
      return 'منذ ${difference.inMinutes} دقيقة';
    } else if (difference.inHours < 24) {
      return 'منذ ${difference.inHours} ساعة';
    } else if (difference.inDays < 7) {
      return 'منذ ${difference.inDays} يوم';
    } else if (difference.inDays < 30) {
      return 'منذ ${(difference.inDays / 7).floor()} أسبوع';
    } else if (difference.inDays < 365) {
      return 'منذ ${(difference.inDays / 30).floor()} شهر';
    } else {
      return 'منذ ${(difference.inDays / 365).floor()} سنة';
    }
  }
}
