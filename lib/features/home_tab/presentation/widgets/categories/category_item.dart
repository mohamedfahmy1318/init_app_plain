import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryItem extends StatelessWidget {
  final CategoryItemData category;

  const CategoryItem({required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 90.w,
        margin: EdgeInsets.symmetric(horizontal: 6.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Category Image
            SizedBox(height: 80.h, width: 80.w, child: category.img),
            SizedBox(height: 6.h),
            Text(
              category.title,
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.black87,
                height: 1.3,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

/// Category Item Data Model
/// نموذج البيانات للقسم - جاهز للربط مع الـ API
class CategoryItemData {
  final String id;
  final String title;
  final Widget img;

  CategoryItemData({required this.id, required this.title, required this.img});
}
