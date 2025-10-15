/// ========================================================
/// App Widgets - Barrel File
/// ========================================================
/// ملف واحد لتصدير جميع الـ Widgets
/// بدل ما تعمل import لكل widget لوحده، استخدم هذا الملف
///
/// مثال:
/// ```dart
/// import 'package:init_app_flutter/core/widgets/app_widgets.dart';
///
/// CustomButton(text: 'زر');
/// LoadingWidget();
/// EmptyWidget(message: 'لا توجد بيانات');
/// ```
/// ========================================================

// Core Widgets
export 'custom_app_bar.dart';
export 'custom_button.dart';
export 'custom_card.dart';
export 'custom_text_field.dart';
export 'custom_icon_button.dart';
export 'custom_divider.dart';
export 'custom_badge.dart';

// State Widgets
export 'empty_widget.dart';
export 'error_display_widget.dart';
export 'loading_widget.dart';

// Pagination Widgets
export 'pagination_grid_view.dart';
export 'pagination_list_view.dart';

// Media Widgets
export 'cached_image_widget.dart';
export 'rating_widget.dart';

// UI Widgets
export 'custom_search_bar.dart';
export 'shimmer_loading.dart';
export 'network_aware_widget.dart';

// Map Widgets
export 'map_widgets.dart';

// Chart Widgets
export 'chart_widgets.dart';
