import 'package:Bynona/core/config/app_text_styles.dart';
import 'package:Bynona/features/categories/presentation/widgets/details/custom_arrange_widget.dart';
import 'package:Bynona/features/categories/presentation/widgets/details/custom_choose_filter.dart';
import 'package:Bynona/features/categories/presentation/widgets/details/custom_filtering_widget.dart';
import 'package:Bynona/features/home_tab/presentation/widgets/search_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomHeaderDerails extends StatefulWidget {
  const CustomHeaderDerails({super.key});

  @override
  State<CustomHeaderDerails> createState() => _CustomHeaderDerailsState();
}

class _CustomHeaderDerailsState extends State<CustomHeaderDerails> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchBarWidget(
          onTap: () {
            //  Navigate to search page
            debugPrint('Search tapped');
          },
        ),
        SizedBox(height: 5.h),
        const CustomChooseFilterWidget(),
      ],
    );
  }
}
