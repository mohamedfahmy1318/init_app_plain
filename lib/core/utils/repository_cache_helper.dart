/// ========================================================
/// Repository Cache Helper
/// ========================================================
/// دوال مساعدة لإدارة الـ Cache في الـ Repositories
/// ========================================================

import 'dart:async';

import 'package:dartz/dartz.dart';
import '../errors/failures.dart';

/// Helper class for repository cache operations
class RepositoryCacheHelper {
  /// Try to get cached data, return null if not found or error
  static Future<T?> tryGetCache<T>({
    required Future<T?> Function() getCachedData,
  }) async {
    try {
      return await getCachedData();
    } catch (e) {
      return null;
    }
  }

  /// Save data to cache without waiting (fire and forget)
  static void trySaveCache<T>({
    required Future<void> Function() saveCacheData,
  }) {
    unawaited(saveCacheData());
  }

  /// Execute repository call with cache fallback on network error
  static Future<Either<Failure, T>> executeWithCacheFallback<T>({
    required Future<Either<Failure, T>> Function() apiCall,
    required Future<T?> Function() getCachedData,
    required bool isFirstPage,
  }) async {
    final result = await apiCall();

    // If success, return result
    if (result.isRight()) return result;

    // If error and first page, try cache
    if (isFirstPage) {
      final cached = await tryGetCache(getCachedData: getCachedData);
      if (cached != null) return Right(cached);
    }

    return result;
  }
}
