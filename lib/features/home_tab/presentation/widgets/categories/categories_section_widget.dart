import 'package:Bynona/core/constants/app_images.dart';
import 'package:Bynona/core/widgets/images/custom_assets_image.dart';
import 'package:Bynona/features/home_tab/presentation/widgets/categories/category_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Categories Section Widget
class CategoriesSectionWidget extends StatelessWidget {
  final List<CategoryItemData>? categories;
  final VoidCallback? onViewAllPressed;

  const CategoriesSectionWidget({
    super.key,
    this.categories,
    this.onViewAllPressed,
  });

  @override
  Widget build(BuildContext context) {
    // Categories افتراضية - سيتم استبدالها بالبيانات من الـ API
    final defaultCategories = [
      CategoryItemData(
        id: '1',
        title: 'الموبايلات',
        img: CustomCircularAssetsImage(assetPath: AppImages.category1),
      ),
      CategoryItemData(
        id: '2',
        title: 'اكسسوارات الموبايل',
        img: CustomCircularAssetsImage(assetPath: AppImages.category2),
      ),
      CategoryItemData(
        id: '3',
        title: ' ساعات ذكية',
        img: CustomCircularAssetsImage(assetPath: AppImages.category3),
      ),
      CategoryItemData(
        id: '4',
        title: 'الآلكترويات',
        img: CustomCircularAssetsImage(assetPath: AppImages.category4),
      ),
    ];

    final displayCategories = categories ?? defaultCategories;

    return Column(
      children: [
        // Section Header
        _buildSectionHeader(context),
        SizedBox(height: 16.h),

        // Categories Row
        SizedBox(
          height: 110.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            itemCount: displayCategories.length,
            itemBuilder: (context, index) {
              return CategoryItem(category: displayCategories[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'الأقسام الرئيسية',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          GestureDetector(
            onTap: onViewAllPressed,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: const Color(0xFFFDD835),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                children: [
                  Text(
                    'عرض الكل',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 14.sp,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Category Item Widget
