import 'package:dartz/dartz.dart';
import '../errors/failures.dart';
import '../network/api_exceptions.dart';
import '../services/connectivity_service.dart';
import '../di/service_locator.dart';

/// Base Repository Pattern
/// جميع الـ Repositories يجب أن ترث من هذا الـ Class
abstract class BaseRepository {
  final ConnectivityService _connectivity = getIt<ConnectivityService>();

  /// Execute API call with error handling
  Future<Either<Failure, T>> execute<T>({
    required Future<T> Function() apiCall,
  }) async {
    // Check internet connection
    if (!await _connectivity.hasConnection()) {
      return Left(NetworkFailure('لا يوجد اتصال بالإنترنت'));
    }

    try {
      final result = await apiCall();
      return Right(result);
    } on ApiException catch (e) {
      return Left(_handleApiException(e));
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  /// Execute local operation (Database, Cache, etc.)
  Future<Either<Failure, T>> executeLocal<T>({
    required Future<T> Function() operation,
  }) async {
    try {
      final result = await operation();
      return Right(result);
    } on Exception catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  /// Handle API exceptions
  Failure _handleApiException(ApiException exception) {
    if (exception is BadRequestException) {
      return ServerFailure(exception.message);
    } else if (exception is UnauthorizedException) {
      return AuthFailure(exception.message);
    } else if (exception is ForbiddenException) {
      return AuthFailure(exception.message);
    } else if (exception is NotFoundException) {
      return ServerFailure(exception.message);
    } else if (exception is TimeoutException) {
      return NetworkFailure('انتهت مهلة الاتصال');
    } else if (exception is NoInternetException) {
      return NetworkFailure('لا يوجد اتصال بالإنترنت');
    } else {
      return ServerFailure(exception.message);
    }
  }
}

/// Example Repository Implementation
/// مثال على كيفية استخدام BaseRepository
/// 
/// ```dart
/// class ProductRepository extends BaseRepository {
///   final DioClient _client = getIt<DioClient>();
/// 
///   Future<Either<Failure, List<ProductEntity>>> getProducts() async {
///     return execute(
///       apiCall: () async {
///         final response = await _client.get('/products');
///         final products = (response.data as List)
///             .map((json) => ProductModel.fromJson(json))
///             .map((model) => model.toEntity())
///             .toList();
///         return products;
///       },
///     );
///   }
/// 
///   Future<Either<Failure, ProductEntity>> getProductById(int id) async {
///     return execute(
///       apiCall: () async {
///         final response = await _client.get('/products/$id');
///         final model = ProductModel.fromJson(response.data);
///         return model.toEntity();
///       },
///     );
///   }
/// 
///   Future<Either<Failure, List<ProductEntity>>> getCachedProducts() async {
///     return executeLocal(
///       operation: () async {
///         // Get from cache or local DB
///         final cached = await cache.get('products');
///         return cached;
///       },
///     );
///   }
/// }
/// ```
