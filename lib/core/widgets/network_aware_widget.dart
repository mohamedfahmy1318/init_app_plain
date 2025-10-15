/// ========================================================
/// Network Aware Widget - ويدجت مراقبة الإنترنت
/// ========================================================

import 'package:flutter/material.dart';
import '../services/connectivity_service.dart';
import '../di/service_locator.dart';

class NetworkAwareWidget extends StatefulWidget {
  final Widget child;
  final Widget? offlineWidget;
  final bool showOfflineBanner;

  const NetworkAwareWidget({
    super.key,
    required this.child,
    this.offlineWidget,
    this.showOfflineBanner = true,
  });

  @override
  State<NetworkAwareWidget> createState() => _NetworkAwareWidgetState();
}

class _NetworkAwareWidgetState extends State<NetworkAwareWidget> {
  final ConnectivityService _connectivityService = getIt<ConnectivityService>();
  bool _isOnline = true;

  @override
  void initState() {
    super.initState();
    _checkConnection();
    _listenToConnectionChanges();
  }

  void _checkConnection() async {
    _isOnline = await _connectivityService.hasConnection();
    if (mounted) setState(() {});
  }

  void _listenToConnectionChanges() {
    _connectivityService.connectionStream?.listen((isConnected) {
      if (mounted) {
        setState(() {
          _isOnline = isConnected;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isOnline && widget.offlineWidget != null) {
      return widget.offlineWidget!;
    }

    if (!_isOnline && widget.showOfflineBanner) {
      return Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            color: Colors.red,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.wifi_off, color: Colors.white, size: 16),
                SizedBox(width: 8),
                Text(
                  'لا يوجد اتصال بالإنترنت',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          Expanded(child: widget.child),
        ],
      );
    }

    return widget.child;
  }
}
