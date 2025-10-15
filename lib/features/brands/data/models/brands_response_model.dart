/// ========================================================
/// Brands Response Model - موديل الاستجابة الكاملة
/// ========================================================
/// بيمثل الـ Response الكاملة اللي جاية من الـ API
/// بتحتوي على metadata و data (الـ brands)
/// ========================================================

import 'brand_model.dart';

class BrandsResponseModel {
  final int results;
  final MetadataModel metadata;
  final List<BrandModel> data;

  const BrandsResponseModel({
    required this.results,
    required this.metadata,
    required this.data,
  });

  /// 📥 من JSON للـ Response Model
  factory BrandsResponseModel.fromJson(Map<String, dynamic> json) {
    return BrandsResponseModel(
      results: json['results'] as int,
      metadata: MetadataModel.fromJson(json['metadata'] as Map<String, dynamic>),
      data: (json['data'] as List<dynamic>)
          .map((e) => BrandModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

/// 📊 Metadata Model - معلومات الـ Pagination
class MetadataModel {
  final int currentPage;
  final int numberOfPages;
  final int limit;
  final int? nextPage;

  const MetadataModel({
    required this.currentPage,
    required this.numberOfPages,
    required this.limit,
    this.nextPage,
  });

  factory MetadataModel.fromJson(Map<String, dynamic> json) {
    return MetadataModel(
      currentPage: json['currentPage'] as int,
      numberOfPages: json['numberOfPages'] as int,
      limit: json['limit'] as int,
      nextPage: json['nextPage'] as int?,
    );
  }
}

/// 📝 شرح الـ Response Model:
/// -------------------------
/// 1. results: عدد النتائج الكلية
/// 2. metadata: معلومات الـ pagination (الصفحات)
/// 3. data: قائمة الـ brands
/// 
/// 🔍 مثال على الاستخدام:
/// ```dart
/// final response = BrandsResponseModel.fromJson(jsonData);
/// print(response.results); // 54
/// print(response.metadata.currentPage); // 1
/// print(response.data.length); // 40
/// ```
