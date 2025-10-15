import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

/// Cache item with expiration
class CacheItem<T> {
  final T data;
  final DateTime timestamp;
  final Duration? ttl;

  CacheItem({
    required this.data,
    required this.timestamp,
    this.ttl,
  });

  bool get isExpired {
    if (ttl == null) return false;
    return DateTime.now().difference(timestamp) > ttl!;
  }

  Map<String, dynamic> toJson() => {
        'data': data,
        'timestamp': timestamp.toIso8601String(),
        'ttl': ttl?.inSeconds,
      };

  factory CacheItem.fromJson(Map<String, dynamic> json, T Function(dynamic) fromJson) {
    return CacheItem<T>(
      data: fromJson(json['data']),
      timestamp: DateTime.parse(json['timestamp']),
      ttl: json['ttl'] != null ? Duration(seconds: json['ttl']) : null,
    );
  }
}

/// Advanced Cache Manager Service
class CacheManagerService {
  static const String _cachePrefix = 'cache_';
  static const int _maxCacheSize = 100; // Maximum number of cache items
  final SharedPreferences _prefs;

  CacheManagerService(this._prefs);

  /// Save data to cache with optional TTL
  Future<bool> set<T>({
    required String key,
    required T data,
    Duration? ttl,
  }) async {
    try {
      // Check cache size
      await _cleanupIfNeeded();

      final cacheItem = CacheItem<T>(
        data: data,
        timestamp: DateTime.now(),
        ttl: ttl,
      );

      final jsonString = jsonEncode(cacheItem.toJson());
      return await _prefs.setString('$_cachePrefix$key', jsonString);
    } catch (e) {
      return false;
    }
  }

  /// Get data from cache
  T? get<T>({
    required String key,
    required T Function(dynamic) fromJson,
  }) {
    try {
      final jsonString = _prefs.getString('$_cachePrefix$key');
      if (jsonString == null) return null;

      final json = jsonDecode(jsonString);
      final cacheItem = CacheItem<T>.fromJson(json, fromJson);

      // Check if expired
      if (cacheItem.isExpired) {
        remove(key);
        return null;
      }

      return cacheItem.data;
    } catch (e) {
      return null;
    }
  }

  /// Remove specific cache item
  Future<bool> remove(String key) async {
    return await _prefs.remove('$_cachePrefix$key');
  }

  /// Clear all cache
  Future<bool> clearAll() async {
    final keys = _prefs.getKeys().where((key) => key.startsWith(_cachePrefix));
    for (var key in keys) {
      await _prefs.remove(key);
    }
    return true;
  }

  /// Clear expired cache items
  Future<void> clearExpired() async {
    final keys = _prefs.getKeys().where((key) => key.startsWith(_cachePrefix));
    
    for (var key in keys) {
      try {
        final jsonString = _prefs.getString(key);
        if (jsonString != null) {
          final json = jsonDecode(jsonString);
          final timestamp = DateTime.parse(json['timestamp']);
          final ttlSeconds = json['ttl'] as int?;

          if (ttlSeconds != null) {
            final ttl = Duration(seconds: ttlSeconds);
            final isExpired = DateTime.now().difference(timestamp) > ttl;
            if (isExpired) {
              await _prefs.remove(key);
            }
          }
        }
      } catch (e) {
        // If error parsing, remove the item
        await _prefs.remove(key);
      }
    }
  }

  /// Get cache size
  int getCacheSize() {
    return _prefs.getKeys().where((key) => key.startsWith(_cachePrefix)).length;
  }

  /// Check if cache exists and is valid
  bool has(String key) {
    final jsonString = _prefs.getString('$_cachePrefix$key');
    if (jsonString == null) return false;

    try {
      final json = jsonDecode(jsonString);
      final timestamp = DateTime.parse(json['timestamp']);
      final ttlSeconds = json['ttl'] as int?;

      if (ttlSeconds != null) {
        final ttl = Duration(seconds: ttlSeconds);
        return DateTime.now().difference(timestamp) <= ttl;
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  /// Cleanup cache if size exceeds limit
  Future<void> _cleanupIfNeeded() async {
    final cacheSize = getCacheSize();
    if (cacheSize >= _maxCacheSize) {
      // Remove oldest items
      final keys = _prefs.getKeys().where((key) => key.startsWith(_cachePrefix)).toList();
      
      // Sort by timestamp (oldest first)
      keys.sort((a, b) {
        try {
          final jsonA = jsonDecode(_prefs.getString(a)!);
          final jsonB = jsonDecode(_prefs.getString(b)!);
          final timestampA = DateTime.parse(jsonA['timestamp']);
          final timestampB = DateTime.parse(jsonB['timestamp']);
          return timestampA.compareTo(timestampB);
        } catch (e) {
          return 0;
        }
      });

      // Remove 20% of oldest items
      final itemsToRemove = (cacheSize * 0.2).ceil();
      for (var i = 0; i < itemsToRemove && i < keys.length; i++) {
        await _prefs.remove(keys[i]);
      }
    }
  }

  /// Get cache with auto-refresh
  Future<T?> getOrFetch<T>({
    required String key,
    required Future<T> Function() fetchFunction,
    required T Function(dynamic) fromJson,
    Duration? ttl,
  }) async {
    // Try to get from cache first
    final cached = get<T>(key: key, fromJson: fromJson);
    if (cached != null) return cached;

    // Fetch fresh data
    try {
      final freshData = await fetchFunction();
      await set(key: key, data: freshData, ttl: ttl);
      return freshData;
    } catch (e) {
      return null;
    }
  }
}
