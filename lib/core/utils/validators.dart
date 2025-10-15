/// ========================================================
/// Validators - المحققات
/// ========================================================
/// يحتوي على جميع دوال التحقق من صحة البيانات
/// ========================================================

class Validators {
  Validators._();

  // ==================== Required Field ====================
  static String? required(String? value, {String? fieldName}) {
    if (value == null || value.trim().isEmpty) {
      return fieldName != null 
          ? '$fieldName مطلوب' 
          : 'هذا الحقل مطلوب';
    }
    return null;
  }

  // ==================== Email ====================
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'البريد الإلكتروني مطلوب';
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(value)) {
      return 'البريد الإلكتروني غير صحيح';
    }

    return null;
  }

  // ==================== Phone ====================
  static String? phone(String? value) {
    if (value == null || value.isEmpty) {
      return 'رقم الهاتف مطلوب';
    }

    final phoneRegex = RegExp(
      r'^(009665|9665|\+9665|05|5)(5|0|3|6|4|9|1|8|7)([0-9]{7})$',
    );

    if (!phoneRegex.hasMatch(value)) {
      return 'رقم الهاتف غير صحيح';
    }

    return null;
  }

  // ==================== Password ====================
  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'كلمة المرور مطلوبة';
    }

    if (value.length < 8) {
      return 'كلمة المرور يجب أن تكون 8 أحرف على الأقل';
    }

    return null;
  }

  // ==================== Strong Password ====================
  static String? strongPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'كلمة المرور مطلوبة';
    }

    if (value.length < 8) {
      return 'كلمة المرور يجب أن تكون 8 أحرف على الأقل';
    }

    final hasUppercase = value.contains(RegExp(r'[A-Z]'));
    final hasLowercase = value.contains(RegExp(r'[a-z]'));
    final hasDigits = value.contains(RegExp(r'[0-9]'));
    final hasSpecialCharacters = value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    if (!hasUppercase || !hasLowercase || !hasDigits || !hasSpecialCharacters) {
      return 'كلمة المرور يجب أن تحتوي على حرف كبير وصغير ورقم ورمز';
    }

    return null;
  }

  // ==================== Confirm Password ====================
  static String? confirmPassword(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return 'تأكيد كلمة المرور مطلوب';
    }

    if (value != password) {
      return 'كلمات المرور غير متطابقة';
    }

    return null;
  }

  // ==================== Min Length ====================
  static String? minLength(String? value, int minLength, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return null;
    }

    if (value.length < minLength) {
      return fieldName != null
          ? '$fieldName يجب أن يكون $minLength أحرف على الأقل'
          : 'يجب أن يكون $minLength أحرف على الأقل';
    }

    return null;
  }

  // ==================== Max Length ====================
  static String? maxLength(String? value, int maxLength, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return null;
    }

    if (value.length > maxLength) {
      return fieldName != null
          ? '$fieldName يجب أن يكون $maxLength أحرف كحد أقصى'
          : 'يجب أن يكون $maxLength أحرف كحد أقصى';
    }

    return null;
  }

  // ==================== Numeric ====================
  static String? numeric(String? value, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return null;
    }

    if (int.tryParse(value) == null) {
      return fieldName != null
          ? '$fieldName يجب أن يكون رقماً'
          : 'يجب أن يكون رقماً';
    }

    return null;
  }

  // ==================== URL ====================
  static String? url(String? value) {
    if (value == null || value.isEmpty) {
      return 'الرابط مطلوب';
    }

    final urlRegex = RegExp(
      r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
    );

    if (!urlRegex.hasMatch(value)) {
      return 'الرابط غير صحيح';
    }

    return null;
  }

  // ==================== Compose Multiple Validators ====================
  static String? compose(List<String? Function(String?)> validators, String? value) {
    for (final validator in validators) {
      final result = validator(value);
      if (result != null) {
        return result;
      }
    }
    return null;
  }
}
