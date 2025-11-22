import 'package:Bynona/core/constants/app_images.dart';
import 'package:Bynona/core/widgets/images/custom_assets_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Product Card Widget
class ProductCardWidget extends StatelessWidget {
  const ProductCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Product Image with Discount Badge
            _buildProductImage(),

            // Product Details
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(6.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Product Title
                    Text(
                      'iPhone 15 Pro Max',
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        height: 1.0,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    SizedBox(height: 2.h),

                    // Product Description
                    Expanded(
                      child: Text(
                        'شاشة: OLED مقاس 6.1 بوصة • الكاميرا: مزدوجة 12 ميجابكسل',
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: Colors.grey[600],
                          height: 1.1,
                        ),
                        textAlign: TextAlign.right,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    // Price and Button Section
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Current Price
                        Text(
                          '60,000 جنيه',
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            height: 1.0,
                          ),
                        ),
                        SizedBox(height: 3.h),
                        // Old Price (if discount exists)
                        Text(
                          '70,000 جنيه',
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                            decorationColor: Colors.red,
                            height: 1.0,
                          ),
                        ),

                        SizedBox(height: 5.h),

                        // Add to Cart Button
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: 5.h),
                            decoration: BoxDecoration(
                              color: Colors.grey[800],
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.shopping_cart_outlined,
                                  size: 14.sp,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 6.w),
                                Text(
                                  'اضافة للعربة',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductImage() {
    return Stack(
      children: [
        Container(
          height: 130.h,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.vertical(top: Radius.circular(15.r)),
          ),
          child: Center(child: CustomAssetsImage(assetPath: AppImages.iphone)),
        ),

        // Discount Badge
        Positioned(
          top: 8.h,
          right: 4.w,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 2.h),
            decoration: BoxDecoration(
              color: const Color(0xFFFDD835),
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Text(
              'خصم 10%',
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),

        // Favorite Icon
        Positioned(
          top: 8.h,
          left: 8.w,
          child: GestureDetector(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.all(6.w),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.favorite_border,
                size: 18.sp,
                color: Colors.grey[600],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
