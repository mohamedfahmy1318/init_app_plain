import 'package:flutter/material.dart';

/// Service to monitor app lifecycle states
/// Tracks when app goes to background, foreground, etc.
class AppLifecycleService with WidgetsBindingObserver {
  static final AppLifecycleService _instance = AppLifecycleService._internal();
  factory AppLifecycleService() => _instance;
  AppLifecycleService._internal();

  AppLifecycleState? _currentState;
  final List<Function(AppLifecycleState)> _listeners = [];

  /// Get current lifecycle state
  AppLifecycleState? get currentState => _currentState;

  /// Check if app is in foreground
  bool get isInForeground => _currentState == AppLifecycleState.resumed;

  /// Check if app is in background
  bool get isInBackground =>
      _currentState == AppLifecycleState.paused ||
      _currentState == AppLifecycleState.inactive ||
      _currentState == AppLifecycleState.detached;

  /// Initialize the service
  void init() {
    WidgetsBinding.instance.addObserver(this);
    _currentState = WidgetsBinding.instance.lifecycleState;
  }

  /// Dispose the service
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _listeners.clear();
  }

  /// Add listener for lifecycle changes
  void addListener(Function(AppLifecycleState) listener) {
    _listeners.add(listener);
  }

  /// Remove listener
  void removeListener(Function(AppLifecycleState) listener) {
    _listeners.remove(listener);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _currentState = state;
    
    // Notify all listeners
    for (var listener in _listeners) {
      listener(state);
    }

    // Log state change (optional)
    debugPrint('App Lifecycle State: $state');
  }

  /// Convenience methods for specific states
  void onResumed(VoidCallback callback) {
    addListener((state) {
      if (state == AppLifecycleState.resumed) {
        callback();
      }
    });
  }

  void onPaused(VoidCallback callback) {
    addListener((state) {
      if (state == AppLifecycleState.paused) {
        callback();
      }
    });
  }

  void onInactive(VoidCallback callback) {
    addListener((state) {
      if (state == AppLifecycleState.inactive) {
        callback();
      }
    });
  }

  void onDetached(VoidCallback callback) {
    addListener((state) {
      if (state == AppLifecycleState.detached) {
        callback();
      }
    });
  }
}
