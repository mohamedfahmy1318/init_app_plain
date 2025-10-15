/// ========================================================
/// Connectivity Service - خدمة الاتصال بالإنترنت
/// ========================================================
/// مراقبة حالة الاتصال بالإنترنت
/// ========================================================

import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class ConnectivityService {
  static final ConnectivityService _instance = ConnectivityService._internal();
  factory ConnectivityService() => _instance;
  ConnectivityService._internal();

  final Connectivity _connectivity = Connectivity();
  final InternetConnection _internetChecker = InternetConnection();

  StreamController<bool>? _connectionStatusController;
  Stream<bool>? _connectionStatusStream;

  bool _isConnected = false;
  bool get isConnected => _isConnected;

  // ==================== Initialize ====================
  Future<void> initialize() async {
    _connectionStatusController = StreamController<bool>.broadcast();
    _connectionStatusStream = _connectionStatusController!.stream;

    // Check initial status
    _isConnected = await hasConnection();

    // Listen to connectivity changes
    _connectivity.onConnectivityChanged.listen((result) async {
      await _updateConnectionStatus();
    });

    // Listen to internet connection changes
    _internetChecker.onStatusChange.listen((status) {
      _isConnected = status == InternetStatus.connected;
      _connectionStatusController?.add(_isConnected);
    });
  }

  // ==================== Check Connection ====================
  Future<bool> hasConnection() async {
    try {
      final connectivityResult = await _connectivity.checkConnectivity();
      
      if (connectivityResult.contains(ConnectivityResult.none)) {
        return false;
      }

      // Double check with internet checker
      return await _internetChecker.hasInternetAccess;
    } catch (e) {
      return false;
    }
  }

  // ==================== Update Connection Status ====================
  Future<void> _updateConnectionStatus() async {
    final hasInternet = await hasConnection();
    _isConnected = hasInternet;
    _connectionStatusController?.add(_isConnected);
  }

  // ==================== Listen to Connection Changes ====================
  Stream<bool>? get connectionStream => _connectionStatusStream;

  // ==================== Dispose ====================
  void dispose() {
    _connectionStatusController?.close();
  }
}
