/// ========================================================
/// App Constants - ثوابت التطبيق
/// ========================================================
/// يحتوي على جميع الثوابت المستخدمة في التطبيق
/// ========================================================
library;

class AppConstants {
  AppConstants._();

  // ==================== Assets ====================
  static const String assetsPath = 'assets';
  static const String imagesPath = '$assetsPath/images';
  static const String iconsPath = '$assetsPath/icons';
  static const String animationsPath = '$assetsPath/animations';
  static const String translationsPath = '$assetsPath/translations';

  // ==================== Common Images ====================
  static const String logoImage = '$imagesPath/logo.png';
  static const String splashImage = '$imagesPath/splash.png';
  static const String placeholderImage = '$imagesPath/placeholder.png';
  static const String noDataImage = '$imagesPath/no_data.png';
  static const String errorImage = '$imagesPath/error.png';

  // ==================== Common Icons ====================
  static const String homeIcon = '$iconsPath/home.svg';
  static const String profileIcon = '$iconsPath/profile.svg';
  static const String settingsIcon = '$iconsPath/settings.svg';

  // ==================== Animations ====================
  static const String loadingAnimation = '$animationsPath/loading.json';
  static const String successAnimation = '$animationsPath/success.json';
  static const String errorAnimation = '$animationsPath/error.json';
  static const String emptyAnimation = '$animationsPath/empty.json';

  // ==================== Regular Expressions ====================
  static final RegExp emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  static final RegExp phoneRegex = RegExp(
    r'^(009665|9665|\+9665|05|5)(5|0|3|6|4|9|1|8|7)([0-9]{7})$',
  );

  static final RegExp passwordRegex = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
  );

  static final RegExp urlRegex = RegExp(
    r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
  );

  // ==================== Validation Messages ====================
  static const String requiredFieldMessage = 'هذا الحقل مطلوب';
  static const String invalidEmailMessage = 'البريد الإلكتروني غير صحيح';
  static const String invalidPhoneMessage = 'رقم الهاتف غير صحيح';
  static const String invalidPasswordMessage =
      'كلمة المرور يجب أن تحتوي على 8 أحرف على الأقل، حرف كبير، حرف صغير، رقم ورمز';
  static const String passwordsNotMatchMessage = 'كلمات المرور غير متطابقة';
  static const String invalidUrlMessage = 'الرابط غير صحيح';

  // ==================== Success Messages ====================
  static const String loginSuccessMessage = 'تم تسجيل الدخول بنجاح';
  static const String registerSuccessMessage = 'تم إنشاء الحساب بنجاح';
  static const String logoutSuccessMessage = 'تم تسجيل الخروج بنجاح';
  static const String updateSuccessMessage = 'تم التحديث بنجاح';
  static const String deleteSuccessMessage = 'تم الحذف بنجاح';
  static const String saveSuccessMessage = 'تم الحفظ بنجاح';

  // ==================== Error Messages ====================
  static const String generalErrorMessage = 'حدث خطأ، يرجى المحاولة مرة أخرى';
  static const String networkErrorMessage = 'خطأ في الاتصال بالشبكة';
  static const String timeoutErrorMessage = 'انتهت مهلة الاتصال';
  static const String unauthorizedErrorMessage = 'غير مصرح لك بالوصول';
  static const String notFoundErrorMessage = 'العنصر غير موجود';

  // ==================== Confirmation Messages ====================
  static const String deleteConfirmationMessage = 'هل أنت متأكد من الحذف؟';
  static const String logoutConfirmationMessage =
      'هل أنت متأكد من تسجيل الخروج؟';
  static const String discardChangesMessage = 'هل تريد تجاهل التغييرات؟';

  // ==================== Button Labels ====================
  static const String confirmButton = 'تأكيد';
  static const String cancelButton = 'إلغاء';
  static const String saveButton = 'حفظ';
  static const String deleteButton = 'حذف';
  static const String editButton = 'تعديل';
  static const String submitButton = 'إرسال';
  static const String nextButton = 'التالي';
  static const String previousButton = 'السابق';
  static const String doneButton = 'تم';
  static const String retryButton = 'إعادة المحاولة';
  static const String closeButton = 'إغلاق';

  // ==================== Pagination ====================
  static const String loadingMoreText = 'جاري التحميل...';
  static const String noMoreDataText = 'لا يوجد المزيد من البيانات';
  static const String pullToRefreshText = 'اسحب للتحديث';
  static const String releaseToRefreshText = 'أفلت للتحديث';
  static const String refreshingText = 'جاري التحديث...';

  // ==================== Empty States ====================
  static const String noDataText = 'لا توجد بيانات';
  static const String noResultsText = 'لا توجد نتائج';
  static const String noNotificationsText = 'لا توجد إشعارات';
  static const String noMessagesText = 'لا توجد رسائل';

  // ==================== Date & Time ====================
  static const String todayText = 'اليوم';
  static const String yesterdayText = 'أمس';
  static const String tomorrowText = 'غداً';
  static const String nowText = 'الآن';

  // ==================== File Upload ====================
  static const String selectImageText = 'اختر صورة';
  static const String selectFileText = 'اختر ملف';
  static const String uploadingText = 'جاري الرفع...';
  static const String uploadSuccessText = 'تم الرفع بنجاح';
  static const String uploadFailedText = 'فشل الرفع';
  static const String fileSizeExceededText = 'حجم الملف كبير جداً';

  // ==================== Permissions ====================
  static const String cameraPermissionText = 'صلاحية الكاميرا مطلوبة';
  static const String storagePermissionText = 'صلاحية التخزين مطلوبة';
  static const String locationPermissionText = 'صلاحية الموقع مطلوبة';
  static const String notificationPermissionText = 'صلاحية الإشعارات مطلوبة';
}
