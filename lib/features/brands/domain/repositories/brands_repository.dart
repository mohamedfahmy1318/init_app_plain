/// ========================================================
/// Brands Repository Interface (Domain Layer)
/// ========================================================
/// العقد (Contract) اللي بيحدد العمليات المطلوبة
/// موجود في الـ Domain Layer
/// مبيعرفش حاجة عن الـ implementation أو الـ API
/// ========================================================

import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/brand_entity.dart';

abstract class BrandsRepository {
  /// جلب جميع البراندات
  /// 
  /// Returns:
  /// - Left(Failure): في حالة حدوث خطأ
  /// - Right(List<BrandEntity>): في حالة النجاح
  Future<Either<Failure, List<BrandEntity>>> getBrands({
    int page = 1,
    int limit = 40,
  });
}

/// 📝 شرح الـ Repository Interface:
/// ------------------------------
/// 1. abstract class: مجرد عقد (Contract) بدون تطبيق
/// 2. Either<Failure, List<BrandEntity>>: 
///    - Left: في حالة الخطأ بنرجع Failure
///    - Right: في حالة النجاح بنرجع List<BrandEntity>
/// 3. getBrands(): الوظيفة المطلوبة من أي repository
/// 
/// ⚠️ ملاحظات:
/// - الـ Repository في الـ Domain مبيعرفش حاجة عن HTTP أو Dio
/// - الـ Implementation هتكون في الـ Data Layer
/// - بنستخدم Either من dartz package لـ functional programming
