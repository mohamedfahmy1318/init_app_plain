import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:init_app_flutter/core/widgets/app_widgets.dart';
import 'package:init_app_flutter/core/utils/utils.dart';

/// ========================================================
/// Map Demo Page - صفحة تجريب الخرائط
/// ========================================================
/// صفحة شاملة لتجربة جميع وظائف الخرائط
/// ========================================================

class MapDemoPage extends StatefulWidget {
  const MapDemoPage({super.key});

  @override
  State<MapDemoPage> createState() => _MapDemoPageState();
}

class _MapDemoPageState extends State<MapDemoPage> {
  GoogleMapController? _controller;
  LatLng? _currentLocation;
  String? _currentAddress;
  bool _isLoadingLocation = false;
  MapType _mapType = MapType.normal;
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  Set<Circle> _circles = {};

  @override
  void initState() {
    super.initState();
    _loadCurrentLocation();
  }

  Future<void> _loadCurrentLocation() async {
    setState(() => _isLoadingLocation = true);

    Position? position = await MapHelper.getCurrentLocation();

    if (position != null && mounted) {
      final location = LatLng(position.latitude, position.longitude);
      setState(() {
        _currentLocation = location;
      });

      _loadAddress(location);

      // إضافة Marker للموقع الحالي
      _addMarker(
        'current_location',
        location,
        'موقعك الحالي',
        'أنت هنا الآن',
        MarkerColor.blue,
      );

      // تحريك الكاميرا
      if (_controller != null) {
        MapHelper.animateCamera(_controller!, location, zoom: 15);
      }
    }

    setState(() => _isLoadingLocation = false);
  }

  Future<void> _loadAddress(LatLng location) async {
    final address = await MapHelper.getAddressFromCoordinates(
      location.latitude,
      location.longitude,
    );

    if (mounted) {
      setState(() => _currentAddress = address);
    }
  }

  void _addMarker(
    String id,
    LatLng position,
    String title,
    String snippet,
    MarkerColor color,
  ) {
    final newMarker = Marker(
      markerId: MarkerId(id),
      position: position,
      infoWindow: InfoWindow(title: title, snippet: snippet),
      icon: MapHelper.createColoredMarker(color),
    );

    setState(() {
      _markers = Set.from(_markers)..add(newMarker);
    });
  }

  void _addCircle(LatLng center, double radiusInMeters) {
    final newCircle = MapHelper.createCircle(
      circleId: 'circle_${_circles.length}',
      center: center,
      radiusInMeters: radiusInMeters,
      strokeColor: Colors.blue,
      fillColor: Colors.blue.withOpacity(0.2),
    );

    setState(() {
      _circles = Set.from(_circles)..add(newCircle);
    });
  }

  void _addPolyline(List<LatLng> points) {
    final newPolyline = MapHelper.createPolyline(
      polylineId: 'polyline_${_polylines.length}',
      points: points,
      color: Colors.red,
      width: 5,
    );

    setState(() {
      _polylines = Set.from(_polylines)..add(newPolyline);
    });
  }

  void _clearAll() {
    setState(() {
      _markers = {};
      _polylines = {};
      _circles = {};
    });
    ToastHelper.success('تم مسح جميع العناصر');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تجريب الخرائط'),
        actions: [
          // تغيير نوع الخريطة
          PopupMenuButton<MapType>(
            icon: const Icon(Icons.map),
            onSelected: (type) {
              setState(() => _mapType = type);
              ToastHelper.info('تم تغيير نوع الخريطة');
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: MapType.normal, child: Text('عادي')),
              const PopupMenuItem(
                value: MapType.satellite,
                child: Text('قمر صناعي'),
              ),
              const PopupMenuItem(value: MapType.hybrid, child: Text('هجين')),
              const PopupMenuItem(
                value: MapType.terrain,
                child: Text('تضاريس'),
              ),
            ],
          ),
          // مسح الكل
          IconButton(icon: const Icon(Icons.clear_all), onPressed: _clearAll),
        ],
      ),
      body: Stack(
        children: [
          // الخريطة
          if (_currentLocation != null)
            CustomMapWidget(
              initialPosition: _currentLocation!,
              initialZoom: 14,
              mapType: _mapType,
              markers: _markers,
              polylines: _polylines,
              circles: _circles,
              onMapCreated: (controller) => _controller = controller,
              onMapTap: (location) {
                _showLocationOptions(location);
              },
              onMapLongPress: (location) {
                _addMarker(
                  'marker_${_markers.length}',
                  location,
                  'موقع جديد',
                  MapHelper.latLngToString(location),
                  MarkerColor.red,
                );
                ToastHelper.success('تم إضافة Marker');
              },
            )
          else if (_isLoadingLocation)
            const Center(child: CircularProgressIndicator())
          else
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.location_off, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text('لم يتم الحصول على الموقع'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _loadCurrentLocation,
                    child: const Text('إعادة المحاولة'),
                  ),
                ],
              ),
            ),

          // معلومات الموقع الحالي
          if (_currentLocation != null)
            Positioned(
              top: 16,
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
                        'الموقع الحالي',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (_currentAddress != null)
                        Text(_currentAddress!)
                      else
                        const Text('جاري تحميل العنوان...'),
                      const SizedBox(height: 4),
                      Text(
                        MapHelper.latLngToString(_currentLocation!),
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // اختيار موقع
          FloatingActionButton.extended(
            heroTag: 'pick_location',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LocationPickerWidget(
                    initialLocation: _currentLocation,
                    onLocationPicked: (location, address) {
                      setState(() {
                        _currentLocation = location;
                        _currentAddress = address;
                      });
                      _addMarker(
                        'picked_location',
                        location,
                        'الموقع المختار',
                        address ?? MapHelper.latLngToString(location),
                        MarkerColor.green,
                      );
                      if (_controller != null) {
                        MapHelper.animateCamera(_controller!, location);
                      }
                      ToastHelper.success('تم اختيار الموقع');
                    },
                  ),
                ),
              );
            },
            label: const Text('اختر موقع'),
            icon: const Icon(Icons.place),
          ),
          SizedBox(height: 12.h),

          // خيارات إضافية
          FloatingActionButton(
            heroTag: 'more_options',
            onPressed: () => _showMoreOptions(),
            child: const Icon(Icons.more_horiz),
          ),
          SizedBox(height: 12.h),

          // الموقع الحالي
          FloatingActionButton(
            heroTag: 'my_location',
            onPressed: _loadCurrentLocation,
            child: const Icon(Icons.my_location),
          ),
        ],
      ),
    );
  }

  void _showLocationOptions(LatLng location) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'خيارات الموقع',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.h),
            ListTile(
              leading: const Icon(Icons.place, color: Colors.blue),
              title: const Text('إضافة Marker'),
              onTap: () {
                Navigator.pop(context);
                _addMarker(
                  'marker_${_markers.length}',
                  location,
                  'موقع جديد',
                  MapHelper.latLngToString(location),
                  MarkerColor.red,
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.circle, color: Colors.blue),
              title: const Text('إضافة دائرة (500م)'),
              onTap: () {
                Navigator.pop(context);
                _addCircle(location, 500);
              },
            ),
            ListTile(
              leading: const Icon(Icons.info, color: Colors.blue),
              title: const Text('معلومات الموقع'),
              onTap: () async {
                Navigator.pop(context);
                final address = await MapHelper.getAddressFromCoordinates(
                  location.latitude,
                  location.longitude,
                );
                if (mounted) {
                  DialogHelper.showCustom(
                    context,
                    title: 'معلومات الموقع',
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'الإحداثيات:\n${MapHelper.latLngToString(location)}',
                        ),
                        const SizedBox(height: 8),
                        if (address != null) Text('العنوان:\n$address'),
                      ],
                    ),
                  );
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.navigation, color: Colors.blue),
              title: const Text('فتح في Google Maps'),
              onTap: () {
                Navigator.pop(context);
                MapHelper.openNavigationInGoogleMaps(
                  destinationLat: location.latitude,
                  destinationLon: location.longitude,
                  originLat: _currentLocation?.latitude,
                  originLon: _currentLocation?.longitude,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showMoreOptions() {
    BottomSheetHelper.showList(
      context: context,
      title: 'خيارات إضافية',
      items: [
        BottomSheetItem(
          value: 'calculate_distance',
          title: 'حساب المسافة',
          subtitle: 'بين نقطتين',
          icon: Icons.straighten,
        ),
        BottomSheetItem(
          value: 'draw_route',
          title: 'رسم مسار',
          subtitle: 'بين الـ Markers',
          icon: Icons.route,
        ),
        BottomSheetItem(
          value: 'search_location',
          title: 'بحث عن موقع',
          subtitle: 'بالعنوان',
          icon: Icons.search,
        ),
        BottomSheetItem(
          value: 'open_settings',
          title: 'إعدادات الموقع',
          subtitle: 'فتح الإعدادات',
          icon: Icons.settings,
        ),
      ],
    ).then((value) {
      if (value == null) return;

      switch (value) {
        case 'calculate_distance':
          _calculateDistanceBetweenMarkers();
          break;
        case 'draw_route':
          _drawRouteBetweenMarkers();
          break;
        case 'search_location':
          _searchLocation();
          break;
        case 'open_settings':
          MapHelper.openLocationSettings();
          break;
      }
    });
  }

  void _calculateDistanceBetweenMarkers() {
    if (_markers.length < 2) {
      ToastHelper.warning('يجب إضافة Marker على الأقل');
      return;
    }

    final markersList = _markers.toList();
    final point1 = markersList[0].position;
    final point2 = markersList[1].position;

    final distance = MapHelper.getFormattedDistance(
      point1.latitude,
      point1.longitude,
      point2.latitude,
      point2.longitude,
    );

    DialogHelper.showSuccess(
      context,
      title: 'المسافة',
      message: 'المسافة بين النقطتين:\n$distance',
    );
  }

  void _drawRouteBetweenMarkers() {
    if (_markers.length < 2) {
      ToastHelper.warning('يجب إضافة Marker على الأقل');
      return;
    }

    final points = _markers.map((m) => m.position).toList();
    _addPolyline(points);

    // تحريك الكاميرا لعرض جميع النقاط
    if (_controller != null) {
      MapHelper.animateCameraToFitBounds(_controller!, points, padding: 100);
    }

    ToastHelper.success('تم رسم المسار');
  }

  void _searchLocation() async {
    final controller = TextEditingController();

    DialogHelper.showCustom(
      context,
      title: 'بحث عن موقع',
      content: TextField(
        controller: controller,
        decoration: const InputDecoration(
          hintText: 'أدخل العنوان',
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('إلغاء'),
        ),
        ElevatedButton(
          onPressed: () async {
            final address = controller.text.trim();
            if (address.isEmpty) return;

            Navigator.pop(context);
            DialogHelper.showLoading(context, message: 'جاري البحث...');

            final location = await MapHelper.getCoordinatesFromAddress(address);

            if (mounted) {
              DialogHelper.hide(context);

              if (location != null) {
                _addMarker(
                  'search_result',
                  location,
                  'نتيجة البحث',
                  address,
                  MarkerColor.green,
                );

                if (_controller != null) {
                  MapHelper.animateCamera(_controller!, location, zoom: 15);
                }

                ToastHelper.success('تم العثور على الموقع');
              } else {
                ToastHelper.error('لم يتم العثور على الموقع');
              }
            }
          },
          child: const Text('بحث'),
        ),
      ],
    );
  }
}
