import '../services/connectivity_service.dart';
import '../di/service_locator.dart';

/// Mixin للتحقق من الإنترنت قبل أي عملية
mixin NetworkChecker {
  final ConnectivityService _connectivity = getIt<ConnectivityService>();

  /// Check if device has internet connection
  Future<bool> get hasConnection async => await _connectivity.hasConnection();

  /// Check connection before executing action
  Future<T?> checkConnectionBefore<T>(
    Future<T> Function() action, {
    Function()? onNoConnection,
  }) async {
    if (await hasConnection) {
      return await action();
    } else {
      onNoConnection?.call();
      return null;
    }
  }
}

/// استخدام:
/// 
/// ```dart
/// class ProductRepository extends BaseRepository with NetworkChecker {
///   Future<Either<Failure, List<ProductEntity>>> getProducts() async {
///     // طريقة 1: التحقق اليدوي
///     if (!await hasConnection) {
///       return Left(NetworkFailure('لا يوجد اتصال بالإنترنت'));
///     }
/// 
///     return execute(
///       apiCall: () async {
///         final response = await _client.get('/products');
///         return parseProducts(response);
///       },
///     );
/// 
///     // طريقة 2: باستخدام checkConnectionBefore
///     return await checkConnectionBefore(
///       () => execute(
///         apiCall: () async {
///           final response = await _client.get('/products');
///           return parseProducts(response);
///         },
///       ),
///       onNoConnection: () {
///         return Left(NetworkFailure('لا يوجد اتصال بالإنترنت'));
///       },
///     ) ?? Left(NetworkFailure('لا يوجد اتصال بالإنترنت'));
///   }
/// }
/// ```
