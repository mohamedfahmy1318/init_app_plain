/// Paginated Response from API
class PaginatedResponse<T> {
  final List<T> data;
  final int currentPage;
  final int totalPages;
  final int totalItems;
  final int itemsPerPage;
  final bool hasNextPage;
  final bool hasPreviousPage;

  const PaginatedResponse({
    required this.data,
    required this.currentPage,
    required this.totalPages,
    required this.totalItems,
    required this.itemsPerPage,
    required this.hasNextPage,
    required this.hasPreviousPage,
  });

  factory PaginatedResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    final data = (json['data'] as List)
        .map((item) => fromJsonT(item as Map<String, dynamic>))
        .toList();

    return PaginatedResponse<T>(
      data: data,
      currentPage: json['current_page'] ?? json['page'] ?? 1,
      totalPages: json['total_pages'] ?? json['last_page'] ?? 1,
      totalItems: json['total'] ?? json['total_items'] ?? 0,
      itemsPerPage: json['per_page'] ?? json['limit'] ?? 20,
      hasNextPage: json['has_next_page'] ?? 
          (json['current_page'] ?? 1) < (json['total_pages'] ?? json['last_page'] ?? 1),
      hasPreviousPage: json['has_previous_page'] ?? 
          (json['current_page'] ?? 1) > 1,
    );
  }

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T) toJsonT) {
    return {
      'data': data.map((item) => toJsonT(item)).toList(),
      'current_page': currentPage,
      'total_pages': totalPages,
      'total': totalItems,
      'per_page': itemsPerPage,
      'has_next_page': hasNextPage,
      'has_previous_page': hasPreviousPage,
    };
  }

  /// Get next page number
  int? get nextPage => hasNextPage ? currentPage + 1 : null;

  /// Get previous page number
  int? get previousPage => hasPreviousPage ? currentPage - 1 : null;

  /// Check if this is the first page
  bool get isFirstPage => currentPage == 1;

  /// Check if this is the last page
  bool get isLastPage => currentPage == totalPages;

  /// Check if response is empty
  bool get isEmpty => data.isEmpty;

  /// Check if response is not empty
  bool get isNotEmpty => data.isNotEmpty;
}

/// Pagination Parameters
class PaginationParams {
  final int page;
  final int limit;
  final String? sortBy;
  final String? sortOrder;
  final Map<String, dynamic>? filters;

  const PaginationParams({
    required this.page,
    this.limit = 20,
    this.sortBy,
    this.sortOrder = 'asc',
    this.filters,
  });

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      'page': page,
      'limit': limit,
    };

    if (sortBy != null) {
      json['sort_by'] = sortBy;
      json['sort_order'] = sortOrder;
    }

    if (filters != null) {
      json.addAll(filters!);
    }

    return json;
  }

  /// Create params for first page
  factory PaginationParams.firstPage({
    int limit = 20,
    String? sortBy,
    String? sortOrder,
    Map<String, dynamic>? filters,
  }) {
    return PaginationParams(
      page: 1,
      limit: limit,
      sortBy: sortBy,
      sortOrder: sortOrder,
      filters: filters,
    );
  }

  /// Create params for next page
  PaginationParams nextPage() {
    return PaginationParams(
      page: page + 1,
      limit: limit,
      sortBy: sortBy,
      sortOrder: sortOrder,
      filters: filters,
    );
  }

  /// Create params for previous page
  PaginationParams previousPage() {
    return PaginationParams(
      page: page > 1 ? page - 1 : 1,
      limit: limit,
      sortBy: sortBy,
      sortOrder: sortOrder,
      filters: filters,
    );
  }
}

/// Example Usage:
/// 
/// ```dart
/// // في الـ Repository
/// class ProductRepository extends BaseRepository {
///   Future<Either<Failure, PaginatedResponse<ProductEntity>>> getProducts(
///     PaginationParams params,
///   ) async {
///     return execute(
///       apiCall: () async {
///         final response = await _client.get(
///           '/products',
///           queryParameters: params.toJson(),
///         );
/// 
///         final paginatedResponse = PaginatedResponse<ProductModel>.fromJson(
///           response.data,
///           (json) => ProductModel.fromJson(json),
///         );
/// 
///         return PaginatedResponse<ProductEntity>(
///           data: paginatedResponse.data.map((m) => m.toEntity()).toList(),
///           currentPage: paginatedResponse.currentPage,
///           totalPages: paginatedResponse.totalPages,
///           totalItems: paginatedResponse.totalItems,
///           itemsPerPage: paginatedResponse.itemsPerPage,
///           hasNextPage: paginatedResponse.hasNextPage,
///           hasPreviousPage: paginatedResponse.hasPreviousPage,
///         );
///       },
///     );
///   }
/// }
/// 
/// // في الـ BLoC
/// class ProductBloc extends Bloc<BaseEvent, BaseState> {
///   List<ProductEntity> products = [];
///   int currentPage = 1;
///   bool hasMore = true;
/// 
///   Future<void> _onLoadProducts(
///     LoadProductsEvent event,
///     Emitter<BaseState> emit,
///   ) async {
///     if (!hasMore) return;
/// 
///     emit(const LoadingState());
/// 
///     final params = PaginationParams(
///       page: currentPage,
///       limit: 20,
///     );
/// 
///     final result = await getProductsUseCase(params);
/// 
///     result.fold(
///       (failure) => emit(ErrorState(failure.message)),
///       (response) {
///         products.addAll(response.data);
///         currentPage = response.nextPage ?? currentPage;
///         hasMore = response.hasNextPage;
///         emit(ProductsLoadedState(products));
///       },
///     );
///   }
/// }
/// ```
