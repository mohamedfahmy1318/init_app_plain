# 🎯 Core Module - الدليل الشامل

## 📁 الهيكل العام

```
lib/core/
├── widgets/          # 18+ Widget جاهز
├── utils/           # 12+ Helper و 7 Extensions
├── services/        # الخدمات الأساسية
├── network/         # Dio & API Configuration
├── router/          # GoRouter Navigation
└── theme/          # الألوان والثيم
```

---

## 🎨 الـ Widgets (18+)

### 1. الأزرار
- `CustomButton` - زر أساسي مع loading state
- `CustomIconButton` - زر أيقونة

### 2. حقول الإدخال
- `CustomTextField` - حقل إدخال
- `CustomSearchBar` - شريط البحث
- `FormBuilderWidget` - بناء فورم كامل

### 3. البطاقات والعرض
- `CustomCard` - بطاقة قابلة للضغط
- `CustomBadge` - شارة للإشعارات
- `CustomDivider` - فاصل

### 4. حالات الواجهة
- `LoadingWidget` - حالة التحميل
- `EmptyWidget` - حالة فارغة
- `ErrorDisplayWidget` - حالة خطأ
- `NetworkAwareWidget` - مراقب الاتصال

### 5. التقييم والصور
- `RatingWidget` - عرض التقييم
- `InteractiveRatingWidget` - تقييم تفاعلي
- `RatingSummaryWidget` - ملخص التقييمات
- `CachedImageWidget` - صور محفوظة مؤقتاً

### 6. التحميل والتصفح
- `ShimmerLoading` - تأثير Shimmer
- `PaginationListView` - قائمة مع pagination
- `PaginationGridView` - شبكة مع pagination

---

## 🛠️ الـ Helpers (12+)

### 1. واجهة المستخدم
```dart
ToastHelper.success('رسالة نجاح');
ToastHelper.error('رسالة خطأ');

DialogHelper.showLoading(context);
DialogHelper.showConfirmation(context, ...);

BottomSheetHelper.showSimple(context: context, child: ...);
BottomSheetHelper.showList(context: context, items: ...);
```

### 2. التاريخ والوقت
```dart
await DateTimePickerHelper.pickDate(context: context);
await DateTimePickerHelper.pickTime(context: context);
DateTimePickerHelper.formatDate(date);
```

### 3. الشبكة والمشاركة
```dart
ConnectivityHelper.hasInternetConnection();
ConnectivityHelper.onConnectivityChanged.listen(...);

ShareHelper.shareText('نص');
ShareHelper.shareFile(file);

UrlLauncherHelper.openUrl('https://...');
UrlLauncherHelper.openWhatsApp('+966...');
```

### 4. الصور والملفات
```dart
await ImagePickerHelper.pickImageFromGallery();
await ImagePickerHelper.pickImageFromCamera();
await ImagePickerHelper.pickMultipleImages();
```

### 5. الأنيميشن
```dart
AnimationHelper.fadeIn(child: widget);
AnimationHelper.slideInFromLeft(child: widget);
AnimationHelper.scale(child: widget);
```

### 6. المساعدات العامة
```dart
Helpers.copyToClipboard('نص');
Helpers.hideKeyboard();
Helpers.vibrate();
Helpers.lightHaptic();

LoggerHelper.debug('رسالة');
LoggerHelper.error('خطأ');
LoggerHelper.apiRequest('GET', '/endpoint');
```

---

## ✨ الـ Extensions (7)

### 1. String Extensions
```dart
'ahmed'.capitalize;              // Ahmed
'hello world'.capitalizeWords;   // Hello World
'email@test.com'.isValidEmail;   // true
'نص طويل جداً'.truncate(10);     // نص طويل...
'Ahmed Mohamed'.initials;        // AM
'0123456789'.maskPhone;          // 012****789
```

### 2. Num Extensions
```dart
1250.formatted;                  // 1,250
99.99.toCurrency();             // 99.99 ر.س
4.5.toStars();                  // ⭐⭐⭐⭐✰
1024.toFileSize();              // 1.0 KB
125.minutesToHoursMinutes();    // 2h 5m
```

### 3. List Extensions
```dart
[1,2,3,4,5].chunk(2);           // [[1,2], [3,4], [5]]
[1,2,2,3].unique();             // [1,2,3]
list.groupBy((item) => item.category);
list.sumBy((item) => item.price);
```

### 4. Widget Extensions
```dart
Text('مرحبا').padding(all: 16);
Container().margin(horizontal: 20);
Icon(Icons.star).center;
Text('نص').expanded;
Widget.visible(isVisible: true);
```

### 5. Color Extensions
```dart
Colors.blue.lighten(0.2);
Colors.red.darken(0.3);
color.toHex();                  // #FF0000
color.textColor;                // أبيض أو أسود حسب اللون
```

### 6. Context Extensions
```dart
context.screenWidth;
context.screenHeight;
context.statusBarHeight;
context.navigationBarHeight;
```

### 7. Date Extensions
```dart
date.isToday;
date.isYesterday;
date.addDays(7);
date.formatDate('dd/MM/yyyy');
```

---

## 🚀 الاستخدام السريع

### مثال كامل
```dart
import 'package:init_app_flutter/core/widgets/app_widgets.dart';
import 'package:init_app_flutter/core/utils/utils.dart';

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NetworkAwareWidget(
        child: Column(
          children: [
            CustomSearchBar(
              controller: controller,
              onSearch: (value) => LoggerHelper.debug('Search: $value'),
            ),
            
            CustomButton(
              text: 'حفظ',
              onPressed: () async {
                if (await ConnectivityHelper.hasInternetConnection()) {
                  ToastHelper.success('تم الحفظ');
                } else {
                  ToastHelper.error('لا يوجد اتصال');
                }
              },
            ).paddingR(all: 16),
            
            CachedImageWidget(
              imageUrl: 'https://...',
              width: 100.w,
              height: 100.h,
              borderRadius: BorderRadius.circular(12.r),
            ),
            
            RatingWidget(rating: 4.5, size: 24),
          ],
        ),
      ),
    );
  }
}
```

---

## 📦 الخدمات

### HiveService - التخزين المحلي
```dart
await HiveService.instance.init();
await HiveService.instance.saveData('key', value);
final data = await HiveService.instance.getData('key');
```

### ApiService - استدعاء APIs
```dart
final response = await ApiService.get('/endpoint');
final response = await ApiService.post('/endpoint', data: {});
```

---

## 🎯 CoreDemoPage

صفحة تجريبية تعرض **جميع** المكونات:
- 18+ Widget
- 12+ Helper  
- 7 Extensions
- أمثلة تفاعلية

**للوصول:** تم تعيينها كصفحة البداية في `app_router.dart`

---

## 📝 ملاحظات

1. **استخدم barrel file**: `import 'core/utils/utils.dart'` بدل استيراد كل ملف
2. **التأكد من الاتصال**: استخدم `NetworkAwareWidget` للصفحات التي تحتاج إنترنت
3. **التوحيد**: استخدم الـ Core بدل كتابة كود مكرر
4. **Logger**: استخدمه في التطوير لتتبع الأخطاء

---

## 🔗 ملفات أخرى مهمة

- `README.md` - نظرة عامة على المشروع
- `HIVE_INTEGRATION.md` - شرح Hive بالتفصيل
- `BRANDS_FEATURE_GUIDE.md` - مثال عملي كامل
- `CUBIT_GUIDE.md` - شرح استخدام BLoC/Cubit
- `MAIN_IMPROVEMENTS.md` - التحسينات على main.dart
- `RECOMMENDED_PACKAGES.md` - البكجات المقترحة
- `PLATFORM_CONFIGURATIONS.md` - إعدادات المنصات
