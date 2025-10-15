import 'package:dartz/dartz.dart';
import '../errors/failures.dart';

/// Base UseCase Pattern
/// جميع الـ UseCases يجب أن ترث من هذا الـ Class
abstract class BaseUseCase<Type, Params> {
  /// Execute the use case
  Future<Either<Failure, Type>> call(Params params);
}

/// UseCase without parameters
abstract class NoParamsUseCase<Type> {
  Future<Either<Failure, Type>> call();
}

/// UseCase for stream results
abstract class StreamUseCase<Type, Params> {
  Stream<Either<Failure, Type>> call(Params params);
}

/// No Parameters class
class NoParams {
  const NoParams();
}

/// Example UseCase Implementation
/// 
/// ```dart
/// class GetProductsUseCase extends BaseUseCase<List<ProductEntity>, GetProductsParams> {
///   final ProductRepository repository;
/// 
///   GetProductsUseCase(this.repository);
/// 
///   @override
///   Future<Either<Failure, List<ProductEntity>>> call(GetProductsParams params) async {
///     return await repository.getProducts(
///       page: params.page,
///       limit: params.limit,
///     );
///   }
/// }
/// 
/// class GetProductsParams {
///   final int page;
///   final int limit;
/// 
///   GetProductsParams({required this.page, required this.limit});
/// }
/// ```
/// 
/// Example without params:
/// ```dart
/// class GetCurrentUserUseCase extends NoParamsUseCase<UserEntity> {
///   final AuthRepository repository;
/// 
///   GetCurrentUserUseCase(this.repository);
/// 
///   @override
///   Future<Either<Failure, UserEntity>> call() async {
///     return await repository.getCurrentUser();
///   }
/// }
/// ```
