# 🚀 Init App Flutter - Clean Architecture Template

<div dir="rtl">

## 📖 نظرة عامة

مشروع Flutter احترافي جاهز للاستخدام مع **Clean Architecture** + **Cubit Pattern** + **60+ Package** مُعد ومُهيأ بالكامل.

---

## ✨ المميزات الرئيسية

### 🏗️ البنية المعمارية
- ✅ **Clean Architecture** (Domain, Data, Presentation)
- ✅ **Cubit State Management** (أبسط من BLoC)
- ✅ **Repository Pattern**
- ✅ **Use Cases**
- ✅ **Dependency Injection** (GetIt)

### 📦 60+ Package مُعدة
- ✅ **Networking**: Dio + Interceptors
- ✅ **Storage**: Secure Storage + SharedPreferences + Hive
- ✅ **Navigation**: GoRouter
- ✅ **UI**: 20+ UI packages (Shimmer, Lottie, Cached Images, etc.)
- ✅ **Firebase**: جاهز للاستخدام
- ✅ **Media**: Image Picker + Cropper + File Picker
- ✅ **Location & Maps**: Geolocator + Google Maps
- ✅ **Biometric**: Touch ID / Face ID
- ✅ **Notifications**: Local + Firebase Cloud Messaging

### 🎨 Core جاهز ومتكامل
```
lib/core/
├── base/            # BaseCubit, BaseRepository, BaseUseCase
├── config/          # App Config + Theme
├── network/         # DioClient + Interceptors + Exceptions
├── services/        # 8+ Services جاهزة
├── di/              # Service Locator
├── router/          # App Router
├── errors/          # Failures + Error Handling
├── utils/           # Validators + Extensions + Helpers
└── widgets/         # 15+ Shared Widgets
```

### 📱 Platform Configurations
- ✅ **Android**: minSdk 24, MultiDex, 15+ Permissions
- ✅ **iOS**: iOS 15+ (للـ Firebase), 10+ Permission Descriptions
- ✅ **ProGuard Rules**: للـ Release builds
- ✅ **Permission Helper**: جاهز للاستخدام

---

## 🚀 البدء السريع

### 1. تثبيت
```bash
flutter pub get

# iOS only:
cd ios && pod install && cd ..
```

### 2. تشغيل
```bash
flutter run
```

### 3. إنشاء Feature جديدة باستخدام Script
```bash
./create_feature_cubit.sh product
```
سيُنشئ Feature كاملة مع Cubit في ثوانِ!

---

## 📚 الوثائق الأساسية

### 📄 ملفات Documentation (4 فقط):
1. **README.md** (هذا الملف) - نظرة عامة وبداية سريعة
2. **CORE_STRUCTURE.md** - شرح تفصيلي لهيكل Core
3. **CUBIT_GUIDE.md** - دليل Cubit Pattern + أمثلة
4. **PLATFORM_CONFIGURATIONS.md** - شرح Configurations (Android/iOS)

---

## 💡 أمثلة سريعة

### استيراد Core
```dart
import 'package:Bynona/core/core.dart';
```

### استخدام Cubit
```dart
class ProductCubit extends BaseCubit {
  final GetProductsUseCase getProductsUseCase;
  
  ProductCubit(this.getProductsUseCase);
  
  Future<void> loadProducts() async {
    await executeUseCase(
      useCase: () => getProductsUseCase.call(),
    );
  }
}
```

### استخدام Custom Widgets
```dart
// زر مع Loading
CustomButton(
  text: 'تسجيل الدخول',
  onPressed: () => cubit.login(),
  isLoading: state is LoadingState,
  icon: Icon(Icons.login),
);

// حقل نصي مع Validation
CustomTextField(
  label: 'البريد الإلكتروني',
  controller: emailController,
  validator: Validators.email,
  prefixIcon: Icon(Icons.email),
);
```

### استخدام Permission Helper
```dart
// طلب صلاحية الكاميرا
final granted = await PermissionHelper.requestCamera(context);
if (granted) {
  // استخدم الكاميرا
}

// طلب أكثر من صلاحية
final granted = await PermissionHelper.requestCameraAndPhotos(context);
```

### استخدام Extensions
```dart
// String Extensions
'test@email.com'.isValidEmail;     // true
'0512345678'.isValidPhone;         // true
'hello'.capitalize;                // 'Hello'

// Context Extensions
context.showSuccessSnackBar('تم الحفظ');
context.showLoadingDialog();
context.hideKeyboard();

// DateTime Extensions
DateTime.now().timeAgo;            // 'منذ 5 دقائق'
DateTime.now().isToday;            // true
```

### استخدام Storage
```dart
// Secure Storage (للـ Tokens)
final storage = getIt<SecureStorageService>();
await storage.write('token', 'your_token');
final token = await storage.read('token');

// Local Storage (للإعدادات)
final localStorage = getIt<LocalStorageService>();
await localStorage.setString('theme', 'dark');
```

### استخدام Networking
```dart
final dio = getIt<DioClient>();

// GET Request
final response = await dio.get('/products');

// POST Request
final response = await dio.post(
  '/login',
  data: {'email': 'test@test.com', 'password': '123456'},
);
```

---

## 🎯 إنشاء Feature جديدة

### طريقة 1: Script (سريع ⚡)
```bash
./create_feature_cubit.sh product
```

### طريقة 2: يدوي
```
lib/features/product/
├── data/
│   ├── models/product_model.dart
│   ├── datasources/product_remote_datasource.dart
│   └── repositories/product_repository_impl.dart
├── domain/
│   ├── entities/product.dart
│   ├── repositories/product_repository.dart
│   └── usecases/get_products_usecase.dart
└── presentation/
    ├── cubit/
    │   ├── product_cubit.dart
    │   └── product_state.dart
    └── pages/product_page.dart
```

**للتفاصيل:** راجع `CUBIT_GUIDE.md`

---

## ⚙️ Configurations

### تغيير Base URL
```dart
// في lib/core/config/app_config.dart
static const String productionBaseUrl = 'https://your-api.com/api/v1';
```

### تغيير Theme
```dart
// في lib/core/config/theme_config.dart
static const Color primaryColor = Color(0xFF6C5CE7);
```

### إضافة Route
```dart
// في lib/core/router/app_router.dart
GoRoute(
  path: '/product/:id',
  name: 'product',
  builder: (context, state) {
    final id = state.pathParameters['id'];
    return ProductPage(id: id);
  },
),
```

### تسجيل Dependency
```dart
// في lib/core/di/service_locator.dart
getIt.registerFactory<ProductCubit>(
  () => ProductCubit(getIt<GetProductsUseCase>()),
);
```

---

## 🔥 Firebase Setup (اختياري)

### Android
1. أضف `google-services.json` في `android/app/`
2. في `android/app/build.gradle.kts` قم بإلغاء التعليق:
   ```kotlin
   id("com.google.gms.google-services")
   ```

### iOS
1. أضف `GoogleService-Info.plist` في Xcode
2. نفذ: `cd ios && pod install`

**التفاصيل:** راجع `PLATFORM_CONFIGURATIONS.md`

---

## 🗺️ Google Maps Setup (اختياري)

1. احصل على API Key من Google Cloud Console
2. **Android:** أضفه في `AndroidManifest.xml`
3. **iOS:** أضفه في `AppDelegate.swift`

**التفاصيل:** راجع `PLATFORM_CONFIGURATIONS.md`

---

## 📦 الباقات الرئيسية

| الفئة | الباقة | الاستخدام |
|------|--------|---------|
| State Management | flutter_bloc | ✅ Cubit Pattern |
| DI | get_it | ✅ Service Locator |
| Navigation | go_router | ✅ Routing |
| Networking | dio | ✅ HTTP Client |
| Storage | flutter_secure_storage | ✅ Tokens |
| Storage | shared_preferences | ✅ Settings |
| Storage | hive | ✅ Local DB |
| UI | flutter_screenutil | ✅ Responsive |
| Localization | easy_localization | ✅ AR/EN |
| Permissions | permission_handler | ✅ Runtime Permissions |
| Media | image_picker | ✅ Camera/Gallery |
| Location | geolocator | ✅ GPS |
| Maps | google_maps_flutter | ✅ Maps |
| Biometric | local_auth | ✅ Face/Touch ID |

**القائمة الكاملة (60+):** راجع `pubspec.yaml`

---

## 🛠️ Utilities الجاهزة

### Validators
```dart
Validators.required
Validators.email
Validators.phone
Validators.password
Validators.strongPassword
Validators.minLength(6)
Validators.maxLength(20)
Validators.numeric
Validators.url
```

### Helpers
```dart
PermissionHelper.requestCamera(context)
PermissionHelper.requestLocation(context)
PermissionHelper.requestNotification(context)
ImagePickerHelper.pickFromCamera()
ImagePickerHelper.pickFromGallery()
BottomSheetHelper.show(context, widget)
```

### Shared Widgets
```dart
CustomButton
CustomTextField
CustomAppBar
CustomCard
LoadingWidget
EmptyWidget
ErrorDisplayWidget
CachedImageWidget
```

---

## 📱 Build Commands

### Debug
```bash
flutter run
```

### Release (Android)
```bash
flutter build apk --release
flutter build appbundle --release  # للـ Play Store
```

### Release (iOS)
```bash
flutter build ios --release
# ثم افتح Xcode: open ios/Runner.xcworkspace
```

---

## ⚠️ ملاحظات مهمة

### للـ Production:
- ❌ احذف `android:usesCleartextTraffic="true"` من AndroidManifest
- ❌ احذف `NSAllowsArbitraryLoads` من Info.plist  
- ✅ أضف Signing Config للـ Release
- ✅ اختبر على أجهزة حقيقية

### للـ Permissions:
- ⚡ استخدم `PermissionHelper` لطلب الصلاحيات
- ⚡ Android 13+ يحتاج notification permission في runtime
- ⚡ iOS يحتاج descriptions واضحة في Info.plist

---

## 📊 إحصائيات المشروع

- ✅ **60+ Package** جاهزة
- ✅ **25+ Permission** مُعدة
- ✅ **15+ Widget** جاهزة
- ✅ **8+ Service** جاهزة
- ✅ **Clean Architecture** كاملة
- ✅ **Cubit Pattern** جاهز
- ✅ **Zero Configuration** errors

---

## 🎓 للتعلم أكثر

### وثائق المشروع:
1. `CORE_STRUCTURE.md` - هيكل Core بالتفصيل
2. `CUBIT_GUIDE.md` - دليل Cubit + 6 أمثلة عملية
3. `PLATFORM_CONFIGURATIONS.md` - كل شيء عن Configurations

### مصادر خارجية:
- [Flutter Docs](https://flutter.dev/docs)
- [BLoC/Cubit Library](https://bloclibrary.dev)
- [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)

---

## 🤝 المساهمة

المساهمات مرحب بها! افتح Issue أو Pull Request.

---

## 📄 الترخيص

MIT License - مفتوح المصدر للجميع.

---

## 👨‍💻 المطور

صُنع بـ ❤️ للمطورين العرب 🇸🇦

---

### 💡 نصيحة أخيرة:

**ابدأ بقراءة:**
1. هذا الملف (README.md) ✅
2. CORE_STRUCTURE.md (لفهم الهيكل)
3. CUBIT_GUIDE.md (لتعلم Cubit Pattern)
4. ثم ابدأ التطوير! 🚀

</div>

## ✨ المميزات

### 📦 الباقات المدمجة
- ✅ **State Management**: Flutter BLoC
- ✅ **Dependency Injection**: GetIt
- ✅ **Navigation**: GoRouter
- ✅ **Networking**: Dio مع Interceptors كاملة
- ✅ **Storage**: Secure Storage + Shared Preferences
- ✅ **Localization**: Easy Localization (عربي/English)
- ✅ **UI**: ScreenUtil, Google Fonts, Shimmer, Lottie
- ✅ **Validation**: validators مخصصة شاملة

### 🏗️ البنية المعمارية
- ✅ **Clean Architecture** جاهزة
- ✅ **BLoC Pattern** مجهز
- ✅ **Repository Pattern**
- ✅ **Use Cases**
- ✅ **Error Handling** متقدم

### 🎨 الـ Core الكامل
```
lib/core/
├── config/          # App Config + Theme Config
├── network/         # Dio Client + Interceptors + Exceptions
├── services/        # Storage Services
├── di/              # Service Locator
├── router/          # App Router
├── errors/          # Failures
├── models/          # Shared Models
├── constants/       # App Constants
├── utils/           # Validators + Extensions
└── widgets/         # Shared Widgets
```

## 🚀 البدء السريع

### 1️⃣ تثبيت المكتبات
```bash
flutter pub get
```

### 2️⃣ تشغيل التطبيق
```bash
flutter run
```

## 📚 كيفية الاستخدام

### استيراد الـ Core
```dart
import 'package:Bynona/core/core.dart';
```

### استخدام DioClient
```dart
final dioClient = getIt<DioClient>();
final response = await dioClient.get('/endpoint');
```

### استخدام Storage
```dart
// Secure Storage للبيانات الحساسة (Tokens)
final secureStorage = getIt<SecureStorageService>();
await secureStorage.write('token', 'your_token');

// Local Storage للإعدادات
final localStorage = getIt<LocalStorageService>();
await localStorage.setString('theme', 'dark');
```

### استخدام Router
```dart
// الانتقال البسيط
AppRouter.goNamed(context, 'login');

// الانتقال مع بيانات
AppRouter.pushNamed(
  context,
  'profile',
  extra: {'userId': '123'},
);
```

### استخدام Extensions
```dart
// String Extensions
'test@example.com'.isValidEmail; // true
'0512345678'.isValidPhone; // true

// Context Extensions
context.showSuccessSnackBar('تم الحفظ بنجاح');
context.showLoadingDialog();
context.hideKeyboard();

// DateTime Extensions
DateTime.now().timeAgo; // "منذ 5 دقائق"
```

### استخدام Validators
```dart
TextFormField(
  validator: Validators.email,
);

// دمج عدة validators
TextFormField(
  validator: (value) => Validators.compose([
    Validators.required,
    Validators.email,
  ], value),
);
```

### استخدام Widgets الجاهزة
```dart
// زر مخصص
CustomButton(
  text: 'تسجيل الدخول',
  onPressed: () {},
  isLoading: isLoading,
);

// حقل نصي مخصص
CustomTextField(
  label: 'البريد الإلكتروني',
  validator: Validators.email,
  prefixIcon: Icon(Icons.email),
);

// عرض التحميل
LoadingWidget(message: 'جاري التحميل...');

// عرض الخطأ
ErrorDisplayWidget(
  message: error.message,
  onRetry: () => retry(),
);
```

## 🎯 إنشاء Feature جديدة

### البنية المقترحة:
```
lib/features/auth/
├── data/
│   ├── models/
│   │   └── user_model.dart
│   ├── datasources/
│   │   └── auth_remote_datasource.dart
│   └── repositories/
│       └── auth_repository_impl.dart
├── domain/
│   ├── entities/
│   │   └── user.dart
│   ├── repositories/
│   │   └── auth_repository.dart
│   └── usecases/
│       └── login_usecase.dart
└── presentation/
    ├── bloc/
    │   └── auth_bloc.dart
    ├── pages/
    │   └── login_page.dart
    └── widgets/
        └── login_form.dart
```

### خطوات الإنشاء:

#### 1. إنشاء Entity
```dart
class User {
  final String id;
  final String email;
  final String name;

  const User({
    required this.id,
    required this.email,
    required this.name,
  });
}
```

#### 2. إنشاء Repository Interface
```dart
abstract class AuthRepository {
  Future<Either<Failure, User>> login(String email, String password);
}
```

#### 3. إنشاء Use Case
```dart
class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either<Failure, User>> call(String email, String password) {
    return repository.login(email, password);
  }
}
```

#### 4. تسجيل في Service Locator
```dart
// في lib/core/di/service_locator.dart
getIt.registerLazySingleton<AuthRepository>(
  () => AuthRepositoryImpl(getIt<DioClient>()),
);

getIt.registerLazySingleton<LoginUseCase>(
  () => LoginUseCase(getIt<AuthRepository>()),
);

getIt.registerFactory<AuthBloc>(
  () => AuthBloc(getIt<LoginUseCase>()),
);
```

## ⚙️ الإعدادات

### تغيير الـ Base URL
في `lib/core/config/app_config.dart`:
```dart
static const String productionBaseUrl = 'https://your-api.com/api/v1';
```

### تغيير الألوان والثيم
في `lib/core/config/theme_config.dart`:
```dart
static const Color primaryColor = Color(0xFF6C5CE7);
```

### إضافة Route جديد
في `lib/core/router/app_router.dart`:
```dart
GoRoute(
  path: '/profile',
  name: 'profile',
  builder: (context, state) => const ProfilePage(),
),
```

## 📱 Build Modes

### Development
```bash
flutter run --dart-define=MODE=dev
```

### Staging
```bash
flutter run --dart-define=MODE=staging
```

### Production
```bash
flutter run --dart-define=MODE=production --release
```

## 🔒 الأمان

- ✅ Secure Storage للبيانات الحساسة
- ✅ Token Auto-refresh
- ✅ SSL Pinning جاهز للإضافة
- ✅ Biometric Authentication (مدمج)

## 🌍 اللغات المدعومة

- 🇸🇦 العربية (افتراضي)
- 🇬🇧 الإنجليزية

### إضافة ترجمة جديدة:
1. أضف الملف في `assets/translations/`
2. حدّث `supportedLocales` في `main.dart`

## 📦 الباقات الرئيسية

| الفئة | الباقة | الإصدار |
|------|--------|---------|
| State Management | flutter_bloc | ^9.1.1 |
| DI | get_it | ^8.2.0 |
| Navigation | go_router | ^16.2.4 |
| Networking | dio | ^5.5.0 |
| Storage | shared_preferences | ^2.5.3 |
| Storage | flutter_secure_storage | ^9.2.2 |
| UI | flutter_screenutil | ^5.5.0 |
| UI | google_fonts | ^6.2.1 |
| Localization | easy_localization | ^3.0.7 |

**للقائمة الكاملة**: انظر `pubspec.yaml`

## 🛠️ الأدوات المساعدة

### Validators المتوفرة:
- `required` - حقل مطلوب
- `email` - بريد إلكتروني
- `phone` - رقم هاتف سعودي
- `password` - كلمة مرور
- `strongPassword` - كلمة مرور قوية
- `confirmPassword` - تطابق كلمات المرور
- `minLength` - حد أدنى للطول
- `maxLength` - حد أقصى للطول
- `numeric` - رقم فقط
- `url` - رابط

### Extensions المتوفرة:
- **String**: isValidEmail, isValidPhone, capitalize, isArabic
- **Context**: showSnackBar, showDialog, push, pop, hideKeyboard
- **DateTime**: timeAgo, isToday, isYesterday

## 📖 الوثائق الإضافية

- [هيكل Core الكامل](CORE_STRUCTURE.md)
- [أمثلة الاستخدام](examples/)

## 🤝 المساهمة

المساهمات مرحب بها! لا تتردد في فتح Issue أو Pull Request.

## 📄 الترخيص

هذا المشروع مفتوح المصدر ومتاح للجميع للاستخدام والتعديل.

## 👨‍💻 المطور

صُنع بـ ❤️ للمطورين العرب

---

### 💡 نصائح:

1. **استخدم الـ Extensions** لتسهيل الكود
2. **استفد من الـ Validators الجاهزة**
3. **استخدم الـ Widgets المشتركة** بدلاً من إعادة كتابتها
4. **اتبع Clean Architecture** للحفاظ على نظافة الكود
5. **استخدم BLoC** لإدارة الحالة بشكل احترافي

### 🎓 تعلم المزيد:

- [Flutter Docs](https://flutter.dev/docs)
- [BLoC Pattern](https://bloclibrary.dev)
- [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)

</div>
