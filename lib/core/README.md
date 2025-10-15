# 🎯 Core Module - البنية الأساسية للتطبيق

المكتبة الأساسية التي تحتوي على كل المكونات المشتركة والقابلة لإعادة الاستخدام.

---

## 📁 الهيكل التفصيلي

```
core/
├── 📂 base/                    # الفئات الأساسية
│   ├── base_bloc.dart          # States (Loading, Success, Error)
│   ├── base_cubit.dart         # Cubit أساسي
│   ├── base_entity.dart        # Entity أساسي
│   ├── base_repository.dart    # Repository أساسي
│   ├── base_usecase.dart       # UseCase أساسي
│   ├── bloc_observer.dart      # مراقب الـ Bloc
│   ├── network_checker_mixin.dart
│   └── pagination_handler.dart # معالج الـ Pagination
│
├── 📂 config/                  # الإعدادات
│   ├── app_config.dart         # إعدادات التطبيق
│   └── env_config.dart         # Environment variables
│
├── 📂 constants/               # الثوابت
│   ├── api_constants.dart      # ثوابت الـ API
│   ├── app_constants.dart      # ثوابت التطبيق
│   └── enums.dart              # Enumerations
│
├── 📂 di/                      # Dependency Injection
│   └── service_locator.dart    # GetIt setup
│
├── 📂 errors/                  # معالجة الأخطاء
│   ├── failures.dart           # أنواع الأخطاء
│   ├── dio_error_handler.dart  # معالج أخطاء Dio
│   └── api_exceptions.dart     # استثناءات الـ API
│
├── 📂 models/                  # النماذج المشتركة
│   └── response_wrapper.dart   # غلاف الاستجابة
│
├── 📂 network/                 # طبقة الشبكة
│   ├── dio_client.dart         # عميل Dio
│   ├── api_endpoints.dart      # نقاط النهاية
│   └── interceptors/           # Interceptors
│
├── 📂 router/                  # التنقل
│   └── app_router.dart         # إعداد المسارات
│
├── 📂 services/                # الخدمات
│   ├── storage/
│   │   ├── hive_service.dart      # خدمة Hive
│   │   └── secure_storage.dart    # التخزين الآمن
│   ├── connectivity_service.dart  # فحص الإنترنت
│   ├── location_service.dart      # خدمة الموقع
│   └── notification_service.dart  # الإشعارات
│
├── 📂 utils/                   # الأدوات المساعدة
│   ├── extensions/
│   │   ├── context_extensions.dart
│   │   ├── string_extensions.dart
│   │   └── date_extensions.dart
│   ├── validators.dart         # التحقق من المدخلات
│   ├── helpers.dart            # دوال مساعدة
│   └── formatters.dart         # التنسيق
│
└── 📂 widgets/                 # الويدجتات ⭐
    ├── app_widgets.dart        # Barrel file (استخدم هذا!)
    ├── custom_button.dart
    ├── loading_widget.dart
    ├── empty_widget.dart
    └── ... (انظر widgets/README.md)
```

---

## 🎯 المكونات الرئيسية

### 1. Base Classes

#### BaseState
```dart
// حالات موحدة لكل الـ Cubits
LoadingState()          // تحميل
SuccessState(data)      // نجاح
ErrorState(message)     // خطأ
InitialState()          // البداية
```

#### BaseUseCase
```dart
class GetBrandsUseCase extends BaseUseCase<List<Brand>, Params> {
  @override
  Future<Either<Failure, List<Brand>>> call(Params params) async {
    // Business logic
  }
}
```

#### BaseRepository
```dart
class BrandsRepositoryImpl implements BrandsRepository {
  Future<Either<Failure, List<Brand>>> getBrands() async {
    // Data logic
  }
}
```

---

### 2. Error Handling

```dart
// DioErrorHandler - معالجة موحدة للأخطاء
try {
  final response = await api.getBrands();
  return Right(response);
} on DioException catch (e) {
  return Left(DioErrorHandler.handleDioError(e));
}
```

#### أنواع الـ Failures:
- `NetworkFailure` - مشاكل الشبكة
- `ServerFailure` - أخطاء الخادم
- `CacheFailure` - أخطاء الـ Cache
- `AuthFailure` - أخطاء المصادقة

---

### 3. Dependency Injection

```dart
// استخدام GetIt
final brandsCubit = getIt<BrandsCubit>();
final hiveService = getIt<HiveService>();
```

---

### 4. Storage Services

#### HiveService
```dart
// تخزين محلي سريع
await HiveService.instance.saveData('key', value);
final data = await HiveService.instance.getData('key');
```

#### SecureStorage
```dart
// تخزين آمن للبيانات الحساسة
await secureStorage.write('token', token);
final token = await secureStorage.read('token');
```

---

### 5. Widgets

```dart
// استيراد واحد لكل الـ widgets
import 'core/widgets/app_widgets.dart';

CustomButton(text: 'حفظ');
LoadingWidget(message: 'جاري التحميل...');
PaginationGridView(...);
```

👉 [انظر widgets/README.md للتفاصيل](widgets/README.md)

---

## 🚀 الاستخدام السريع

### 1. إنشاء Feature جديد

```dart
// 1. Entity (Domain Layer)
class Product extends Equatable {
  final int id;
  final String name;
  // ...
}

// 2. Repository (Domain Layer)
abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getProducts();
}

// 3. UseCase (Domain Layer)
class GetProductsUseCase extends BaseUseCase<List<Product>, NoParams> {
  final ProductRepository repository;
  
  GetProductsUseCase(this.repository);
  
  @override
  Future<Either<Failure, List<Product>>> call(NoParams params) {
    return repository.getProducts();
  }
}

// 4. Cubit (Presentation Layer)
class ProductsCubit extends Cubit<BaseState> {
  final GetProductsUseCase getProductsUseCase;
  
  ProductsCubit(this.getProductsUseCase) : super(InitialState());
  
  Future<void> getProducts() async {
    emit(LoadingState());
    
    final result = await getProductsUseCase(NoParams());
    
    result.fold(
      (failure) => emit(ErrorState(failure.message)),
      (products) => emit(SuccessState(products)),
    );
  }
}

// 5. UI (Presentation Layer)
BlocBuilder<ProductsCubit, BaseState>(
  builder: (context, state) {
    if (state is LoadingState) return LoadingWidget();
    if (state is ErrorState) return ErrorDisplayWidget(message: state.message);
    if (state is SuccessState) return ProductList(state.data);
    return EmptyWidget();
  },
)
```

---

## 📝 Best Practices

### ✅ افعل:
1. استخدم الـ Base Classes
2. اتبع Clean Architecture
3. استخدم Dependency Injection
4. استخدم Either<Failure, Success>
5. استخدم الـ widgets من Core
6. وثق الكود الجديد

### ❌ لا تفعل:
1. لا تضع business logic في الـ UI
2. لا تستخدم print() (استخدم debugPrint)
3. لا تكرر الكود
4. لا تتجاهل معالجة الأخطاء
5. لا تستخدم hardcoded strings

---

## 🔄 التحديثات المستقبلية

### مخطط لها:
- [ ] Analytics Service
- [ ] Crashlytics Service
- [ ] Push Notifications
- [ ] Biometric Authentication
- [ ] Offline Mode Support
- [ ] Multi-language Support Enhancement

---

## 📚 موارد إضافية

- [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Flutter BLoC](https://bloclibrary.dev/)
- [GetIt Documentation](https://pub.dev/packages/get_it)
- [Hive Documentation](https://docs.hivedb.dev/)

---

## 🤝 المساهمة

عند إضافة مكونات جديدة للـ Core:

1. اتبع الهيكل الحالي
2. أضف documentation كاملة
3. اكتب unit tests
4. حدث هذا الـ README
5. راجع الكود مع الفريق

---

**✨ Built with ❤️ for clean and maintainable code**
