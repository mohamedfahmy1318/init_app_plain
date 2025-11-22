import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'product_card_widget.dart';

class ProductsSectionWidget extends StatelessWidget {
  final String title;
  final VoidCallback? onViewAllPressed;

  const ProductsSectionWidget({
    super.key,
    this.title = 'وصل حديثاً',
    this.onViewAllPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Section Header
        _buildSectionHeader(context),
        SizedBox(height: 9.h),

        // Products Horizontal List
        SizedBox(
          height: 330.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            itemCount: 5,
            itemBuilder: (context, index) {
              return Container(
                width: 180.w,
                margin: EdgeInsets.only(left: 12.w),
                child: ProductCardWidget(),
              );
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
          // Title (على اليمين)
          Flexible(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 17.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(width: 8.w),

          // View All Button (على الشمال)
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
                      fontSize: 14.sp,
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
