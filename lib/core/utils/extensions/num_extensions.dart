import 'package:intl/intl.dart';

/// ========================================================
/// Num Extensions
/// ========================================================
/// Extensions مفيدة للأرقام
/// ========================================================

extension NumExtensions on num {
  /// تنسيق الرقم بفواصل
  String get formatted {
    return NumberFormat('#,##0.##', 'ar').format(this);
  }

  /// تنسيق كعملة
  String toCurrency({String symbol = 'ج.م'}) {
    return '${formatted} $symbol';
  }

  /// تحويل لنسبة مئوية
  String toPercentage({int decimals = 0}) {
    return '${(this * 100).toStringAsFixed(decimals)}%';
  }

  /// تقريب لأقرب عدد
  num roundTo(int decimals) {
    final factor = 10.0 * decimals;
    return (this * factor).round() / factor;
  }

  /// هل الرقم زوجي
  bool get isEven => this % 2 == 0;

  /// هل الرقم فردي
  bool get isOdd => this % 2 != 0;

  /// هل الرقم موجب
  bool get isPositive => this > 0;

  /// هل الرقم سالب
  bool get isNegative => this < 0;

  /// هل الرقم صفر
  bool get isZero => this == 0;

  /// القيمة المطلقة
  num get absolute => abs();

  /// تحويل لقيمة بين حد أدنى وأقصى
  num clampValue(num min, num max) => clamp(min, max);

  /// تحويل البايتات لحجم مقروء
  String toFileSize() {
    if (this < 1024) return '$this بايت';
    if (this < 1024 * 1024) return '${(this / 1024).toStringAsFixed(1)} كيلوبايت';
    if (this < 1024 * 1024 * 1024) {
      return '${(this / (1024 * 1024)).toStringAsFixed(1)} ميجابايت';
    }
    return '${(this / (1024 * 1024 * 1024)).toStringAsFixed(1)} جيجابايت';
  }

  /// تحويل الثواني لوقت مقروء
  String toReadableTime() {
    final duration = Duration(seconds: toInt());
    if (duration.inHours > 0) {
      return '${duration.inHours}س ${duration.inMinutes.remainder(60)}د';
    }
    if (duration.inMinutes > 0) {
      return '${duration.inMinutes}د ${duration.inSeconds.remainder(60)}ث';
    }
    return '${duration.inSeconds}ث';
  }

  /// تحويل لتقييم نجوم
  String toStars() {
    final fullStars = floor();
    final hasHalf = this - fullStars >= 0.5;
    final emptyStars = 5 - fullStars - (hasHalf ? 1 : 0);
    
    return '⭐' * fullStars + 
           (hasHalf ? '⭐' : '') + 
           '☆' * emptyStars;
  }

  /// الرقم بالعربي (للأرقام الصغيرة)
  String toArabicWords() {
    const ones = [
      '', 'واحد', 'اثنان', 'ثلاثة', 'أربعة', 'خمسة',
      'ستة', 'سبعة', 'ثمانية', 'تسعة'
    ];
    const tens = [
      '', 'عشرة', 'عشرون', 'ثلاثون', 'أربعون', 'خمسون',
      'ستون', 'سبعون', 'ثمانون', 'تسعون'
    ];

    if (this == 0) return 'صفر';
    if (this < 10) return ones[toInt()];
    if (this < 100) {
      final ten = (this ~/ 10);
      final one = (this % 10).toInt();
      return '${tens[ten]}${one > 0 ? ' و${ones[one]}' : ''}';
    }
    return toString(); // للأرقام الكبيرة
  }

  /// تحويل الدقائق لساعات ودقائق
  String minutesToHoursMinutes() {
    final hours = this ~/ 60;
    final minutes = (this % 60).toInt();
    if (hours > 0) {
      return '${hours}س${minutes > 0 ? ' ${minutes}د' : ''}';
    }
    return '${minutes}د';
  }
}

extension DoubleExtensions on double {
  /// تقريب لأقرب 0.5
  double roundToHalf() {
    return (this * 2).round() / 2;
  }

  /// تقريب لأعلى
  int get ceiling => ceil();

  /// تقريب لأسفل  
  int get flooring => floor();
}

extension IntExtensions on int {
  /// تحويل لتنسيق عداد (01, 02, 03)
  String toCounter({int digits = 2}) {
    return toString().padLeft(digits, '0');
  }

  /// هل الرقم أولي
  bool get isPrime {
    if (this <= 1) return false;
    if (this == 2) return true;
    if (this % 2 == 0) return false;
    for (var i = 3; i * i <= this; i += 2) {
      if (this % i == 0) return false;
    }
    return true;
  }

  /// المضاعفات حتى رقم معين
  List<int> multiplesUpTo(int max) {
    return List.generate(max ~/ this, (i) => this * (i + 1));
  }
}
