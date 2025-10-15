/// ========================================================
/// Brand Card Widget - Custom Widget
/// ========================================================
/// Widget مخصص لعرض بطاقة البراند
/// بيستخدم الـ Core Widgets (CachedImageWidget, CustomCard)
/// ========================================================

import 'package:flutter/material.dart';
import '../../../../core/widgets/cached_image_widget.dart';
import '../../../../core/widgets/app_widgets.dart';
import '../../domain/entities/brand_entity.dart';

class BrandCard extends StatelessWidget {
  final BrandEntity brand;
  final VoidCallback? onTap;

  const BrandCard({
    super.key,
    required this.brand,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      onTap: onTap,
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 🖼️ صورة البراند
          Expanded(
            child: CachedImageWidget(
              imageUrl: brand.image,
              borderRadius: BorderRadius.circular(8),
              fit: BoxFit.contain,
            ),
          ),
          
          const SizedBox(height: 8),
          
          // 📝 اسم البراند
          Text(
            brand.name,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

/// 📝 شرح الـ Brand Card:
/// ---------------------
/// 1. CustomCard: من الـ core/widgets/app_widgets.dart
/// 2. CachedImageWidget: من الـ core/widgets/cached_image_widget.dart
///    - بتعمل cache للصور (بتحملها مرة واحدة وتحفظها)
///    - بتعرض placeholder أثناء التحميل
/// 3. brand: الـ Entity اللي بنعرض بياناته
/// 4. onTap: callback لما المستخدم يضغط على الكارد
/// 
/// 🎨 التصميم:
/// - Column: صورة فوق و اسم تحت
/// - Expanded: علشان الصورة تاخد المساحة المتاحة
/// - BorderRadius: حواف مستديرة للصورة
/// - maxLines: 1: سطر واحد فقط للاسم
/// - overflow: TextOverflow.ellipsis: إذا الاسم طويل يظهر "..."
/// 
/// ⚠️ ملاحظات:
/// - بنستخدم Theme.of(context) للألوان والـ styles
/// - كل الـ widgets من الـ Core (reusable)
/// - Clean & Simple Design
