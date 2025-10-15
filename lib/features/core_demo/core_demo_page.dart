import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:init_app_flutter/core/widgets/app_widgets.dart';
import 'package:init_app_flutter/core/utils/utils.dart';
import 'dart:async';

/// ========================================================
/// Core Demo Page
/// ========================================================
/// صفحة تعرض جميع الـ Widgets والـ Helpers الموجودة في الكور
/// مع أمثلة عملية على كل الاستخدامات
/// ========================================================

class CoreDemoPage extends StatefulWidget {
  const CoreDemoPage({super.key});

  @override
  State<CoreDemoPage> createState() => _CoreDemoPageState();
}

class _CoreDemoPageState extends State<CoreDemoPage> {
  final _searchController = TextEditingController();
  bool _isOnline = true;
  StreamSubscription? _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
    _listenToConnectivity();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _connectivitySubscription?.cancel();
    super.dispose();
  }

  Future<void> _checkConnectivity() async {
    final isOnline = await ConnectivityHelper.hasInternetConnection();
    if (mounted) {
      setState(() {
        _isOnline = isOnline;
      });
    }
  }

  void _listenToConnectivity() {
    _connectivitySubscription = ConnectivityHelper.onConnectivityChanged.listen(
      (result) {
        LoggerHelper.info('Connectivity changed: $result');
        _checkConnectivity();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NetworkAwareWidget(
        child: CustomScrollView(
          slivers: [
            // ==================== Custom SliverAppBar ====================
            SliverAppBar(
              expandedHeight: 200.h,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text('Core Components Demo'),
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue.shade400, Colors.blue.shade800],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.widgets,
                      size: 80.sp,
                      color: Colors.white.withOpacity(0.3),
                    ),
                  ),
                ),
              ),
              actions: [
                // Map Demo
                CustomIconButton(
                  icon: Icons.map,
                  onPressed: () {
                    GoRouter.of(context).push('/map-demo');
                  },
                ),
                // Charts Demo
                CustomIconButton(
                  icon: Icons.bar_chart,
                  onPressed: () {
                    GoRouter.of(context).push('/charts-demo');
                  },
                ),
                // Connection Indicator
                CustomBadge(
                  value: _isOnline ? '✓' : '✗',
                  backgroundColor: _isOnline ? Colors.green : Colors.red,
                  child: CustomIconButton(
                    icon: Icons.wifi,
                    onPressed: () async {
                      final isOnline =
                          await ConnectivityHelper.hasInternetConnection();
                      ToastHelper.show(
                        isOnline ? 'متصل بالإنترنت ✓' : 'غير متصل بالإنترنت ✗',
                      );
                    },
                  ),
                ),
                CustomIconButton(
                  icon: Icons.info_outline,
                  onPressed: () => _showInfoDialog(context),
                ),
              ],
            ),

            // ==================== Search Bar ====================
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: CustomSearchBar(
                  onClear: () => _searchController.clear(),
                  controller: _searchController,
                  hint: 'ابحث في المكونات...',
                  onSearch: (value) {
                    LoggerHelper.debug('Search: $value');
                    if (value.isNotEmpty) {
                      ToastHelper.info('بحث عن: $value');
                    }
                  },
                ),
              ),
            ),

            // ==================== Content ====================
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  // Buttons Section
                  _buildSectionTitle('الأزرار (Buttons)'),
                  _buildButtonsSection(),
                  SizedBox(height: 24.h),

                  // Cards Section
                  _buildSectionTitle('الكروت (Cards)'),
                  _buildCardsSection(),
                  SizedBox(height: 24.h),

                  // Text Fields Section
                  _buildSectionTitle('حقول النصوص (Text Fields)'),
                  _buildTextFieldsSection(),
                  SizedBox(height: 24.h),

                  // Widgets Section
                  _buildSectionTitle('Widgets مختلفة'),
                  _buildWidgetsSection(),
                  SizedBox(height: 24.h),

                  // Form Builder Section
                  _buildSectionTitle('Form Builder'),
                  _buildFormBuilderSection(),
                  SizedBox(height: 24.h),

                  // Helpers Section
                  _buildSectionTitle('المساعدات (Helpers)'),
                  _buildHelpersSection(),
                  SizedBox(height: 24.h),

                  // Rating Widget Section
                  _buildSectionTitle('التقييمات (Rating)'),
                  _buildRatingSection(),
                  SizedBox(height: 24.h),

                  // Shimmer Loading Section
                  _buildSectionTitle('Shimmer Loading'),
                  _buildShimmerSection(),
                  SizedBox(height: 24.h),

                  // Cached Image Section
                  _buildSectionTitle('الصور المخزنة (Cached Images)'),
                  _buildCachedImageSection(),
                  SizedBox(height: 24.h),

                  // Extensions Section
                  _buildSectionTitle('الـ Extensions'),
                  _buildExtensionsSection(),
                  SizedBox(height: 24.h),

                  // More Helpers Section
                  _buildSectionTitle('مساعدات إضافية'),
                  _buildMoreHelpersSection(),
                  SizedBox(height: 24.h),

                  // Pagination Section
                  _buildSectionTitle('Pagination Views'),
                  _buildPaginationSection(),
                  SizedBox(height: 40.h),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Text(
        title,
        style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildButtonsSection() {
    return Column(
      children: [
        CustomButton(
          text: 'زر عادي',
          onPressed: () => ToastHelper.success('تم الضغط!'),
        ),
        SizedBox(height: 12.h),
        CustomButton(text: 'زر Loading', isLoading: true, onPressed: () {}),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(
              child: CustomButton(
                text: 'نجاح',
                backgroundColor: Colors.green,
                onPressed: () => ToastHelper.success('عملية ناجحة!'),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: CustomButton(
                text: 'خطأ',
                backgroundColor: Colors.red,
                onPressed: () => ToastHelper.error('حدث خطأ!'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCardsSection() {
    return Column(
      children: [
        CustomCard(
          child: ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: const Text('منتج 1'),
            subtitle: const Text('وصف المنتج هنا'),
            trailing: const Text('99 ريال'),
            onTap: () => ToastHelper.info('تم اختيار منتج 1'),
          ),
        ),
        SizedBox(height: 12.h),
        CustomCard(
          elevation: 8,
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'كارت مخصص',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.h),
              const Text('يمكنك تخصيص الكارت بالشكل الذي تريده'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTextFieldsSection() {
    return Column(
      children: [
        CustomTextField(
          label: 'الاسم',
          hint: 'أدخل اسمك',
          prefixIcon: const Icon(Icons.person),
        ),
        SizedBox(height: 12.h),
        CustomTextField(
          label: 'البريد الإلكتروني',
          hint: 'example@domain.com',
          keyboardType: TextInputType.emailAddress,
          prefixIcon: const Icon(Icons.email),
        ),
        SizedBox(height: 12.h),
        CustomTextField(
          label: 'كلمة المرور',
          hint: '••••••••',
          obscureText: true,
          prefixIcon: const Icon(Icons.lock),
        ),
      ],
    );
  }

  Widget _buildWidgetsSection() {
    return Column(
      children: [
        const CustomDivider(),
        SizedBox(height: 12.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomBadge(
              value: '3',
              child: Icon(Icons.notifications, size: 32.sp),
            ),
            CustomBadge(
              value: '99+',
              backgroundColor: Colors.red,
              child: Icon(Icons.mail, size: 32.sp),
            ),
            CustomBadge(
              value: 'NEW',
              backgroundColor: Colors.green,
              child: Icon(Icons.star, size: 32.sp),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        const EmptyWidget(
          message: 'لا توجد عناصر للعرض',
          icon: Icons.inbox_outlined,
        ),
        SizedBox(height: 16.h),
        const LoadingWidget(message: 'جاري التحميل...'),
      ],
    );
  }

  Widget _buildFormBuilderSection() {
    return CustomCard(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Text Fields Example',
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12.h),
          CustomTextField(
            label: 'اسم المستخدم',
            hint: 'أدخل اسم المستخدم',
            prefixIcon: const Icon(Icons.person),
          ),
          SizedBox(height: 12.h),
          CustomTextField(
            label: 'البريد الإلكتروني',
            hint: 'example@email.com',
            keyboardType: TextInputType.emailAddress,
            prefixIcon: const Icon(Icons.email),
          ),
          SizedBox(height: 12.h),
          CustomButton(
            text: 'إرسال',
            onPressed: () {
              ToastHelper.success('تم الإرسال!');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHelpersSection() {
    return Wrap(
      spacing: 12.w,
      runSpacing: 12.h,
      children: [
        _buildHelperButton('Toast Info', () {
          ToastHelper.info('معلومة مهمة');
        }),
        _buildHelperButton('Toast Success', () {
          ToastHelper.success('عملية ناجحة!');
        }),
        _buildHelperButton('Toast Error', () {
          ToastHelper.error('حدث خطأ!');
        }),
        _buildHelperButton('Dialog', () {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text('تأكيد'),
              content: const Text('هل أنت متأكد؟'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text('إلغاء'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                    ToastHelper.success('تم التأكيد');
                  },
                  child: const Text('تأكيد'),
                ),
              ],
            ),
          );
        }),
        _buildHelperButton('Bottom Sheet', () {
          showModalBottomSheet(
            context: context,
            builder: (ctx) => Container(
              padding: EdgeInsets.all(24.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Bottom Sheet',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16.h),
                  const Text('محتوى Bottom Sheet هنا'),
                  SizedBox(height: 16.h),
                  CustomButton(
                    text: 'إغلاق',
                    onPressed: () => Navigator.pop(ctx),
                  ),
                ],
              ),
            ),
          );
        }),
        _buildHelperButton('Share', () {
          ShareHelper.shareText('شارك هذا النص مع أصدقائك!');
        }),
        _buildHelperButton('Open URL', () {
          UrlLauncherHelper.openUrl('https://flutter.dev');
        }),
        _buildHelperButton('Date Picker', () async {
          final date = await DateTimePickerHelper.pickDate(
            context: context,
            initialDate: DateTime.now(),
          );
          if (date != null) {
            ToastHelper.info('التاريخ: $date');
          }
        }),
      ],
    );
  }

  Widget _buildHelperButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      ),
      child: Text(text, style: TextStyle(fontSize: 14.sp)),
    );
  }

  void _showInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('معلومات'),
        content: const Text(
          'هذه صفحة تجريبية تعرض جميع مكونات الـ Core.\n\n'
          '✅ Widgets جاهزة\n'
          '✅ Helpers مفيدة\n'
          '✅ Extensions قوية\n'
          '✅ Clean Architecture\n\n'
          'استمتع بالتطوير! 🚀',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('حسناً'),
          ),
        ],
      ),
    );
  }

  // ==================== Rating Section ====================
  Widget _buildRatingSection() {
    return Column(
      children: [
        // Rating Widget (Read Only)
        CustomCard(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'تقييم للقراءة فقط',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12.h),
              RatingWidget(rating: 4.5, size: 32.sp),
              SizedBox(height: 8.h),
              Text(
                '4.5 من 5 نجوم',
                style: TextStyle(fontSize: 14.sp, color: Colors.grey),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        // Interactive Rating Widget
        CustomCard(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'تقييم تفاعلي',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12.h),
              InteractiveRatingWidget(
                initialRating: 3,
                size: 40.sp,
                onRatingChanged: (rating) {
                  ToastHelper.info('تم التقييم بـ $rating نجوم');
                },
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        // Rating Bar with Labels
        CustomCard(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'شريط التقييم',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12.h),
              RatingBarWithLabels(rating: 3.8),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        // Rating Summary
        CustomCard(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ملخص التقييمات',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12.h),
              RatingSummaryWidget(
                averageRating: 4.2,
                totalReviews: 150,
                ratingDistribution: const {5: 80, 4: 40, 3: 20, 2: 7, 1: 3},
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ==================== Shimmer Section ====================
  Widget _buildShimmerSection() {
    return Column(
      children: [
        CustomCard(
          child: Column(
            children: [
              ShimmerLoading(
                child: ShimmerShapes.rectangular(
                  height: 200.h,
                  width: double.infinity,
                ),
              ),
              SizedBox(height: 12.h),
              Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerLoading(
                      child: ShimmerShapes.rectangular(
                        height: 20.h,
                        width: 200.w,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    ShimmerLoading(
                      child: ShimmerShapes.rectangular(
                        height: 16.h,
                        width: double.infinity,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    ShimmerLoading(
                      child: ShimmerShapes.rectangular(
                        height: 16.h,
                        width: 250.w,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        CustomCard(
          padding: EdgeInsets.all(16.w),
          child: Row(
            children: [
              ShimmerLoading(child: ShimmerShapes.circular(size: 60.r)),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerLoading(
                      child: ShimmerShapes.rectangular(
                        height: 16.h,
                        width: double.infinity,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    ShimmerLoading(
                      child: ShimmerShapes.rectangular(
                        height: 14.h,
                        width: 150.w,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ==================== Cached Image Section ====================
  Widget _buildCachedImageSection() {
    return Column(
      children: [
        CustomCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedImageWidget(
                imageUrl: 'https://picsum.photos/400/300',
                height: 200.h,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'صورة مخزنة',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    const Text(
                      'يتم تخزين الصورة في الذاكرة المؤقتة لتحسين الأداء',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(
              child: CustomCard(
                child: CachedImageWidget(
                  imageUrl: 'https://picsum.photos/200/200',
                  height: 150.h,
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: CustomCard(
                child: CachedImageWidget(
                  imageUrl: 'https://picsum.photos/201/201',
                  height: 150.h,
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ==================== Extensions Section ====================
  Widget _buildExtensionsSection() {
    final now = DateTime.now();
    const sampleText = 'hello world';
    const number = 1234.56;
    final colors = [Colors.red, Colors.blue, Colors.green];

    return CustomCard(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // String Extensions
          _buildExtensionExample('String Extensions', [
            'capitalize: "$sampleText" → "${sampleText.capitalize}"',
            'isValidEmail: "test@email.com" → ${'test@email.com'.isValidEmail}',
            'isValidPhone: "0501234567" → ${'0501234567'.isValidPhone}',
            'isArabic: "مرحباً" → "${'مرحباً'.isArabic}"',
          ]),
          const CustomDivider(),
          SizedBox(height: 12.h),

          // Date Extensions
          _buildExtensionExample('Date Extensions', [
            'toDateString: ${now.toDateString}',
            'toTimeString: ${now.toTimeString}',
            'timeAgo: ${now.timeAgo}',
            'isToday: ${now.isToday}',
          ]),
          const CustomDivider(),
          SizedBox(height: 12.h),

          // Number Extensions
          _buildExtensionExample('Number Extensions', [
            'toCurrency: $number → ${number.toCurrency()}',
            'toPercentage: 0.75 → ${0.75.toPercentage()}',
            'formatted: 1500000 → ${1500000.formatted}',
          ]),
          const CustomDivider(),
          SizedBox(height: 12.h),

          // List Extensions
          _buildExtensionExample('List Extensions', [
            'length: ${colors.length}',
            'first: ${colors.first}',
            'last: ${colors.last}',
          ]),
          const CustomDivider(),
          SizedBox(height: 12.h),

          // Context Extensions
          _buildExtensionExample('Context Extensions', [
            'screenWidth: ${context.screenWidth.toStringAsFixed(0)}',
            'screenHeight: ${context.screenHeight.toStringAsFixed(0)}',
            'theme: متاح',
            'textTheme: متاح',
          ]),
        ],
      ),
    );
  }

  Widget _buildExtensionExample(String title, List<String> examples) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        SizedBox(height: 8.h),
        ...examples.map(
          (example) => Padding(
            padding: EdgeInsets.only(bottom: 4.h, right: 8.w),
            child: Text('• $example', style: TextStyle(fontSize: 12.sp)),
          ),
        ),
      ],
    );
  }

  // ==================== More Helpers Section ====================
  Widget _buildMoreHelpersSection() {
    return Wrap(
      spacing: 12.w,
      runSpacing: 12.h,
      children: [
        _buildHelperButton('Image Picker', () async {
          try {
            ToastHelper.info('Image Picker متاح في ImagePickerHelper');
          } catch (e) {
            ToastHelper.error('خطأ: $e');
          }
        }),
        _buildHelperButton('Platform Info', () {
          final info =
              'Platform Helper متاح\n'
              'Is Mobile: ${PlatformHelper.isMobile}\n'
              'Is Web: ${PlatformHelper.isWeb}';
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text('معلومات المنصة'),
              content: Text(info),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text('حسناً'),
                ),
              ],
            ),
          );
        }),
        _buildHelperButton('Logger', () {
          LoggerHelper.debug('Debug message');
          LoggerHelper.info('Info message');
          LoggerHelper.warning('Warning message');
          LoggerHelper.error('Error message');
          ToastHelper.success('تم طباعة الرسائل في Console');
        }),
        _buildHelperButton('Time Picker', () async {
          final time = await DateTimePickerHelper.pickTime(
            context: context,
            initialTime: TimeOfDay.now(),
          );
          if (time != null) {
            ToastHelper.info('الوقت: ${time.format(context)}');
          }
        }),
        _buildHelperButton('Date Range', () async {
          final range = await DateTimePickerHelper.pickDateRange(
            context: context,
            initialDateRange: DateTimeRange(
              start: DateTime.now(),
              end: DateTime.now().add(const Duration(days: 7)),
            ),
          );
          if (range != null) {
            ToastHelper.info(
              'من ${range.start.toDateString} إلى ${range.end.toDateString}',
            );
          }
        }),
        _buildHelperButton('Connectivity', () async {
          final isOnline = await ConnectivityHelper.hasInternetConnection();
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text('حالة الاتصال'),
              content: Text('متصل: ${isOnline ? "نعم ✓" : "لا ✗"}'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text('حسناً'),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  // ==================== Pagination Section ====================
  Widget _buildPaginationSection() {
    // Sample data
    final items = List.generate(50, (index) => 'عنصر ${index + 1}');

    return Column(
      children: [
        // Info Card
        CustomCard(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.blue, size: 20.sp),
                  SizedBox(width: 8.w),
                  Text(
                    'Pagination Views',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              const Text(
                'يوفر المشروع PaginationListView و PaginationGridView '
                'لعرض البيانات مع التصفح التلقائي والتحميل عند الوصول لنهاية القائمة.',
              ),
              SizedBox(height: 12.h),
              CustomButton(
                text: 'عرض مثال Pagination',
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (ctx) => DraggableScrollableSheet(
                      initialChildSize: 0.9,
                      builder: (_, controller) => Container(
                        padding: EdgeInsets.all(16.w),
                        child: Column(
                          children: [
                            Text(
                              'Pagination List Example',
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 16.h),
                            Expanded(
                              child: PaginationListView<String>(
                                items: items,
                                isLoading: false,
                                hasMore: false,
                                onLoadMore: () async {},
                                itemBuilder: (context, item, index) {
                                  return CustomCard(
                                    margin: EdgeInsets.only(bottom: 8.h),
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        child: Text('${index + 1}'),
                                      ),
                                      title: Text(item),
                                      trailing: const Icon(
                                        Icons.arrow_forward_ios,
                                        size: 16,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
