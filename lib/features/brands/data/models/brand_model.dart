/// ========================================================
/// Brand Model - موديل البراند (Data Layer)
/// ========================================================
/// الـ Model ده بيتعامل مع الـ JSON اللي جاي من الـ API
/// بيحول من JSON للـ Entity والعكس
/// موجود في الـ Data Layer فقط
/// يدعم Hive TypeAdapter للتخزين المحلي
/// ========================================================

import 'package:hive/hive.dart';
import '../../domain/entities/brand_entity.dart';

part 'brand_model.g.dart'; // هيتم إنشاؤه تلقائياً

@HiveType(typeId: 0) // رقم unique للـ Model
class BrandModel extends BrandEntity {
  @HiveField(0)
  @override
  final String id;

  @HiveField(1)
  @override
  final String name;

  @HiveField(2)
  @override
  final String slug;

  @HiveField(3)
  @override
  final String image;

  @HiveField(4)
  @override
  final DateTime createdAt;

  @HiveField(5)
  @override
  final DateTime updatedAt;

  const BrandModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  }) : super(
         id: id,
         name: name,
         slug: slug,
         image: image,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// 📥 من JSON للـ Model
  /// بنستخدمها لما نستقبل البيانات من الـ API
  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
      id: json['_id'] as String,
      name: json['name'] as String,
      slug: json['slug'] as String,
      image: json['image'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  /// 📤 من Model للـ JSON
  /// بنستخدمها لما نبعت بيانات للـ API (لو احتجنا)
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'slug': slug,
      'image': image,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  /// 🔄 من Model للـ Entity
  /// بنحول البيانات من الـ Data Layer للـ Domain Layer
  BrandEntity toEntity() {
    return BrandEntity(
      id: id,
      name: name,
      slug: slug,
      image: image,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  /// 📋 نسخ مع تعديل (Immutability Pattern)
  BrandModel copyWith({
    String? id,
    String? name,
    String? slug,
    String? image,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BrandModel(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      image: image ?? this.image,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

/// 📝 شرح الـ Model:
/// ----------------
/// 1. @HiveType(typeId: 0): تعريف الـ Model كـ Hive Type برقم unique
/// 2. @HiveField(x): تعريف كل property برقم unique
/// 3. part 'brand_model.g.dart': الملف المولد تلقائياً بالـ Adapter
/// 4. extends BrandEntity: الـ Model هو نوع من الـ Entity
/// 5. fromJson: بيحول الـ JSON اللي جاي من API لكائن BrandModel
/// 6. toJson: بيحول الكائن لـ JSON (لو هنبعته للـ API)
/// 7. toEntity: بيحول الـ Model للـ Entity النظيف (Domain Layer)
///
/// ⚠️ ملاحظة:
/// - الـ "_id" في الـ JSON بيتحول لـ "id" في الكود
/// - DateTime.parse() بيحول الـ String للـ DateTime object
/// - TypeAdapter يخلي التخزين أسرع وأقل في المساحة
///
/// 🔧 لتوليد الـ Adapter:
/// flutter packages pub run build_runner build --delete-conflicting-outputs
