# 🎯 Cubit Pattern - Quick Guide

## 📝 لماذا Cubit بدلاً من BLoC؟

### Cubit (أبسط):
✅ **أسهل** في الفهم والكتابة  
✅ **أقل** كود boilerplate  
✅ **أسرع** في التطوير  
✅ **لا يحتاج Events** - تستدعي الدوال مباشرة  
✅ مثالي لـ **State Management بسيط**

### BLoC (أكثر structure):
✅ **أفضل** للـ State Management المعقد  
✅ **Stream-based** Events  
✅ **تتبع أفضل** للـ Event Flow  
✅ مثالي لـ **Enterprise Apps**

---

## 🚀 الفرق في الاستخدام

### مع BLoC:
```dart
// 1. تعريف Event
class GetProductsEvent extends BaseEvent {}

// 2. إضافة Event
context.read<ProductBloc>().add(GetProductsEvent());
```

### مع Cubit:
```dart
// استدعاء مباشر
context.read<ProductCubit>().getProducts();
```

---

## 📦 إنشاء Feature بـ Cubit

### الطريقة 1: Script التلقائي
```bash
./create_feature_cubit.sh product
```

### الطريقة 2: يدوياً
```dart
import '../../../../core/base/base_cubit.dart';

class ProductCubit extends BaseCubit {
  final GetProductsUseCase getProductsUseCase;

  ProductCubit({required this.getProductsUseCase}) 
      : super(const InitialState());

  // Methods بدلاً من Events
  Future<void> getProducts() async {
    emitLoading();
    
    final result = await getProductsUseCase();
    
    result.fold(
      (failure) => emitError(failure.message),
      (products) {
        if (products.isEmpty) {
          emitEmpty(message: 'لا توجد منتجات');
        } else {
          emit(ProductsLoadedState(products));
        }
      },
    );
  }
}
```

---

## 🎨 Complete Example

### 1️⃣ Cubit Definition
```dart
class ProductCubit extends BaseCubit {
  final GetProductsUseCase getProductsUseCase;
  final GetProductByIdUseCase getProductByIdUseCase;
  final CreateProductUseCase createProductUseCase;

  ProductCubit({
    required this.getProductsUseCase,
    required this.getProductByIdUseCase,
    required this.createProductUseCase,
  }) : super(const InitialState());

  // State Variables (for pagination)
  List<ProductEntity> products = [];
  int currentPage = 1;
  bool hasMore = true;
  bool isLoadingMore = false;

  // Get all products
  Future<void> getProducts({bool refresh = false}) async {
    if (refresh) {
      products.clear();
      currentPage = 1;
      hasMore = true;
    }

    emitLoading();

    final result = await getProductsUseCase();

    result.fold(
      (failure) => emitError(failure.message),
      (data) {
        products = data;
        if (products.isEmpty) {
          emitEmpty(message: 'لا توجد منتجات');
        } else {
          emit(ProductsLoadedState(products));
        }
      },
    );
  }

  // Get product by ID
  Future<void> getProductById(int id) async {
    emitLoading();

    final result = await getProductByIdUseCase(id);

    result.fold(
      (failure) => emitError(failure.message),
      (product) => emit(ProductLoadedState(product)),
    );
  }

  // Create product
  Future<void> createProduct(ProductEntity product) async {
    emitLoading();

    final result = await createProductUseCase(product);

    result.fold(
      (failure) => emitError(failure.message),
      (created) {
        products.insert(0, created);
        emit(ProductsLoadedState(products));
        emitSuccess(created, message: 'تم إنشاء المنتج بنجاح');
      },
    );
  }

  // Search products
  Future<void> searchProducts(String query) async {
    if (query.isEmpty) {
      await getProducts(refresh: true);
      return;
    }

    emitLoading();

    // TODO: Implement search usecase
  }

  // Load more (pagination)
  Future<void> loadMore() async {
    if (!hasMore || isLoadingMore) return;

    isLoadingMore = true;

    // TODO: Call pagination usecase
    // final result = await getProductsUseCase(
    //   PaginationParams(page: currentPage + 1, limit: 20),
    // );

    isLoadingMore = false;
  }
}

// Custom States
class ProductsLoadedState extends SuccessState<List<ProductEntity>> {
  const ProductsLoadedState(List<ProductEntity> products) : super(products);
}

class ProductLoadedState extends SuccessState<ProductEntity> {
  const ProductLoadedState(ProductEntity product) : super(product);
}
```

### 2️⃣ UI Usage
```dart
class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProductCubit>()..getProducts(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Products'),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () => _showSearch(context),
            ),
          ],
        ),
        body: BlocConsumer<ProductCubit, BaseState>(
          listener: (context, state) {
            // Show snackbar on success/error
            if (state is SuccessState && state.message != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message!)),
              );
            }
          },
          builder: (context, state) {
            final cubit = context.read<ProductCubit>();

            if (state is LoadingState) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ErrorState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error, size: 64, color: Colors.red),
                    const SizedBox(height: 16),
                    Text(state.message),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => cubit.getProducts(refresh: true),
                      child: const Text('إعادة المحاولة'),
                    ),
                  ],
                ),
              );
            }

            if (state is EmptyState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.inbox, size: 64),
                    const SizedBox(height: 16),
                    Text(state.message ?? 'لا توجد منتجات'),
                  ],
                ),
              );
            }

            if (state is ProductsLoadedState) {
              return RefreshIndicator(
                onRefresh: () => cubit.getProducts(refresh: true),
                child: ListView.builder(
                  itemCount: state.data.length + (cubit.hasMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    // Load more indicator
                    if (index == state.data.length) {
                      cubit.loadMore();
                      return const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }

                    final product = state.data[index];
                    return ProductCard(
                      product: product,
                      onTap: () => cubit.getProductById(product.id),
                    );
                  },
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showCreateDialog(context),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void _showSearch(BuildContext context) {
    // Implement search dialog
  }

  void _showCreateDialog(BuildContext context) {
    // Implement create dialog
  }
}
```

---

## 🎯 Helper Methods في BaseCubit

```dart
abstract class BaseCubit extends Cubit<BaseState> {
  // Built-in helper methods
  void emitLoading();
  void emitSuccess<T>(T data, {String? message});
  void emitError(String message);
  void emitEmpty({String? message});
  void emitInitial();
}
```

### استخدام:
```dart
// بدلاً من:
emit(const LoadingState());

// استخدم:
emitLoading();

// بدلاً من:
emit(SuccessState(data));

// استخدم:
emitSuccess(data);

// مع رسالة:
emitSuccess(data, message: 'تم الحفظ بنجاح');
```

---

## 📊 Comparison Table

| Feature | BLoC | Cubit |
|---------|------|-------|
| **Events** | ✅ نعم | ❌ لا (Methods مباشرة) |
| **Boilerplate** | 🔴 كثير | 🟢 قليل |
| **Complexity** | 🔴 معقد | 🟢 بسيط |
| **Stream-based** | ✅ نعم | ✅ نعم |
| **Testing** | ✅ سهل | ✅ سهل |
| **State Management** | ✅ احترافي | ✅ احترافي |
| **Learning Curve** | 🔴 صعب | 🟢 سهل |
| **Best For** | Large Apps | Small-Medium Apps |

---

## 🔄 Migration من BLoC إلى Cubit

### قبل (BLoC):
```dart
// Event
class GetProductsEvent extends BaseEvent {}

// BLoC
class ProductBloc extends Bloc<BaseEvent, BaseState> {
  ProductBloc() : super(const InitialState()) {
    on<GetProductsEvent>(_onGetProducts);
  }

  Future<void> _onGetProducts(event, emit) async {
    emit(const LoadingState());
    // ...
  }
}

// UI
bloc.add(GetProductsEvent());
```

### بعد (Cubit):
```dart
// Cubit (no events!)
class ProductCubit extends BaseCubit {
  ProductCubit() : super(const InitialState());

  Future<void> getProducts() async {
    emitLoading();
    // ...
  }
}

// UI
cubit.getProducts();
```

---

## 📝 DI Registration

```dart
// في service_locator.dart

// Cubit (Factory - يُنشأ مع كل استخدام)
getIt.registerFactory<ProductCubit>(
  () => ProductCubit(
    getProductsUseCase: getIt<GetProductsUseCase>(),
    getProductByIdUseCase: getIt<GetProductByIdUseCase>(),
  ),
);
```

---

## ✅ Best Practices

### ✅ DO:
- استخدم Cubit للـ Features البسيطة والمتوسطة
- استخدم helper methods (`emitLoading`, `emitSuccess`, etc.)
- احتفظ بالـ State variables في Cubit للـ pagination
- استخدم `refresh` parameter لإعادة التحميل
- استخدم `BlocConsumer` عند الحاجة لـ listener

### ❌ DON'T:
- لا تضع UI Logic في Cubit
- لا تستدعي Methods من داخل `build()` مباشرة
- لا تنسى `close()` عند التخلص من Cubit (تلقائي مع BlocProvider)

---

## 🚀 Quick Start

### 1. إنشاء Feature:
```bash
./create_feature_cubit.sh product
```

### 2. تسجيل في DI:
```dart
getIt.registerFactory<ProductCubit>(
  () => ProductCubit(
    getProductsUseCase: getIt(),
  ),
);
```

### 3. استخدام في UI:
```dart
BlocProvider(
  create: (context) => getIt<ProductCubit>()..getProducts(),
  child: ProductPage(),
)
```

---

## 💡 Tips

1. **للـ Simple Features** → استخدم **Cubit**
2. **للـ Complex Features** → استخدم **BLoC**
3. **للـ Forms** → استخدم **Cubit** (أسهل)
4. **للـ Real-time** → استخدم **BLoC** (Streams)
5. **للـ Testing** → كلاهما سهل

---

**🎉 الآن أصبح لديك دعم كامل لـ Cubit Pattern!**

**Happy Coding! 💙**
