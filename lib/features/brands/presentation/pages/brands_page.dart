/// ========================================================
/// Brands Page - الصفحة الرئيسية للبراندات
/// ========================================================
/// بتعرض قائمة البراندات في Grid View
/// بتستخدم كل الأدوات من الـ Core
/// ========================================================

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/base/base_bloc.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/utils/extensions/context_extensions.dart';
import '../../../../core/widgets/app_widgets.dart';
import '../cubit/brands_cubit.dart';
import '../widgets/brand_card.dart';

class BrandsPage extends StatelessWidget {
  const BrandsPage({super.key});
  static const String routeName = '/brands';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<BrandsCubit>()..getBrands(),
      child: Scaffold(
        appBar: CustomAppBar(title: 'البراندات'),

        body: BlocConsumer<BrandsCubit, BaseState>(
          listener: (context, state) {
            // 🎧 Listener للأحداث
            if (state is ErrorState) {
              context.showErrorSnackBar(state.message);
            }
          },
          builder: (context, state) {
            final cubit = context.read<BrandsCubit>();
            // ⏳ حالة التحميل الأولي (لما مافيش بيانات)
            if (state is LoadingState && cubit.brands.isEmpty) {
              return const LoadingWidget(message: 'جاري تحميل البراندات...');
            }

            // ❌ حالة الخطأ
            if (state is ErrorState && cubit.brands.isEmpty) {
              return ErrorDisplayWidget(
                message: state.message,
                onRetry: cubit.getBrands,
              );
            }

            // 📭 حالة عدم وجود بيانات
            if (cubit.brands.isEmpty) {
              return const EmptyWidget(
                message: 'لا توجد براندات حالياً',
                icon: Icons.store_outlined,
              );
            }

            // ✅ عرض البيانات مع Pagination
            return Column(
              children: [
                // 🔍 بحث
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CustomSearchBar(
                    hint: 'ابحث عن براند...',
                    onSearch: (query) {
                      cubit.searchBrands(query);
                    },
                  ),
                ),
                // 📋 Grid View
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: cubit.refreshBrands,
                    child: PaginationGridView(
                      items: cubit.brands,
                      onLoadMore: cubit.loadMoreBrands,
                      hasMore: cubit.hasMoreData,
                      isLoading: state is LoadingState,
                      padding: const EdgeInsets.all(16),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // عمودين
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                            childAspectRatio: 0.85, // نسبة العرض للطول
                          ),
                      emptyWidget: const EmptyWidget(
                        message: 'لا توجد براندات حالياً',
                        icon: Icons.store_outlined,
                      ),
                      itemBuilder: (context, brand, index) {
                        return BrandCard(
                          brand: brand,
                          onTap: () {
                            context.showInfoSnackBar(
                              'تم اختيار: ${brand.name}',
                            );
                            // TODO: Navigate to brand details
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

/// 📝 شرح الـ Brands Page:
/// ----------------------
/// 1. BlocProvider: بننشئ الـ BrandsCubit ونبدأ تحميل البيانات
/// 2. CustomAppBar: من الـ core/widgets/app_widgets.dart
/// 3. BlocConsumer: بنسمع للـ states ونبني الـ UI
/// 
/// 🎯 الحالات (States):
/// - LoadingState: بنعرض LoadingWidget
/// - ErrorState: بنعرض ErrorDisplayWidget مع retry button
/// - BrandsLoadedState + empty: بنعرض EmptyWidget
/// - BrandsLoadedState + data: بنعرض GridView
/// 
/// 🔄 المميزات:
/// - Pull to Refresh: RefreshIndicator
/// - Pagination: بنعرض loading indicator في النهاية ونحمل المزيد
/// - Error Handling: بنعرض SnackBar للأخطاء
/// - Empty State: بنعرض رسالة لما مافيش بيانات
/// 
/// 📐 الـ Grid View:
/// - crossAxisCount: 2: عمودين
/// - mainAxisSpacing: 16: مسافة رأسية بين الـ items
/// - crossAxisSpacing: 16: مسافة أفقية بين الـ items
/// - childAspectRatio: 0.85: نسبة العرض للطول
/// 
/// ⚠️ ملاحظات:
/// - بنستخدم context extensions للـ SnackBars
/// - كل الـ widgets من الـ Core (reusable)
/// - Clean Architecture: الـ UI مبيعرفش حاجة عن الـ API
/// - Separation of Concerns: كل layer له مسؤوليته
