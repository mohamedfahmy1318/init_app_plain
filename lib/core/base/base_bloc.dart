import 'package:equatable/equatable.dart';

/// Base State for all BLoCs
abstract class BaseState extends Equatable {
  const BaseState();

  @override
  List<Object?> get props => [];
}

/// Initial State
class InitialState extends BaseState {
  const InitialState();
}

/// Loading State
class LoadingState extends BaseState {
  const LoadingState();
}

/// Success State with data
class SuccessState<T> extends BaseState {
  final T data;
  final String? message;

  const SuccessState(this.data, {this.message});

  @override
  List<Object?> get props => [data, message];
}

/// Error State
class ErrorState extends BaseState {
  final String message;

  const ErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

/// Empty State (no data found)
class EmptyState extends BaseState {
  final String? message;

  const EmptyState({this.message});

  @override
  List<Object?> get props => [message];
}

/// Base Event for all BLoCs
abstract class BaseEvent extends Equatable {
  const BaseEvent();

  @override
  List<Object?> get props => [];
}

/// Example BLoC Implementation
/// 
/// ```dart
/// // Events
/// class GetProductsEvent extends BaseEvent {
///   final int page;
///   const GetProductsEvent({required this.page});
///   @override
///   List<Object?> get props => [page];
/// }
/// 
/// class GetProductByIdEvent extends BaseEvent {
///   final int id;
///   const GetProductByIdEvent(this.id);
///   @override
///   List<Object?> get props => [id];
/// }
/// 
/// // States
/// class ProductsLoadedState extends SuccessState<List<ProductEntity>> {
///   const ProductsLoadedState(List<ProductEntity> products) : super(products);
/// }
/// 
/// class ProductLoadedState extends SuccessState<ProductEntity> {
///   const ProductLoadedState(ProductEntity product) : super(product);
/// }
/// 
/// // BLoC
/// class ProductBloc extends Bloc<BaseEvent, BaseState> {
///   final GetProductsUseCase getProductsUseCase;
///   final GetProductByIdUseCase getProductByIdUseCase;
/// 
///   ProductBloc({
///     required this.getProductsUseCase,
///     required this.getProductByIdUseCase,
///   }) : super(const InitialState()) {
///     on<GetProductsEvent>(_onGetProducts);
///     on<GetProductByIdEvent>(_onGetProductById);
///   }
/// 
///   Future<void> _onGetProducts(
///     GetProductsEvent event,
///     Emitter<BaseState> emit,
///   ) async {
///     emit(const LoadingState());
/// 
///     final result = await getProductsUseCase(
///       GetProductsParams(page: event.page, limit: 20),
///     );
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
/// 
///   Future<void> _onGetProductById(
///     GetProductByIdEvent event,
///     Emitter<BaseState> emit,
///   ) async {
///     emit(const LoadingState());
/// 
///     final result = await getProductByIdUseCase(
///       GetProductByIdParams(id: event.id),
///     );
/// 
///     result.fold(
///       (failure) => emit(ErrorState(failure.message)),
///       (product) => emit(ProductLoadedState(product)),
///     );
///   }
/// }
/// ```
