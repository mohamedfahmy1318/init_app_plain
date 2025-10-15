/// ========================================================
/// Brands Cubit - State Management
/// ========================================================
/// بيدير حالة الـ Brands في التطبيق
/// بيستخدم BaseCubit و PaginationHandler من الـ Core
/// ========================================================

import '../../../../core/base/base_cubit.dart';
import '../../../../core/base/base_bloc.dart';
import '../../../../core/base/pagination_handler.dart';
import '../../domain/entities/brand_entity.dart';
import '../../domain/usecases/get_brands_usecase.dart';

part 'brands_state.dart';

/// 🎛️ Brands Cubit (مع استخدام PaginationHandler من الـ Core)
class BrandsCubit extends BaseCubit {
  final GetBrandsUseCase getBrandsUseCase;

  BrandsCubit({required this.getBrandsUseCase}) : super(const InitialState());

  // 📦 البيانات المحملة (باستخدام PaginationHandler من الـ Core)
  List<BrandEntity> brands = [];
  List<BrandEntity> _allBrands = []; // ✅ نسخة أصلية من كل البراندات
  PaginationParams currentParams = PaginationParams.firstPage(limit: 40);
  bool hasMoreData = true;
  String _currentSearchQuery = ''; // ✅ حفظ البحث الحالي

  /// 📥 جلب البراندات (باستخدام PaginationParams من الـ Core)
  Future<void> getBrands({bool loadMore = false}) async {
    try {
      // إذا كان loadMore, لا نعرض loading (علشان الـ pagination)
      if (!loadMore) {
        emitLoading();
        currentParams = PaginationParams.firstPage(limit: 40);
        brands.clear();
      }

      // استدعاء الـ UseCase (باستخدام PaginationParams)
      final result = await getBrandsUseCase(
        GetBrandsParams(page: currentParams.page, limit: currentParams.limit),
      );

      // معالجة النتيجة
      result.fold(
        (failure) {
          emitError(failure.message);
        },
        (newBrands) {
          if (newBrands.isEmpty) {
            hasMoreData = false;
          } else {
            brands.addAll(newBrands);
            _allBrands.addAll(newBrands); // ✅ حفظ في القائمة الأصلية
            currentParams = currentParams
                .nextPage(); // ✅ استخدام الـ Core method
            hasMoreData =
                newBrands.length == 40; // إذا أقل من 40، يبقى مافيش more data
          }

          // ✅ إذا كان فيه بحث نشط، طبّقه
          if (_currentSearchQuery.isNotEmpty) {
            _applySearch();
          } else {
            emit(BrandsLoadedState(brands));
          }
        },
      );
    } catch (e) {
      emitError(e.toString());
    }
  }

  /// 🔄 إعادة تحميل البيانات (Pull to Refresh)
  Future<void> refreshBrands() async {
    _currentSearchQuery = ''; // ✅ مسح البحث
    currentParams = PaginationParams.firstPage(
      limit: 40,
    ); // ✅ استخدام firstPage من الـ Core
    brands.clear();
    _allBrands.clear(); // ✅ مسح القائمة الأصلية
    hasMoreData = true;
    await getBrands();
  }

  /// 📄 تحميل المزيد (Pagination)
  Future<void> loadMoreBrands() async {
    if (hasMoreData && state is! LoadingState) {
      await getBrands(loadMore: true);
    }
  }

  /// 🔍 البحث في البراندات (محلي - Local Search)
  void searchBrands(String query) {
    _currentSearchQuery = query.trim();
    _applySearch();
  }

  /// 🔧 تطبيق البحث على البيانات المحملة
  void _applySearch() {
    if (_currentSearchQuery.isEmpty) {
      // إذا كان البحث فارغ، أظهر كل البراندات المحملة
      brands = List.from(_allBrands);
    } else {
      // ابحث في القائمة الأصلية
      brands = _allBrands
          .where(
            (brand) => brand.name.toLowerCase().contains(
              _currentSearchQuery.toLowerCase(),
            ),
          )
          .toList();
    }
    emit(BrandsLoadedState(brands));
  }
}

/// 📝 شرح الـ Cubit (مع استخدام الـ Core):
/// ----------------------------------------
/// 1. extends BaseCubit: بنرث من الـ BaseCubit في الـ Core ✅
/// 2. PaginationParams: بنستخدم الـ PaginationParams من الـ Core ✅
/// 3. getBrandsUseCase: الـ UseCase اللي بنستخدمه لجلب البيانات
/// 4. brands: List بنخزن فيها البراندات المحملة
/// 5. currentParams: الـ pagination parameters (من الـ Core)
/// 6. hasMoreData: هل فيه بيانات أكتر أم لا
/// 
/// 🔄 الدوال:
/// - getBrands(): جلب البراندات (أول مرة أو pagination)
/// - refreshBrands(): إعادة تحميل البيانات (Pull to Refresh)
/// - loadMoreBrands(): تحميل المزيد (Pagination)
/// 
/// 🎯 الحالات (States):
/// - InitialState: الحالة الأولية (من الـ Core) ✅
/// - LoadingState: جاري التحميل (من الـ Core) ✅
/// - BrandsLoadedState: تم تحميل البيانات بنجاح
/// - ErrorState: حدث خطأ (من الـ Core) ✅
/// 
/// ⚠️ ملاحظات:
/// - emitLoading() و emitError() من الـ BaseCubit ✅
/// - result.fold() للتعامل مع Either (success/failure) ✅
/// - loadMore parameter علشان نفرق بين أول تحميل والـ pagination
/// - PaginationParams.firstPage() و nextPage() من الـ Core ✅
