import 'package:Bynona/core/widgets/custom_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Search Bar Widget
class SearchBarWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final Function(String)? onSearch;
  final TextEditingController? controller;

  const SearchBarWidget({
    super.key,
    this.onTap,
    this.onSearch,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: onSearch != null
          ? CustomSearchBar(
              hint: 'البحث في Bynona',
              onSearch: onSearch!,
              controller: controller,
            )
          : GestureDetector(
              onTap: onTap,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(Icons.search, color: Colors.grey[800], size: 24.sp),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        'البحث في Bynona',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.grey[600],
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
