import 'package:Bynona/core/widgets/shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Shimmer Loaders for Home Tab Widgets
/// يستخدم للعرض أثناء تحميل البيانات من الـ API

class HomeShimmerLoaders {
  /// Shimmer للبانرات
  static Widget bannerShimmer() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 6.w),
      child: ShimmerShapes.rectangular(
        width: double.infinity,
        height: 180.h,
        borderRadius: 16,
      ),
    );
  }

  /// Shimmer للأقسام
  static Widget categoriesShimmer() {
    return SizedBox(
      height: 110.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        reverse: true,
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        itemCount: 4,
        itemBuilder: (context, index) {
          return Container(
            width: 90.w,
            margin: EdgeInsets.symmetric(horizontal: 6.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ShimmerShapes.circular(size: 70),
                SizedBox(height: 6.h),
                ShimmerShapes.textLine(width: 80, height: 12),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Shimmer للمنتجات (horizontal)
  static Widget productsHorizontalShimmer() {
    return SizedBox(
      height: 320.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        reverse: true,
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
            width: 180.w,
            margin: EdgeInsets.only(left: 12.w),
            child: _productCardShimmer(),
          );
        },
      ),
    );
  }

  /// Shimmer لبطاقة المنتج
  static Widget _productCardShimmer() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Image shimmer
          ShimmerShapes.rectangular(
            width: double.infinity,
            height: 130.h,
            borderRadius: 12,
          ),

          Expanded(
            child: Padding(
              padding: EdgeInsets.all(10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ShimmerShapes.textLine(
                        width: double.infinity,
                        height: 12,
                      ),
                      SizedBox(height: 4.h),
                      ShimmerShapes.textLine(width: 100, height: 10),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ShimmerShapes.textLine(width: 80, height: 14),
                      SizedBox(height: 4.h),
                      ShimmerShapes.textLine(width: 60, height: 11),
                      SizedBox(height: 6.h),
                      ShimmerShapes.rectangular(
                        width: double.infinity,
                        height: 32.h,
                        borderRadius: 8,
                      ),
                    ],
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
