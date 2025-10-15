/// ========================================================
/// Local Storage Service - خدمة التخزين المحلي
/// ========================================================
/// مسؤولة عن تخزين البيانات العادية (Settings, Preferences, etc.)
/// ========================================================

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static final LocalStorageService _instance = LocalStorageService._internal();
  factory LocalStorageService() => _instance;
  LocalStorageService._internal();

  SharedPreferences? _prefs;

  // ==================== Initialize ====================
  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  SharedPreferences get prefs {
    if (_prefs == null) {
      throw Exception('LocalStorageService not initialized. Call init() first.');
    }
    return _prefs!;
  }

  // ==================== String ====================
  Future<bool> setString(String key, String value) async {
    return await prefs.setString(key, value);
  }

  String? getString(String key, {String? defaultValue}) {
    return prefs.getString(key) ?? defaultValue;
  }

  // ==================== Int ====================
  Future<bool> setInt(String key, int value) async {
    return await prefs.setInt(key, value);
  }

  int? getInt(String key, {int? defaultValue}) {
    return prefs.getInt(key) ?? defaultValue;
  }

  // ==================== Double ====================
  Future<bool> setDouble(String key, double value) async {
    return await prefs.setDouble(key, value);
  }

  double? getDouble(String key, {double? defaultValue}) {
    return prefs.getDouble(key) ?? defaultValue;
  }

  // ==================== Bool ====================
  Future<bool> setBool(String key, bool value) async {
    return await prefs.setBool(key, value);
  }

  bool? getBool(String key, {bool? defaultValue}) {
    return prefs.getBool(key) ?? defaultValue;
  }

  // ==================== List<String> ====================
  Future<bool> setStringList(String key, List<String> value) async {
    return await prefs.setStringList(key, value);
  }

  List<String>? getStringList(String key) {
    return prefs.getStringList(key);
  }

  // ==================== Remove ====================
  Future<bool> remove(String key) async {
    return await prefs.remove(key);
  }

  // ==================== Clear All ====================
  Future<bool> clear() async {
    return await prefs.clear();
  }

  // ==================== Contains Key ====================
  bool containsKey(String key) {
    return prefs.containsKey(key);
  }

  // ==================== Get All Keys ====================
  Set<String> getKeys() {
    return prefs.getKeys();
  }
}
