import 'package:Bynona/features/categories/presentation/widgets/details/custom_arrange_widget.dart';
import 'package:Bynona/features/categories/presentation/widgets/details/custom_filtering_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomChooseFilterWidget extends StatelessWidget {
  const CustomChooseFilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 60.w),
        Row(
          children: [
            CustomFilteringWidget(),
            SizedBox(width: 100.w),
            CustomArrangeWidget(),
          ],
        ),
      ],
    );
  }
}
