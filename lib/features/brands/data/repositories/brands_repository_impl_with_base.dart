/// ========================================================
/// Brands Repository Implementation (Using BaseRepository)
/// ========================================================
/// نسخة تجريبية بتستخدم BaseRepository
/// للمقارنة مع النسخة العادية
/// ========================================================

import 'dart:async';

import 'package:dartz/dartz.dart';
import '../../../../core/base/base_repository.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/brand_entity.dart';
import '../../domain/repositories/brands_repository.dart';
import '../datasources/brands_local_datasource.dart';
import '../datasources/brands_remote_datasource.dart';

class BrandsRepositoryImplWithBase extends BaseRepository
    implements BrandsRepository {
  final BrandsRemoteDataSource remoteDataSource;
  final BrandsLocalDataSource localDataSource;

  BrandsRepositoryImplWithBase({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<BrandEntity>>> getBrands({
    int page = 1,
    int limit = 40,
  }) async {
    // 💾 جرب الـ Cache أولاً (للصفحة الأولى)
    if (page == 1) {
      final cachedResult = await executeLocal(
        operation: () async {
          final cached = await localDataSource.getCachedBrands();
          if (cached != null && cached.isNotEmpty) {
            return cached.map((m) => m.toEntity()).toList();
          }
          throw Exception('No cache found');
        },
      );

      // لو لقينا cache، نرجعه
      if (cachedResult.isRight()) {
        return cachedResult;
      }
    }

    // 📡 جلب من الـ API
    final result = await execute<List<BrandEntity>>(
      apiCall: () async {
        final response = await remoteDataSource.getBrands(
          page: page,
          limit: limit,
        );
        final brands = response.data.map((m) => m.toEntity()).toList();

        // 💾 حفظ الصفحة الأولى في الـ Cache
        if (page == 1) {
          unawaited(localDataSource.cacheBrands(response.data));
        }

        return brands;
      },
    );

    return result;
  }
}

/// 📝 الفرق بين النسختين:
/// ----------------------
/// 
/// ✅ **النسخة العادية** (brands_repository_impl.dart):
/// ```dart
/// try {
///   final cached = await localDataSource.getCachedBrands();
///   if (cached != null) return Right(cached);
///   
///   final response = await remoteDataSource.getBrands();
///   return Right(brands);
/// } on DioException catch (e) {
///   return Left(DioErrorHandler.handleDioError(e));
/// }
/// ```
/// 
/// ✅ **النسخة مع BaseRepository** (هذا الملف):
/// ```dart
/// final cachedResult = await executeLocal(
///   operation: () async { ... },
/// );
/// 
/// final result = await execute(
///   apiCall: () async { ... },
/// );
/// ```
/// 
/// 🎯 **المقارنة:**
/// 
/// | Feature | عادي | مع BaseRepository |
/// |---------|------|-------------------|
/// | عدد الأسطر | 30 سطر | 35 سطر |
/// | الوضوح | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ |
/// | البساطة | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ |
/// | إعادة الاستخدام | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
/// | Error Handling | يدوي | تلقائي |
/// | Internet Check | يدوي | تلقائي |
/// 
/// 💡 **متى تستخدم BaseRepository:**
/// - لو عندك logic معقد مشترك بين repositories
/// - لو عايز automatic internet check
/// - لو عايز consistent error handling
/// 
/// 💡 **متى تستخدم النسخة العادية:**
/// - لو الكود بسيط (زي حالتنا)
/// - لو عايز تتحكم في كل حاجة
/// - لو عايز الكود يكون واضح وlinear
/// 
/// 🎯 **في حالة البراندات:**
/// النسخة العادية أفضل لأن الكود بسيط وواضح!
