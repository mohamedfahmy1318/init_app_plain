import 'package:Bynona/core/router/app_router.dart';
import 'package:Bynona/core/router/routes_name.dart';
import 'package:Bynona/features/categories/presentation/widgets/category_type_item.dart';
import 'package:flutter/material.dart';

class CategoryType extends StatelessWidget {
  const CategoryType({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('موبايلات')),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 3 / 4,
        ),
        itemBuilder: (context, index) {
          return CategoryTypeItem(
            ontap: () {
              // Handle category type item tap
              AppRouter.push(context, RoutesName.categoryDetails);
            },
          );
        },
        itemCount: 15,
      ),
    );
  }
}
