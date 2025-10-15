/// ========================================================
/// String Extensions - امتدادات النصوص
/// ========================================================

extension StringExtension on String {
  // ==================== Validation ====================
  bool get isValidEmail {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(this);
  }

  bool get isValidPhone {
    final phoneRegex = RegExp(
      r'^(009665|9665|\+9665|05|5)(5|0|3|6|4|9|1|8|7)([0-9]{7})$',
    );
    return phoneRegex.hasMatch(this);
  }

  bool get isValidPassword {
    return length >= 8;
  }

  bool get isValidUrl {
    final urlRegex = RegExp(
      r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
    );
    return urlRegex.hasMatch(this);
  }

  // ==================== Formatting ====================
  String get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  String get capitalizeWords {
    if (isEmpty) return this;
    return split(' ').map((word) => word.capitalize).join(' ');
  }

  // ==================== Arabic Support ====================
  bool get isArabic {
    final arabicRegex = RegExp(r'[\u0600-\u06FF]');
    return arabicRegex.hasMatch(this);
  }

  // ==================== Null/Empty Check ====================
  bool get isNullOrEmpty => trim().isEmpty;

  bool get isNotNullOrEmpty => trim().isNotEmpty;

  // ==================== Additional Helpers ====================

  /// إزالة المسافات الزائدة
  String get removeExtraSpaces {
    return trim().replaceAll(RegExp(r'\s+'), ' ');
  }

  /// عكس النص
  String get reversed {
    return split('').reversed.join('');
  }

  /// هل يحتوي على أرقام فقط
  bool get isNumeric {
    return RegExp(r'^[0-9]+$').hasMatch(this);
  }

  /// تحويل لـ int بأمان
  int? get toIntOrNull {
    return int.tryParse(this);
  }

  /// تحويل لـ double بأمان
  double? get toDoubleOrNull {
    return double.tryParse(this);
  }

  /// إزالة الأرقام
  String get removeNumbers {
    return replaceAll(RegExp(r'[0-9]'), '');
  }

  /// إزالة الأحرف الخاصة
  String get removeSpecialCharacters {
    return replaceAll(RegExp(r'[^\w\s\u0600-\u06FF]'), '');
  }

  /// الحصول على الأحرف الأولى من كل كلمة
  String get initials {
    if (isEmpty) return '';
    final words = trim().split(RegExp(r'\s+'));
    if (words.length == 1) {
      return words[0].substring(0, 1).toUpperCase();
    }
    return words
        .take(2)
        .map((word) => word.substring(0, 1).toUpperCase())
        .join();
  }

  /// تقصير النص
  String truncate(int maxLength, {String suffix = '...'}) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength)}$suffix';
  }

  /// عدد الكلمات
  int get wordCount {
    return trim().split(RegExp(r'\s+')).length;
  }

  /// عدد الأسطر
  int get lineCount {
    return split('\n').length;
  }

  /// إزالة HTML tags
  String get removeHtmlTags {
    return replaceAll(RegExp(r'<[^>]*>'), '');
  }

  /// تحويل لـ slug (للـ URLs)
  String get toSlug {
    return toLowerCase()
        .trim()
        .replaceAll(RegExp(r'\s+'), '-')
        .replaceAll(RegExp(r'[^\w\-]+'), '');
  }

  /// Base64 encode
  String get toBase64 {
    return Uri.encodeFull(this);
  }

  /// URL encode
  String get urlEncode {
    return Uri.encodeComponent(this);
  }

  /// هل يبدأ بحرف كبير
  bool get startsWithUpperCase {
    if (isEmpty) return false;
    return this[0] == this[0].toUpperCase();
  }

  /// تحويل الأرقام العربية للإنجليزية
  String get arabicToEnglishNumbers {
    const arabic = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];

    var result = this;
    for (var i = 0; i < arabic.length; i++) {
      result = result.replaceAll(arabic[i], english[i]);
    }
    return result;
  }

  /// تحويل الأرقام الإنجليزية للعربية
  String get englishToArabicNumbers {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const arabic = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];

    var result = this;
    for (var i = 0; i < english.length; i++) {
      result = result.replaceAll(english[i], arabic[i]);
    }
    return result;
  }

  /// استخراج الأرقام فقط
  String get extractNumbers {
    return replaceAll(RegExp(r'[^0-9]'), '');
  }

  /// استخراج الأحرف فقط
  String get extractLetters {
    return replaceAll(RegExp(r'[^a-zA-Z\u0600-\u06FF]'), '');
  }

  /// تنسيق رقم الهاتف
  String get formatPhoneNumber {
    if (length == 10) {
      return '${substring(0, 3)} ${substring(3, 6)} ${substring(6)}';
    }
    return this;
  }

  /// إخفاء جزء من النص (للخصوصية)
  String mask({int start = 0, int? end, String maskChar = '*'}) {
    if (isEmpty) return this;
    final endIndex = end ?? length;
    if (start >= endIndex) return this;

    final masked = List.filled(endIndex - start, maskChar).join();
    return replaceRange(start, endIndex, masked);
  }

  /// إخفاء البريد الإلكتروني
  String get maskEmail {
    if (!isValidEmail) return this;
    final parts = split('@');
    if (parts[0].length <= 2) return this;
    return '${parts[0].substring(0, 2)}***@${parts[1]}';
  }

  /// إخفاء رقم الهاتف
  String get maskPhone {
    if (length < 4) return this;
    return '${substring(0, 3)}${'*' * (length - 6)}${substring(length - 3)}';
  }
}
