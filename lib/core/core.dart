/// ========================================================
/// Core Exports - تصدير جميع ملفات الـ Core
/// ========================================================
/// استخدم هذا الملف للاستيراد السريع لجميع ملفات الـ Core
/// مثال: import 'core/core.dart';
/// ========================================================

// ==================== Base Classes (Clean Architecture) ====================
export 'base/base_repository.dart';
export 'base/base_usecase.dart';
export 'base/base_bloc.dart';
export 'base/base_cubit.dart'; // 👈 Cubit Support
export 'base/base_entity.dart';
export 'base/bloc_observer.dart';
export 'base/network_checker_mixin.dart';
export 'base/pagination_handler.dart';

// ==================== Config ====================
export 'config/app_config.dart';
export 'config/theme_config.dart';

// ==================== Network ====================
export 'network/dio_client.dart';
export 'network/api_exceptions.dart';
export 'network/interceptors/auth_interceptor.dart';
export 'network/interceptors/error_interceptor.dart';
export 'network/interceptors/logging_interceptor.dart';

// ==================== Services ====================
export 'services/storage/secure_storage_service.dart';
export 'services/storage/local_storage_service.dart';
export 'services/connectivity_service.dart';
export 'services/notification_service.dart';
export 'services/permission_service.dart';
export 'services/app_lifecycle_service.dart';
export 'services/cache_manager_service.dart';
export 'services/logger_service.dart';

// ==================== DI ====================
export 'di/service_locator.dart';

// ==================== Errors ====================
export 'errors/failures.dart';

// ==================== Models ====================
export 'models/api_response.dart';

// ==================== Router ====================
export 'router/app_router.dart';

// ==================== Constants ====================
export 'constants/app_constants.dart';

// ==================== Utils ====================
export 'utils/validators.dart';
export 'utils/helpers.dart';
export 'utils/debouncer.dart';
export 'utils/image_picker_helper.dart';
export 'utils/bottom_sheet_helper.dart';
export 'utils/date_time_picker_helper.dart';
export 'utils/animation_helper.dart';
export 'utils/platform_helper.dart';
export 'utils/permission_helper.dart'; // 👈 Permission Helper
export 'utils/extensions/string_extensions.dart';
export 'utils/extensions/context_extensions.dart';
export 'utils/extensions/date_extensions.dart';

// ==================== Widgets ====================
export 'widgets/app_widgets.dart';
export 'widgets/custom_search_bar.dart';
export 'widgets/cached_image_widget.dart';
export 'widgets/network_aware_widget.dart';
export 'widgets/pagination_list_view.dart';
export 'widgets/form_builder_widget.dart';
export 'widgets/shimmer_loading.dart';
export 'widgets/rating_widget.dart';
