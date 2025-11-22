import 'package:Bynona/core/config/app_text_styles.dart';
import 'package:Bynona/core/utils/utils.dart';
import 'package:Bynona/features/categories/presentation/widgets/details/custom_header_details.dart';
import 'package:Bynona/features/home_tab/presentation/widgets/product_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryDetails extends StatelessWidget {
  const CategoryDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('الموبايلات ')),
      body: Column(
        children: [
          CustomHeaderDerails(),
          SizedBox(height: 16.h),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) => const CustomTypeGrid(),
              itemCount: 7,
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTypeGrid extends StatelessWidget {
  const CustomTypeGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16.h),
        Text(' Apples', style: AppTextStyles.font20BlackSemiBold),
        SizedBox(height: 16.h),
        SizedBox(
          height: 250.h,
          child: GridView.builder(
            scrollDirection: Axis.horizontal,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
            ),
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: ProductCardWidget(),
              );
            },
            itemCount: 7,
          ),
        ),
      ],
    ).paddingR(horizontal: 16);
  }
}
