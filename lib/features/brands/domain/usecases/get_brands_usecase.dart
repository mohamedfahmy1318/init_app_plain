/// ========================================================
/// Get Brands UseCase
/// ========================================================
/// بيجيب قائمة البراندات من الـ Repository
/// ========================================================

import 'package:dartz/dartz.dart';
import '../../../../core/base/base_usecase.dart';
import '../../../../core/errors/failures.dart';
import '../entities/brand_entity.dart';
import '../repositories/brands_repository.dart';

/// 📦 Parameters للـ UseCase
class GetBrandsParams {
  final int page;
  final int limit;

  const GetBrandsParams({this.page = 1, this.limit = 40});
}

/// 🎯 UseCase Implementation
class GetBrandsUseCase extends BaseUseCase<List<BrandEntity>, GetBrandsParams> {
  final BrandsRepository repository;

  GetBrandsUseCase(this.repository);

  @override
  Future<Either<Failure, List<BrandEntity>>> call(
    GetBrandsParams params,
  ) async {
    return await repository.getBrands(page: params.page, limit: params.limit);
  }
}
