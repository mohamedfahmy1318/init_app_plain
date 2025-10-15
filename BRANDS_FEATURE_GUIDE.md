# 🏷️ Brands Feature - دليل شامل

## 📋 نظرة عامة

الـ **Brands Feature** هي feature كاملة مبنية بالـ **Clean Architecture** والـ **Cubit Pattern** لعرض البراندات من API.

---

## 📁 الهيكل (Structure)

```
lib/features/brands/
├── data/                           # Data Layer (التعامل مع البيانات الخارجية)
│   ├── datasources/
│   │   └── brands_remote_datasource.dart    # الاتصال بالـ API
│   ├── models/
│   │   ├── brand_model.dart                 # Model للتحويل من/إلى JSON
│   │   └── brands_response_model.dart       # Model للـ response الكامل
│   └── repositories/
│       └── brands_repository_impl.dart      # تطبيق الـ Repository
│
├── domain/                         # Domain Layer (Business Logic)
│   ├── entities/
│   │   └── brand_entity.dart                # الكيان الأساسي
│   ├── repositories/
│   │   └── brands_repository.dart           # Contract للـ Repository
│   └── usecases/
│       └── get_brands_usecase.dart          # Use Case لجلب البراندات
│
└── presentation/                   # Presentation Layer (UI)
    ├── cubit/
    │   ├── brands_cubit.dart                # State Management
    │   └── brands_state.dart                # States
    ├── pages/
    │   └── brands_page.dart                 # الصفحة الرئيسية
    └── widgets/
        └── brand_card.dart                  # Widget مخصص للبراند
```

---

## 🎯 الطبقات (Layers)

### 1️⃣ Domain Layer (طبقة الأعمال)

**المسؤولية:** Business Logic النظيف والمستقل

#### 📦 `BrandEntity`
```dart
class BrandEntity {
  final String id;
  final String name;
  final String slug;
  final String image;
  final DateTime createdAt;
  final DateTime updatedAt;
}
```

- ✅ نظيف ومستقل تماماً
- ✅ لا يعرف شيئاً عن JSON أو API
- ✅ يستخدم Equatable للمقارنة

#### 🎯 `GetBrandsUseCase`
```dart
class GetBrandsUseCase {
  final BrandsRepository repository;
  
  Future<Either<Failure, List<BrandEntity>>> call(GetBrandsParams params);
}
```

- ✅ مسؤولية واحدة فقط (Single Responsibility)
- ✅ يعتمد على الـ Repository Interface (Dependency Inversion)
- ✅ يرجع `Either<Failure, Success>` للتعامل الوظيفي مع الأخطاء

---

### 2️⃣ Data Layer (طبقة البيانات)

**المسؤولية:** التعامل مع البيانات الخارجية (API, Database, Cache)

#### 🌐 `BrandsRemoteDataSource`
```dart
class BrandsRemoteDataSourceImpl {
  final DioClient dioClient;
  
  Future<BrandsResponseModel> getBrands({int page, int limit});
}
```

- ✅ يتعامل مع الـ API باستخدام Dio
- ✅ يحول الـ Response لـ Models
- ✅ لا يعرف شيئاً عن الـ Business Logic

#### 📋 `BrandModel`
```dart
class BrandModel extends BrandEntity {
  factory BrandModel.fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson();
  BrandEntity toEntity();
}
```

- ✅ يرث من `BrandEntity`
- ✅ يحول من/إلى JSON
- ✅ يحول لـ Entity نظيف

#### 🔄 `BrandsRepositoryImpl`
```dart
class BrandsRepositoryImpl implements BrandsRepository {
  final BrandsRemoteDataSource remoteDataSource;
  
  Future<Either<Failure, List<BrandEntity>>> getBrands(...);
}
```

- ✅ ينفذ الـ Repository Interface
- ✅ يعالج الأخطاء ويحولها لـ Failures
- ✅ يحول Models لـ Entities

---

### 3️⃣ Presentation Layer (طبقة العرض)

**المسؤولية:** عرض الـ UI والتفاعل مع المستخدم

#### 🎛️ `BrandsCubit`
```dart
class BrandsCubit extends BaseCubit {
  final GetBrandsUseCase getBrandsUseCase;
  
  List<BrandEntity> brands = [];
  int currentPage = 1;
  bool hasMoreData = true;
  
  Future<void> getBrands({bool loadMore});
  Future<void> refreshBrands();
  Future<void> loadMoreBrands();
}
```

**المميزات:**
- ✅ يرث من `BaseCubit` (من الـ Core)
- ✅ Pagination support (تحميل صفحات متعددة)
- ✅ Pull to Refresh
- ✅ Error Handling

#### 📱 `BrandsPage`
```dart
class BrandsPage extends StatelessWidget {
  // عرض البراندات في GridView
  // Pull to Refresh
  // Pagination
  // Error & Empty States
}
```

**المميزات:**
- ✅ GridView بعمودين
- ✅ RefreshIndicator للـ Pull to Refresh
- ✅ Loading State أثناء التحميل
- ✅ Error State مع Retry Button
- ✅ Empty State عند عدم وجود بيانات
- ✅ Pagination (تحميل تلقائي عند الوصول للنهاية)

#### 🎴 `BrandCard`
```dart
class BrandCard extends StatelessWidget {
  final BrandEntity brand;
  final VoidCallback? onTap;
}
```

**المميزات:**
- ✅ Custom Widget قابل لإعادة الاستخدام
- ✅ يستخدم `CachedImageWidget` من الـ Core
- ✅ يستخدم `CustomCard` من الـ Core
- ✅ تصميم نظيف وبسيط

---

## 🔧 Dependency Injection

تم تسجيل جميع التبعيات في `service_locator.dart`:

```dart
// Data Sources
getIt.registerLazySingleton<BrandsRemoteDataSource>(
  () => BrandsRemoteDataSourceImpl(dioClient: getIt<DioClient>()),
);

// Repositories
getIt.registerLazySingleton<BrandsRepository>(
  () => BrandsRepositoryImpl(remoteDataSource: getIt<BrandsRemoteDataSource>()),
);

// UseCases
getIt.registerLazySingleton(
  () => GetBrandsUseCase(repository: getIt<BrandsRepository>()),
);

// Cubits
getIt.registerFactory(
  () => BrandsCubit(getBrandsUseCase: getIt<GetBrandsUseCase>()),
);
```

---

## 🌐 API Integration

### Endpoint
```
GET https://ecommerce.routemisr.com/api/v1/brands?page=1&limit=40
```

### Response Structure
```json
{
  "results": 54,
  "metadata": {
    "currentPage": 1,
    "numberOfPages": 2,
    "limit": 40,
    "nextPage": 2
  },
  "data": [
    {
      "_id": "64089fe824b25627a25315d1",
      "name": "Canon",
      "slug": "canon",
      "image": "https://...",
      "createdAt": "2023-03-08T14:47:04.912Z",
      "updatedAt": "2023-03-08T14:47:04.912Z"
    }
  ]
}
```

---

## 🎨 استخدام الـ Core

### ✅ من Core/Widgets:
- `CustomCard` - للبطاقات
- `CustomAppBar` - للـ AppBar
- `LoadingWidget` - حالة التحميل
- `ErrorDisplayWidget` - حالة الخطأ
- `EmptyWidget` - حالة عدم وجود بيانات
- `CachedImageWidget` - للصور مع Cache

### ✅ من Core/Extensions:
- `context.showErrorSnackBar()` - عرض رسائل الخطأ
- `context.showSuccessSnackBar()` - عرض رسائل النجاح
- `context.showInfoSnackBar()` - عرض رسائل معلوماتية

### ✅ من Core/Base:
- `BaseCubit` - Base class للـ Cubits
- `BaseState` - Base States
- `SuccessState`, `LoadingState`, `ErrorState`

### ✅ من Core/Errors:
- `Failure` - Base class للأخطاء
- `ServerFailure`, `NetworkFailure`, `UnknownFailure`

### ✅ من Core/Network:
- `DioClient` - للـ HTTP Requests

---

## 🚀 كيفية الاستخدام

### 1. Navigation للصفحة
```dart
Navigator.push(
  context,
  MaterialPageRoute(builder: (_) => const BrandsPage()),
);
```

### 2. الـ Cubit يحمل البيانات تلقائياً
```dart
BlocProvider(
  create: (context) => getIt<BrandsCubit>()..getBrands(),
  child: BrandsPage(),
)
```

### 3. عرض البيانات
- ✅ تلقائياً في GridView
- ✅ Pull to Refresh للتحديث
- ✅ Scroll للنهاية لتحميل المزيد

---

## 📊 States Flow

```
InitialState (الحالة الأولية)
    ↓
LoadingState (جاري التحميل...)
    ↓
BrandsLoadedState (تم التحميل بنجاح) ✅
    أو
ErrorState (حدث خطأ) ❌
```

---

## 🎯 المميزات الرئيسية

✅ **Clean Architecture** - فصل كامل بين الطبقات  
✅ **Cubit Pattern** - State Management بسيط وفعال  
✅ **Pagination** - تحميل صفحات متعددة  
✅ **Pull to Refresh** - تحديث البيانات  
✅ **Error Handling** - معالجة متقدمة للأخطاء  
✅ **Cached Images** - الصور تتخزن في الـ Cache  
✅ **Custom Widgets** - Widgets قابلة لإعادة الاستخدام  
✅ **Core Integration** - استخدام كامل للـ Core utilities  
✅ **Dependency Injection** - GetIt للتبعيات  
✅ **SOLID Principles** - مبادئ برمجية صحيحة  

---

## 🔍 Testing

يمكن عمل Testing لكل طبقة بشكل منفصل:

### Unit Tests
- ✅ Test للـ UseCase
- ✅ Test للـ Repository
- ✅ Test للـ Cubit

### Widget Tests
- ✅ Test للـ BrandCard
- ✅ Test للـ BrandsPage

### Integration Tests
- ✅ Test للـ Feature كاملة

---

## 📚 الدروس المستفادة

1. **Clean Architecture** يفصل الـ Business Logic عن الـ UI
2. **Repository Pattern** يعزل الـ Data Source
3. **UseCase** يمثل عملية واحدة فقط
4. **Either** للتعامل الوظيفي مع الأخطاء
5. **Cubit** أبسط من Bloc وكافي لمعظم الحالات
6. **Core Utilities** توفر الوقت والجهد
7. **Dependency Injection** يسهل الـ Testing

---

## 🎓 للمبتدئين

إذا كنت مبتدئ، ابدأ من الأسفل للأعلى:

1. افهم الـ **Entity** (Domain Layer)
2. افهم الـ **Model** (Data Layer)
3. افهم الـ **Repository** (كيف نجيب البيانات)
4. افهم الـ **UseCase** (ليه نستخدمه)
5. افهم الـ **Cubit** (إدارة الحالة)
6. افهم الـ **UI** (العرض)

---

## 🔗 الملفات المهمة

- `brand_entity.dart` - البيانات الأساسية
- `brands_cubit.dart` - إدارة الحالة
- `brands_page.dart` - الصفحة الرئيسية
- `brand_card.dart` - Widget مخصص
- `service_locator.dart` - Dependency Injection

---

**تم إنشاء هذا الـ Feature باستخدام:**
- ✅ Clean Architecture
- ✅ Cubit Pattern
- ✅ SOLID Principles
- ✅ Best Practices
- ✅ Core Integration
