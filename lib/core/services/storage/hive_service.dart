import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// ========================================================
/// HiveService - خدمة شاملة للتخزين المحلي
/// ========================================================
/// يدعم: Lists, Single Objects, Primitives, Cache with Expiry
/// ========================================================
class HiveService {
  HiveService._();
  static final HiveService instance = HiveService._();

  // ==================== Box Names ====================
  static const String brandsBox = 'brands_box';
  static const String categoriesBox = 'categories_box';
  static const String subcategoriesBox = 'subcategories_box';
  static const String productsBox = 'products_box';
  static const String userBox = 'user_box';
  static const String cacheBox = 'cache_box';
  static const String settingsBox = 'settings_box';

  Future<void> init() async {
    await Hive.initFlutter();
    debugPrint('✅ HiveService initialized');
  }

  /// تسجيل TypeAdapter (للأداء الأفضل)
  void registerAdapter<T>(TypeAdapter<T> adapter) {
    if (!Hive.isAdapterRegistered(adapter.typeId)) {
      Hive.registerAdapter(adapter);
      debugPrint('✅ Registered adapter: ${adapter.runtimeType}');
    }
  }

  Future<Box<T>> openBox<T>(String boxName) async {
    if (Hive.isBoxOpen(boxName)) {
      return Hive.box<T>(boxName);
    }
    return await Hive.openBox<T>(boxName);
  }

  // ==================== List Cache (للـ Features) ====================

  /// حفظ List مع expiry - مناسب للـ Brands, Categories, Products
  Future<void> saveListWithCache<T>({
    required String boxName,
    required String key,
    required List<T> list,
    Duration expiry = const Duration(hours: 24),
  }) async {
    final box = await openBox<Map<dynamic, dynamic>>(boxName);
    final expiryTime = DateTime.now().add(expiry).millisecondsSinceEpoch;

    await box.put(key, {'data': list, 'expiry': expiryTime});
  }

  /// قراءة List من Cache - يرجع null لو expired
  Future<List<T>?> getListFromCache<T>({
    required String boxName,
    required String key,
  }) async {
    final box = await openBox<Map<dynamic, dynamic>>(boxName);
    final cacheData = box.get(key);

    if (cacheData == null) return null;

    final expiryTime = cacheData['expiry'] as int;
    final now = DateTime.now().millisecondsSinceEpoch;

    if (now > expiryTime) {
      await box.delete(key);
      return null;
    }

    final data = cacheData['data'] as List;
    return data.cast<T>();
  }

  // ==================== Single Object Cache ====================

  /// حفظ Object واحد مع expiry - مناسب للـ User Profile
  Future<void> saveObjectWithCache<T>({
    required String boxName,
    required String key,
    required T object,
    Duration expiry = const Duration(hours: 1),
  }) async {
    final box = await openBox<Map<dynamic, dynamic>>(boxName);
    final expiryTime = DateTime.now().add(expiry).millisecondsSinceEpoch;

    await box.put(key, {'data': object, 'expiry': expiryTime});
  }

  /// قراءة Object من Cache
  Future<T?> getObjectFromCache<T>({
    required String boxName,
    required String key,
  }) async {
    final box = await openBox<Map<dynamic, dynamic>>(boxName);
    final cacheData = box.get(key);

    if (cacheData == null) return null;

    final expiryTime = cacheData['expiry'] as int;
    final now = DateTime.now().millisecondsSinceEpoch;

    if (now > expiryTime) {
      await box.delete(key);
      debugPrint('⏰ Object cache expired');
      return null;
    }
    return cacheData['data'] as T;
  }

  // ==================== Simple Key-Value (بدون Expiry) ====================

  /// حفظ بيانات بسيطة (String, int, bool) - للـ Settings
  Future<void> save<T>({
    required String boxName,
    required String key,
    required T value,
  }) async {
    final box = await openBox<T>(boxName);
    await box.put(key, value);
    debugPrint('💾 Saved: $key');
  }

  /// قراءة بيانات بسيطة
  Future<T?> get<T>({required String boxName, required String key}) async {
    final box = await openBox<T>(boxName);
    return box.get(key);
  }

  // ==================== Utility Methods ====================

  /// مسح box كامل
  Future<void> clear(String boxName) async {
    final box = await openBox(boxName);
    await box.clear();
    debugPrint('🧹 Cleared $boxName');
  }

  /// حذف key معين
  Future<void> delete({required String boxName, required String key}) async {
    final box = await openBox(boxName);
    await box.delete(key);
    debugPrint('🗑️ Deleted: $key');
  }

  /// التحقق من وجود key
  Future<bool> containsKey({
    required String boxName,
    required String key,
  }) async {
    final box = await openBox(boxName);
    return box.containsKey(key);
  }

  /// مسح كل الـ Boxes (استخدم بحذر!)
  Future<void> clearAll() async {
    await Hive.deleteFromDisk();
  }
}

/// ========================================================
/// 📝 دليل الاستخدام
/// ========================================================
/// 
/// 1️⃣ للـ Lists (Brands, Categories, Products):
/// ```dart
/// await HiveService.instance.saveListWithCache(
///   boxName: HiveService.brandsBox,
///   key: 'brands_list',
///   list: brands,
///   expiry: Duration(hours: 24),
/// );
/// ```
/// 
/// 2️⃣ للـ Single Object (User Profile):
/// ```dart
/// await HiveService.instance.saveObjectWithCache(
///   boxName: HiveService.userBox,
///   key: 'user_profile',
///   object: userJson,
///   expiry: Duration(hours: 1),
/// );
/// ```
/// 
/// 3️⃣ للـ Settings (Theme, Language):
/// ```dart
/// await HiveService.instance.save(
///   boxName: HiveService.settingsBox,
///   key: 'theme_mode',
///   value: 'dark',
/// );
/// ```
/// ========================================================

