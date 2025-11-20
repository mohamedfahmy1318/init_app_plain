import 'package:Bynona/core/constants/app_images.dart';
import 'package:Bynona/core/widgets/images/custom_assets_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Product Card Widget
class ProductCardWidget extends StatelessWidget {
  final ProductItemData product;

  const ProductCardWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: product.onTap,
      child: Container(
        decoration: BoxDecoration(
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
                padding: EdgeInsets.all(10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [_buildProductInfo(), _buildPriceAndCartButton()],
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
          height: 135.h,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.vertical(top: Radius.circular(15.r)),
          ),
          child: Center(child: CustomAssetsImage(assetPath: AppImages.nowImg)),
        ),

        // Discount Badge
        if (product.discountPercentage != null)
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
                'خصم ${product.discountPercentage}%',
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
            onTap: product.onFavoriteTap,
            child: Container(
              padding: EdgeInsets.all(6.w),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(
                product.isFavorite ? Icons.favorite : Icons.favorite_border,
                size: 18.sp,
                color: product.isFavorite ? Colors.red : Colors.grey[600],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProductInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Product Title
        Text(
          product.title,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            height: 1.3,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 4.h),

        // Product Description
        if (product.description != null)
          Text(
            product.description!,
            style: TextStyle(fontSize: 10.sp, color: Colors.grey[600]),
            textAlign: TextAlign.right,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
      ],
    );
  }

  Widget _buildPriceAndCartButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Current Price
        Text(
          '${product.price} جنيه',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),

        // Old Price (if discount exists)
        if (product.oldPrice != null)
          Text(
            '${product.oldPrice} جنيه',
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey,
              decoration: TextDecoration.lineThrough,
              decorationColor: Colors.red,
            ),
          ),

        SizedBox(height: 6.h),

        // Add to Cart Button
        GestureDetector(
          onTap: product.onAddToCart,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 8.h),
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(8.r),
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
                  'اضافة',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Product Item Data Model
class ProductItemData {
  final String id;
  final String title;
  final String? description;
  final double price;
  final double? oldPrice;
  final int? discountPercentage;
  final String? imageUrl;
  final bool isFavorite;
  final VoidCallback? onTap;
  final VoidCallback? onAddToCart;
  final VoidCallback? onFavoriteTap;

  ProductItemData({
    required this.id,
    required this.title,
    this.description,
    required this.price,
    this.oldPrice,
    this.discountPercentage,
    this.imageUrl,
    this.isFavorite = false,
    this.onTap,
    this.onAddToCart,
    this.onFavoriteTap,
  });
}
