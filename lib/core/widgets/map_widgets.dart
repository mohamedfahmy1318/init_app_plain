import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:bainona/core/utils/map_helper.dart';
import 'dart:async';

/// ========================================================
/// Custom Map Widget - ويدجت الخريطة المخصص
/// ========================================================
/// خريطة جاهزة مع جميع المميزات الأساسية
/// ========================================================

class CustomMapWidget extends StatefulWidget {
  final LatLng initialPosition;
  final double initialZoom;
  final MapType mapType;
  final bool myLocationEnabled;
  final bool myLocationButtonEnabled;
  final bool zoomControlsEnabled;
  final bool rotateGesturesEnabled;
  final bool scrollGesturesEnabled;
  final bool tiltGesturesEnabled;
  final bool zoomGesturesEnabled;
  final Set<Marker>? markers;
  final Set<Polyline>? polylines;
  final Set<Polygon>? polygons;
  final Set<Circle>? circles;
  final Function(LatLng)? onMapTap;
  final Function(LatLng)? onMapLongPress;
  final Function(GoogleMapController)? onMapCreated;
  final Function(Marker)? onMarkerTap;
  final CameraPosition? initialCameraPosition;

  const CustomMapWidget({
    super.key,
    this.initialPosition = const LatLng(24.7136, 46.6753), // الرياض
    this.initialZoom = 14.0,
    this.mapType = MapType.normal,
    this.myLocationEnabled = true,
    this.myLocationButtonEnabled = true,
    this.zoomControlsEnabled = true,
    this.rotateGesturesEnabled = true,
    this.scrollGesturesEnabled = true,
    this.tiltGesturesEnabled = true,
    this.zoomGesturesEnabled = true,
    this.markers,
    this.polylines,
    this.polygons,
    this.circles,
    this.onMapTap,
    this.onMapLongPress,
    this.onMapCreated,
    this.onMarkerTap,
    this.initialCameraPosition,
  });

  @override
  State<CustomMapWidget> createState() => _CustomMapWidgetState();
}

class _CustomMapWidgetState extends State<CustomMapWidget> {
  GoogleMapController? _controller;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};
  final Set<Polygon> _polygons = {};
  final Set<Circle> _circles = {};

  @override
  void initState() {
    super.initState();
    _initializeMapElements();
  }

  void _initializeMapElements() {
    if (widget.markers != null) {
      _markers.addAll(widget.markers!);
    }
    if (widget.polylines != null) {
      _polylines.addAll(widget.polylines!);
    }
    if (widget.polygons != null) {
      _polygons.addAll(widget.polygons!);
    }
    if (widget.circles != null) {
      _circles.addAll(widget.circles!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition:
          widget.initialCameraPosition ??
          CameraPosition(
            target: widget.initialPosition,
            zoom: widget.initialZoom,
          ),
      mapType: widget.mapType,
      myLocationEnabled: widget.myLocationEnabled,
      myLocationButtonEnabled: widget.myLocationButtonEnabled,
      zoomControlsEnabled: widget.zoomControlsEnabled,
      rotateGesturesEnabled: widget.rotateGesturesEnabled,
      scrollGesturesEnabled: widget.scrollGesturesEnabled,
      tiltGesturesEnabled: widget.tiltGesturesEnabled,
      zoomGesturesEnabled: widget.zoomGesturesEnabled,
      markers: _markers,
      polylines: _polylines,
      polygons: _polygons,
      circles: _circles,
      onMapCreated: (controller) {
        _controller = controller;
        widget.onMapCreated?.call(controller);
      },
      onTap: widget.onMapTap,
      onLongPress: widget.onMapLongPress,
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}

/// ========================================================
/// Location Picker Widget - اختيار موقع من الخريطة
/// ========================================================

class LocationPickerWidget extends StatefulWidget {
  final LatLng? initialLocation;
  final Function(LatLng, String?) onLocationPicked;
  final String confirmButtonText;
  final String cancelButtonText;

  const LocationPickerWidget({
    super.key,
    this.initialLocation,
    required this.onLocationPicked,
    this.confirmButtonText = 'تأكيد الموقع',
    this.cancelButtonText = 'إلغاء',
  });

  @override
  State<LocationPickerWidget> createState() => _LocationPickerWidgetState();
}

class _LocationPickerWidgetState extends State<LocationPickerWidget> {
  late LatLng _selectedLocation;
  GoogleMapController? _controller;
  String? _address;
  bool _isLoadingAddress = false;

  @override
  void initState() {
    super.initState();
    _initializeLocation();
  }

  Future<void> _initializeLocation() async {
    if (widget.initialLocation != null) {
      _selectedLocation = widget.initialLocation!;
    } else {
      // محاولة الحصول على الموقع الحالي
      Position? position = await MapHelper.getCurrentLocation();
      _selectedLocation = position != null
          ? LatLng(position.latitude, position.longitude)
          : const LatLng(24.7136, 46.6753); // الرياض كافتراضي
    }
    if (mounted) {
      setState(() {});
      _loadAddress();
    }
  }

  Future<void> _loadAddress() async {
    setState(() => _isLoadingAddress = true);

    final address = await MapHelper.getAddressFromCoordinates(
      _selectedLocation.latitude,
      _selectedLocation.longitude,
    );

    if (mounted) {
      setState(() {
        _address = address;
        _isLoadingAddress = false;
      });
    }
  }

  void _onMapTap(LatLng location) {
    setState(() {
      _selectedLocation = location;
    });
    _loadAddress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // الخريطة
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _selectedLocation,
              zoom: 15.0,
            ),
            onMapCreated: (controller) => _controller = controller,
            onTap: _onMapTap,
            markers: {
              Marker(
                markerId: const MarkerId('selected_location'),
                position: _selectedLocation,
                draggable: true,
                onDragEnd: (newPosition) {
                  setState(() => _selectedLocation = newPosition);
                  _loadAddress();
                },
              ),
            },
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          ),

          // شريط المعلومات في الأعلى
          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            left: 16,
            right: 16,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'الموقع المحدد',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (_isLoadingAddress)
                      const Row(
                        children: [
                          SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                          SizedBox(width: 8),
                          Text('جاري تحميل العنوان...'),
                        ],
                      )
                    else if (_address != null)
                      Text(_address!, style: const TextStyle(fontSize: 14))
                    else
                      const Text('اضغط على الخريطة لتحديد الموقع'),
                    const SizedBox(height: 4),
                    Text(
                      MapHelper.latLngToString(_selectedLocation),
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // أزرار التحكم في الأسفل
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[300],
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(widget.cancelButtonText),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () {
                      widget.onLocationPicked(_selectedLocation, _address);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(widget.confirmButtonText),
                  ),
                ),
              ],
            ),
          ),

          // زر الموقع الحالي
          Positioned(
            bottom: 100,
            right: 16,
            child: FloatingActionButton(
              mini: true,
              onPressed: () async {
                Position? position = await MapHelper.getCurrentLocation();
                if (position != null && _controller != null) {
                  final newLocation = LatLng(
                    position.latitude,
                    position.longitude,
                  );
                  setState(() => _selectedLocation = newLocation);
                  _loadAddress();
                  MapHelper.animateCamera(_controller!, newLocation);
                }
              },
              child: const Icon(Icons.my_location),
            ),
          ),
        ],
      ),
    );
  }
}

/// ========================================================
/// Map with Current Location Widget
/// ========================================================

class MapWithCurrentLocationWidget extends StatefulWidget {
  final double zoom;
  final MapType mapType;
  final Function(GoogleMapController)? onMapCreated;

  const MapWithCurrentLocationWidget({
    super.key,
    this.zoom = 15.0,
    this.mapType = MapType.normal,
    this.onMapCreated,
  });

  @override
  State<MapWithCurrentLocationWidget> createState() =>
      _MapWithCurrentLocationWidgetState();
}

class _MapWithCurrentLocationWidgetState
    extends State<MapWithCurrentLocationWidget> {
  GoogleMapController? _controller;
  LatLng? _currentLocation;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    Position? position = await MapHelper.getCurrentLocation();

    if (position != null && mounted) {
      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
        _isLoading = false;
      });

      // تحريك الكاميرا للموقع الحالي
      if (_controller != null) {
        MapHelper.animateCamera(
          _controller!,
          _currentLocation!,
          zoom: widget.zoom,
        );
      }
    } else {
      // استخدام موقع افتراضي
      if (mounted) {
        setState(() {
          _currentLocation = const LatLng(24.7136, 46.6753);
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return CustomMapWidget(
      initialPosition: _currentLocation!,
      initialZoom: widget.zoom,
      mapType: widget.mapType,
      markers: {
        Marker(
          markerId: const MarkerId('current_location'),
          position: _currentLocation!,
          infoWindow: const InfoWindow(title: 'موقعك الحالي'),
        ),
      },
      onMapCreated: (controller) {
        _controller = controller;
        widget.onMapCreated?.call(controller);
      },
    );
  }
}
