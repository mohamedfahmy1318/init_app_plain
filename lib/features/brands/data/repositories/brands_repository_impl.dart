/// ========================================================
/// Brands Repository Implementation
/// ========================================================
/// بيجيب البيانات من الـ API أو الـ Cache
/// ========================================================

import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/errors/dio_error_handler.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/brand_entity.dart';
import '../../domain/repositories/brands_repository.dart';
import '../datasources/brands_local_datasource.dart';
import '../datasources/brands_remote_datasource.dart';

class BrandsRepositoryImpl implements BrandsRepository {
  final BrandsRemoteDataSource remoteDataSource;
  final BrandsLocalDataSource localDataSource;

  BrandsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<BrandEntity>>> getBrands({
    int page = 1,
    int limit = 40,
  }) async {
    try {
      // 💾 الصفحة الأولى: جرب الـ Cache الأول
      if (page == 1) {
        final cached = await localDataSource.getCachedBrands();
        if (cached != null && cached.isNotEmpty) {
          return Right(cached.map((m) => m.toEntity()).toList());
        }
      }
      // 📡 جلب من الـ API
      final response = await remoteDataSource.getBrands(
        page: page,
        limit: limit,
      );
      final brands = response.data.map((m) => m.toEntity()).toList();

      // 💾 حفظ الصفحة الأولى في الـ Cache
      if (page == 1) {
        unawaited(localDataSource.cacheBrands(response.data));
      }
      return Right(brands);
    } on DioException catch (e) {
      return Left(DioErrorHandler.handleDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

/// 📝 الشرح:
/// ---------
/// 1️⃣ لو page=1: اقرأ من Cache أولاً
/// 2️⃣ لو مافيش cache: اجلب من API
/// 3️⃣ احفظ الصفحة الأولى في Cache
/// 4️⃣ لو error: استخدم DioErrorHandler
///
/// ✨ بسيط وواضح!
