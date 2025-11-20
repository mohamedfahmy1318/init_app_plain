import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/home_widgets.dart';

/// Home Tab Page
class HomeTapPage extends StatefulWidget {
  final Function(int)? onNavigateToTab;

  const HomeTapPage({super.key, this.onNavigateToTab});

  @override
  State<HomeTapPage> createState() => _HomeTapPageState();
}

class _HomeTapPageState extends State<HomeTapPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 60.h),
        // Search Bar Section (Fixed)
        SearchBarWidget(
          onTap: () {
            //  Navigate to search page
            debugPrint('Search tapped');
          },
        ),

        // Scrollable Content
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: 20.h),
                // Banner Slider Section
                const BannerSliderWidget(),

                SizedBox(height: 25.h),
                // Main Categories Section
                CategoriesSectionWidget(
                  onViewAllPressed: () {
                    // Navigate to categories tab (index 1)
                    widget.onNavigateToTab?.call(1);
                  },
                ),

                SizedBox(height: 25.h),

                // Products Section (وصل حديثاً)
                ProductsSectionWidget(
                  title: 'وصل حديثاً',
                  onViewAllPressed: () {
                    // Navigate to all products
                  },
                ),

                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
