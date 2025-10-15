/// ========================================================
/// Brand Entity - كيان البراند (Domain Layer)
/// ========================================================
/// الـ Entity ده بيمثل البيانات الأساسية للبراند
/// موجود في الـ Domain Layer (Business Logic)
/// مبيعرفش حاجة عن الـ API أو الـ JSON
/// ========================================================

import 'package:equatable/equatable.dart';

class BrandEntity extends Equatable {
  final String id;
  final String name;
  final String slug;
  final String image;
  final DateTime createdAt;
  final DateTime updatedAt;

  const BrandEntity({
    required this.id,
    required this.name,
    required this.slug,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [id, name, slug, image, createdAt, updatedAt];
}

/// �📝 شرح الـ Entity:
/// ----------------
/// 1. extends Equatable: علشان نقدر نقارن بين كائنين BrandEntity
/// 2. id: الـ ID الفريد للبراند
/// 3. name: اسم البراند (مثال: "Samsung", "Apple")
/// 4. slug: URL-friendly version من الاسم (مثال: "samsung")
/// 5. image: رابط صورة البراند
/// 6. createdAt & updatedAt: تواريخ الإنشاء والتحديث
/// 7. props: بيحدد الـ properties اللي هنقارن بيها
///
/// ⚠️ ملاحظة مهمة:
/// الـ Entity مش بيعرف حاجة عن JSON أو API
/// ده شغل الـ Model (Data Layer)
