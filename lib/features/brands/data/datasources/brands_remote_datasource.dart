/// ========================================================
/// Brands Remote DataSource
/// ========================================================
/// مسؤول عن التواصل مع الـ API وجلب البيانات
/// بيستخدم Dio للـ HTTP requests
/// ========================================================

import '../../../../core/network/dio_client.dart';
import '../models/brands_response_model.dart';

/// 🎯 Abstract Class (Contract)
/// بيحدد العمليات اللي المفروض الـ DataSource يعملها
abstract class BrandsRemoteDataSource {
  /// جلب جميع البراندات
  Future<BrandsResponseModel> getBrands({int page = 1, int limit = 40});
}

/// 🔧 Implementation
/// التطبيق الفعلي للـ DataSource
class BrandsRemoteDataSourceImpl implements BrandsRemoteDataSource {
  final DioClient dioClient;

  BrandsRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<BrandsResponseModel> getBrands({int page = 1, int limit = 40}) async {
    try {
      // 📡 استدعاء الـ API
      final response = await dioClient.get(
        '/brands',
        queryParameters: {
          'page': page,
          'limit': limit,
        },
      );

      // ✅ تحويل الـ Response للـ Model
      return BrandsResponseModel.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      // ❌ إعادة رمي الخطأ للـ Repository
      rethrow;
    }
  }
}

/// 📝 شرح الـ DataSource:
/// ---------------------
/// 1. Abstract Class: بيعمل Contract (عقد) للـ implementation
/// 2. DioClient: بنستخدم الـ Dio من الـ Core للـ HTTP requests
/// 3. getBrands(): بتجيب البراندات من الـ API
/// 4. queryParameters: بنبعت page و limit كـ query params
/// 5. fromJson: بنحول الـ response لـ BrandsResponseModel
/// 
/// 🔍 مثال على الـ Request:
/// GET /brands?page=1&limit=40
/// 
/// ⚠️ ملاحظة:
/// الـ Error Handling بيتعمل في الـ Repository
/// هنا بنعمل rethrow للـ exception
