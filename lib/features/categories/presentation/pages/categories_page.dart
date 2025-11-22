import 'package:Bynona/core/router/app_router.dart';
import 'package:Bynona/core/router/routes_name.dart';
import 'package:Bynona/features/categories/presentation/widgets/category_main_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          'الأقسام',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(top: 12.h),
            child: CategoryMainItem(
              onTap: () {
                // Handle category item tap
                AppRouter.push(context, RoutesName.categoryType);
              },
            ),
          );
        },
        itemCount: 10,
      ),
    );
  }
}
