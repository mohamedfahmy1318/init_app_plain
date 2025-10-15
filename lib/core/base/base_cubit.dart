import 'package:flutter_bloc/flutter_bloc.dart';
import 'base_bloc.dart';

/// Base Cubit for all Cubits using BaseState
/// 
/// Example:
/// ```dart
/// class ProductCubit extends BaseCubit {
///   final GetProductsUseCase getProductsUseCase;
/// 
///   ProductCubit({required this.getProductsUseCase}) : super(const InitialState());
/// 
///   Future<void> getProducts() async {
///     emit(const LoadingState());
///     
///     final result = await getProductsUseCase();
///     
///     result.fold(
///       (failure) => emit(ErrorState(failure.message)),
///       (products) {
///         if (products.isEmpty) {
///           emit(const EmptyState(message: 'لا توجد منتجات'));
///         } else {
///           emit(ProductsLoadedState(products));
///         }
///       },
///     );
///   }
/// }
/// ```
abstract class BaseCubit extends Cubit<BaseState> {
  BaseCubit(super.initialState);

  /// Emit loading state
  void emitLoading() {
    emit(const LoadingState());
  }

  /// Emit success state with data
  void emitSuccess<T>(T data, {String? message}) {
    emit(SuccessState<T>(data, message: message));
  }

  /// Emit error state
  void emitError(String message) {
    emit(ErrorState(message));
  }

  /// Emit empty state
  void emitEmpty({String? message}) {
    emit(EmptyState(message: message));
  }

  /// Emit initial state
  void emitInitial() {
    emit(const InitialState());
  }
}

/// Example Implementation with Pagination
/// 
/// ```dart
/// class ProductCubit extends BaseCubit {
///   final GetProductsUseCase getProductsUseCase;
///   final GetProductByIdUseCase getProductByIdUseCase;
///   
///   ProductCubit({
///     required this.getProductsUseCase,
///     required this.getProductByIdUseCase,
///   }) : super(const InitialState());
/// 
///   // State variables
///   List<ProductEntity> products = [];
///   int currentPage = 1;
///   bool hasMore = true;
///   bool isLoadingMore = false;
/// 
///   // Get all products
///   Future<void> getProducts({bool refresh = false}) async {
///     if (refresh) {
///       products.clear();
///       currentPage = 1;
///       hasMore = true;
///     }
///     
///     emitLoading();
///     
///     final result = await getProductsUseCase(
///       PaginationParams(page: currentPage, limit: 20),
///     );
///     
///     result.fold(
///       (failure) => emitError(failure.message),
///       (response) {
///         products.addAll(response.data);
///         currentPage = response.nextPage ?? currentPage;
///         hasMore = response.hasNextPage;
///         
///         if (products.isEmpty) {
///           emitEmpty(message: 'لا توجد منتجات');
///         } else {
///           emit(ProductsLoadedState(products));
///         }
///       },
///     );
///   }
/// 
///   // Load more (pagination)
///   Future<void> loadMore() async {
///     if (!hasMore || isLoadingMore) return;
///     
///     isLoadingMore = true;
///     // Keep current state but add loading indicator
///     
///     final result = await getProductsUseCase(
///       PaginationParams(page: currentPage, limit: 20),
///     );
///     
///     result.fold(
///       (failure) {
///         isLoadingMore = false;
///         // Show snackbar or toast
///       },
///       (response) {
///         products.addAll(response.data);
///         currentPage = response.nextPage ?? currentPage;
///         hasMore = response.hasNextPage;
///         isLoadingMore = false;
///         emit(ProductsLoadedState(products));
///       },
///     );
///   }
/// 
///   // Get product by ID
///   Future<void> getProductById(int id) async {
///     emitLoading();
///     
///     final result = await getProductByIdUseCase(id);
///     
///     result.fold(
///       (failure) => emitError(failure.message),
///       (product) => emit(ProductLoadedState(product)),
///     );
///   }
/// 
///   // Search products
///   Future<void> searchProducts(String query) async {
///     if (query.isEmpty) {
///       await getProducts(refresh: true);
///       return;
///     }
///     
///     emitLoading();
///     
///     final result = await searchProductsUseCase(query);
///     
///     result.fold(
///       (failure) => emitError(failure.message),
///       (products) {
///         if (products.isEmpty) {
///           emitEmpty(message: 'لا توجد نتائج للبحث');
///         } else {
///           emit(ProductsLoadedState(products));
///         }
///       },
///     );
///   }
/// }
/// 
/// // Custom States (optional)
/// class ProductsLoadedState extends SuccessState<List<ProductEntity>> {
///   const ProductsLoadedState(List<ProductEntity> products) : super(products);
/// }
/// 
/// class ProductLoadedState extends SuccessState<ProductEntity> {
///   const ProductLoadedState(ProductEntity product) : super(product);
/// }
/// ```
/// 
/// Usage in UI:
/// ```dart
/// class ProductPage extends StatelessWidget {
///   @override
///   Widget build(BuildContext context) {
///     return BlocProvider(
///       create: (context) => getIt<ProductCubit>()..getProducts(),
///       child: Scaffold(
///         appBar: AppBar(title: const Text('Products')),
///         body: BlocBuilder<ProductCubit, BaseState>(
///           builder: (context, state) {
///             final cubit = context.read<ProductCubit>();
///             
///             if (state is LoadingState) {
///               return const Center(child: CircularProgressIndicator());
///             }
///             
///             if (state is ErrorState) {
///               return Center(child: Text(state.message));
///             }
///             
///             if (state is EmptyState) {
///               return Center(child: Text(state.message ?? 'No data'));
///             }
///             
///             if (state is ProductsLoadedState) {
///               return RefreshIndicator(
///                 onRefresh: () => cubit.getProducts(refresh: true),
///                 child: ListView.builder(
///                   itemCount: state.data.length + (cubit.hasMore ? 1 : 0),
///                   itemBuilder: (context, index) {
///                     if (index == state.data.length) {
///                       // Load more indicator
///                       cubit.loadMore();
///                       return const Center(child: CircularProgressIndicator());
///                     }
///                     
///                     final product = state.data[index];
///                     return ListTile(
///                       title: Text(product.name),
///                       onTap: () => cubit.getProductById(product.id),
///                     );
///                   },
///                 ),
///               );
///             }
///             
///             return const SizedBox.shrink();
///           },
///         ),
///         floatingActionButton: FloatingActionButton(
///           onPressed: () => context.read<ProductCubit>().getProducts(refresh: true),
///           child: const Icon(Icons.refresh),
///         ),
///       ),
///     );
///   }
/// }
/// ```
