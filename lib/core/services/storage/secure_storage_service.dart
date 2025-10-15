/// ========================================================
/// Secure Storage Service - خدمة التخزين الآمن
/// ========================================================
/// مسؤولة عن تخزين البيانات الحساسة بشكل آمن (Tokens, Passwords, etc.)
/// ========================================================

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static final SecureStorageService _instance = SecureStorageService._internal();
  factory SecureStorageService() => _instance;
  SecureStorageService._internal();

  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock,
    ),
  );

  // ==================== Write ====================
  Future<void> write(String key, String value) async {
    try {
      await _storage.write(key: key, value: value);
    } catch (e) {
      throw Exception('Failed to write to secure storage: $e');
    }
  }

  // ==================== Read ====================
  Future<String?> read(String key) async {
    try {
      return await _storage.read(key: key);
    } catch (e) {
      throw Exception('Failed to read from secure storage: $e');
    }
  }

  // ==================== Delete ====================
  Future<void> delete(String key) async {
    try {
      await _storage.delete(key: key);
    } catch (e) {
      throw Exception('Failed to delete from secure storage: $e');
    }
  }

  // ==================== Delete All ====================
  Future<void> deleteAll() async {
    try {
      await _storage.deleteAll();
    } catch (e) {
      throw Exception('Failed to delete all from secure storage: $e');
    }
  }

  // ==================== Contains Key ====================
  Future<bool> containsKey(String key) async {
    try {
      return await _storage.containsKey(key: key);
    } catch (e) {
      throw Exception('Failed to check key in secure storage: $e');
    }
  }

  // ==================== Read All ====================
  Future<Map<String, String>> readAll() async {
    try {
      return await _storage.readAll();
    } catch (e) {
      throw Exception('Failed to read all from secure storage: $e');
    }
  }
}
