import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';

/// ========================================================
/// Map Helper - مساعد الخرائط
/// ========================================================
/// مجموعة شاملة من الوظائف لتسهيل العمل مع Google Maps
///
/// الوظائف:
/// - ✅ الحصول على الموقع الحالي
/// - ✅ التحقق من صلاحيات الموقع
/// - ✅ تحويل الإحداثيات إلى عنوان والعكس
/// - ✅ حساب المسافة بين نقطتين
/// - ✅ فتح الخريطة في تطبيقات خارجية
/// - ✅ إنشاء Markers مخصصة
/// - ✅ رسم المسارات (Polylines)
/// - ✅ إنشاء دوائر ومستطيلات
/// ========================================================

class MapHelper {
  // ==================== الموقع الحالي ====================

  /// الحصول على الموقع الحالي للمستخدم
  static Future<Position?> getCurrentLocation() async {
    try {
      // التحقق من تفعيل خدمة الموقع
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw 'خدمة الموقع غير مفعلة. الرجاء تفعيلها من الإعدادات.';
      }

      // التحقق من الصلاحيات
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw 'تم رفض صلاحية الوصول للموقع';
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw 'صلاحيات الموقع مرفوضة بشكل دائم. الرجاء تفعيلها من الإعدادات.';
      }

      // الحصول على الموقع
      return await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 10,
        ),
      );
    } catch (e) {
      debugPrint('❌ خطأ في الحصول على الموقع: $e');
      return null;
    }
  }

  /// مراقبة تغيرات الموقع بشكل مباشر
  static Stream<Position> getLocationStream({
    LocationAccuracy accuracy = LocationAccuracy.high,
    int distanceFilter = 10,
  }) {
    return Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: accuracy,
        distanceFilter: distanceFilter,
      ),
    );
  }

  /// التحقق من صلاحيات الموقع
  static Future<bool> checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  /// طلب صلاحيات الموقع
  static Future<bool> requestLocationPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  /// فتح إعدادات الموقع
  static Future<void> openLocationSettings() async {
    await Geolocator.openLocationSettings();
  }

  // ==================== Geocoding ====================

  /// تحويل الإحداثيات إلى عنوان (Reverse Geocoding)
  static Future<String?> getAddressFromCoordinates(
    double latitude,
    double longitude,
  ) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        latitude,
        longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        return _formatAddress(place);
      }
      return null;
    } catch (e) {
      debugPrint('❌ خطأ في تحويل الإحداثيات: $e');
      return null;
    }
  }

  /// تحويل العنوان إلى إحداثيات (Forward Geocoding)
  static Future<LatLng?> getCoordinatesFromAddress(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);

      if (locations.isNotEmpty) {
        return LatLng(locations.first.latitude, locations.first.longitude);
      }
      return null;
    } catch (e) {
      debugPrint('❌ خطأ في تحويل العنوان: $e');
      return null;
    }
  }

  /// الحصول على تفاصيل العنوان الكاملة
  static Future<Placemark?> getPlacemarkDetails(
    double latitude,
    double longitude,
  ) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        latitude,
        longitude,
      );
      return placemarks.isNotEmpty ? placemarks.first : null;
    } catch (e) {
      debugPrint('❌ خطأ في الحصول على تفاصيل العنوان: $e');
      return null;
    }
  }

  /// تنسيق العنوان من Placemark
  static String _formatAddress(Placemark place) {
    List<String> parts = [];

    if (place.street?.isNotEmpty ?? false) parts.add(place.street!);
    if (place.subLocality?.isNotEmpty ?? false) parts.add(place.subLocality!);
    if (place.locality?.isNotEmpty ?? false) parts.add(place.locality!);
    if (place.administrativeArea?.isNotEmpty ?? false) {
      parts.add(place.administrativeArea!);
    }
    if (place.country?.isNotEmpty ?? false) parts.add(place.country!);

    return parts.join(', ');
  }

  // ==================== المسافة والاتجاهات ====================

  /// حساب المسافة بين نقطتين (بالمتر)
  static double calculateDistance(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    return Geolocator.distanceBetween(lat1, lon1, lat2, lon2);
  }

  /// حساب المسافة بين نقطتين وإرجاعها بتنسيق قابل للقراءة
  static String getFormattedDistance(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    double distanceInMeters = calculateDistance(lat1, lon1, lat2, lon2);

    if (distanceInMeters < 1000) {
      return '${distanceInMeters.toStringAsFixed(0)} متر';
    } else {
      double distanceInKm = distanceInMeters / 1000;
      return '${distanceInKm.toStringAsFixed(1)} كم';
    }
  }

  /// حساب الاتجاه بين نقطتين (بالدرجات)
  static double calculateBearing(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    return Geolocator.bearingBetween(lat1, lon1, lat2, lon2);
  }

  /// التحقق من وجود نقطة داخل نطاق معين (radius بالمتر)
  static bool isLocationInRadius(
    double centerLat,
    double centerLon,
    double checkLat,
    double checkLon,
    double radiusInMeters,
  ) {
    double distance = calculateDistance(
      centerLat,
      centerLon,
      checkLat,
      checkLon,
    );
    return distance <= radiusInMeters;
  }

  // ==================== فتح الخرائط الخارجية ====================

  /// فتح Google Maps لعرض موقع محدد
  static Future<bool> openInGoogleMaps({
    required double latitude,
    required double longitude,
    String? label,
  }) async {
    final url = label != null
        ? 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude&query_place_id=$label'
        : 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

    return await _launchUrl(url);
  }

  /// فتح الملاحة في Google Maps (الاتجاهات)
  static Future<bool> openNavigationInGoogleMaps({
    required double destinationLat,
    required double destinationLon,
    double? originLat,
    double? originLon,
    TravelMode travelMode = TravelMode.driving,
  }) async {
    String origin = originLat != null && originLon != null
        ? '$originLat,$originLon'
        : 'current+location';

    String mode = _getTravelModeString(travelMode);

    final url =
        'https://www.google.com/maps/dir/?api=1&origin=$origin&destination=$destinationLat,$destinationLon&travelmode=$mode';

    return await _launchUrl(url);
  }

  /// فتح Apple Maps (iOS)
  static Future<bool> openInAppleMaps({
    required double latitude,
    required double longitude,
    String? label,
  }) async {
    final url = label != null
        ? 'http://maps.apple.com/?ll=$latitude,$longitude&q=$label'
        : 'http://maps.apple.com/?ll=$latitude,$longitude';

    return await _launchUrl(url);
  }

  /// فتح Waze للملاحة
  static Future<bool> openInWaze({
    required double latitude,
    required double longitude,
  }) async {
    final url = 'https://waze.com/ul?ll=$latitude,$longitude&navigate=yes';
    return await _launchUrl(url);
  }

  static Future<bool> _launchUrl(String url) async {
    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        return await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
      return false;
    } catch (e) {
      debugPrint('❌ خطأ في فتح الرابط: $e');
      return false;
    }
  }

  static String _getTravelModeString(TravelMode mode) {
    switch (mode) {
      case TravelMode.driving:
        return 'driving';
      case TravelMode.walking:
        return 'walking';
      case TravelMode.bicycling:
        return 'bicycling';
      case TravelMode.transit:
        return 'transit';
    }
  }

  // ==================== Markers المخصصة ====================

  /// إنشاء Marker من أيقونة Asset
  static Future<BitmapDescriptor> createMarkerFromAsset(
    String assetPath, {
    int width = 100,
    int height = 100,
  }) async {
    try {
      final bytes = await rootBundle.load(assetPath);
      final ui.Codec codec = await ui.instantiateImageCodec(
        bytes.buffer.asUint8List(),
        targetWidth: width,
        targetHeight: height,
      );
      final ui.FrameInfo frameInfo = await codec.getNextFrame();
      final ByteData? byteData = await frameInfo.image.toByteData(
        format: ui.ImageByteFormat.png,
      );
      return BitmapDescriptor.fromBytes(byteData!.buffer.asUint8List());
    } catch (e) {
      debugPrint('❌ خطأ في إنشاء Marker: $e');
      return BitmapDescriptor.defaultMarker;
    }
  }

  /// إنشاء Marker ملون
  static BitmapDescriptor createColoredMarker(MarkerColor color) {
    switch (color) {
      case MarkerColor.red:
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
      case MarkerColor.blue:
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);
      case MarkerColor.green:
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
      case MarkerColor.yellow:
        return BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueYellow,
        );
      case MarkerColor.orange:
        return BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueOrange,
        );
      case MarkerColor.violet:
        return BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueViolet,
        );
      case MarkerColor.cyan:
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan);
    }
  }

  // ==================== المسارات (Polylines) ====================

  /// إنشاء Polyline بين نقطتين
  static Polyline createPolyline({
    required String polylineId,
    required List<LatLng> points,
    Color color = Colors.blue,
    int width = 5,
    bool geodesic = true,
  }) {
    return Polyline(
      polylineId: PolylineId(polylineId),
      points: points,
      color: color,
      width: width,
      geodesic: geodesic,
    );
  }

  /// إنشاء Polyline مع نمط متقطع (Dashed)
  static Polyline createDashedPolyline({
    required String polylineId,
    required List<LatLng> points,
    Color color = Colors.blue,
    int width = 5,
  }) {
    return Polyline(
      polylineId: PolylineId(polylineId),
      points: points,
      color: color,
      width: width,
      patterns: [PatternItem.dash(20), PatternItem.gap(10)],
    );
  }

  // ==================== الدوائر والمستطيلات ====================

  /// إنشاء دائرة على الخريطة
  static Circle createCircle({
    required String circleId,
    required LatLng center,
    required double radiusInMeters,
    Color strokeColor = Colors.blue,
    int strokeWidth = 2,
    Color fillColor = const Color(0x220000FF),
  }) {
    return Circle(
      circleId: CircleId(circleId),
      center: center,
      radius: radiusInMeters,
      strokeColor: strokeColor,
      strokeWidth: strokeWidth,
      fillColor: fillColor,
    );
  }

  /// إنشاء مستطيل على الخريطة
  static Polygon createRectangle({
    required String polygonId,
    required LatLng northEast,
    required LatLng southWest,
    Color strokeColor = Colors.blue,
    int strokeWidth = 2,
    Color fillColor = const Color(0x220000FF),
  }) {
    return Polygon(
      polygonId: PolygonId(polygonId),
      points: [
        LatLng(northEast.latitude, southWest.longitude), // NW
        northEast, // NE
        LatLng(southWest.latitude, northEast.longitude), // SE
        southWest, // SW
      ],
      strokeColor: strokeColor,
      strokeWidth: strokeWidth,
      fillColor: fillColor,
    );
  }

  /// إنشاء شكل حر (Polygon)
  static Polygon createPolygon({
    required String polygonId,
    required List<LatLng> points,
    Color strokeColor = Colors.blue,
    int strokeWidth = 2,
    Color fillColor = const Color(0x220000FF),
  }) {
    return Polygon(
      polygonId: PolygonId(polygonId),
      points: points,
      strokeColor: strokeColor,
      strokeWidth: strokeWidth,
      fillColor: fillColor,
    );
  }

  // ==================== Camera Movement ====================

  /// تحريك الكاميرا لموقع محدد
  static Future<void> animateCamera(
    GoogleMapController controller,
    LatLng target, {
    double zoom = 14.0,
  }) async {
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: target, zoom: zoom),
      ),
    );
  }

  /// تحريك الكاميرا لعرض جميع النقاط
  static Future<void> animateCameraToFitBounds(
    GoogleMapController controller,
    List<LatLng> points, {
    double padding = 50,
  }) async {
    if (points.isEmpty) return;

    double minLat = points.first.latitude;
    double maxLat = points.first.latitude;
    double minLng = points.first.longitude;
    double maxLng = points.first.longitude;

    for (var point in points) {
      if (point.latitude < minLat) minLat = point.latitude;
      if (point.latitude > maxLat) maxLat = point.latitude;
      if (point.longitude < minLng) minLng = point.longitude;
      if (point.longitude > maxLng) maxLng = point.longitude;
    }

    await controller.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          southwest: LatLng(minLat, minLng),
          northeast: LatLng(maxLat, maxLng),
        ),
        padding,
      ),
    );
  }

  // ==================== معلومات إضافية ====================

  /// تحويل LatLng إلى String
  static String latLngToString(LatLng latLng, {int decimals = 6}) {
    return '${latLng.latitude.toStringAsFixed(decimals)}, ${latLng.longitude.toStringAsFixed(decimals)}';
  }

  /// تحويل String إلى LatLng
  static LatLng? stringToLatLng(String coordinates) {
    try {
      final parts = coordinates.split(',');
      if (parts.length == 2) {
        return LatLng(
          double.parse(parts[0].trim()),
          double.parse(parts[1].trim()),
        );
      }
      return null;
    } catch (e) {
      debugPrint('❌ خطأ في تحويل النص إلى إحداثيات: $e');
      return null;
    }
  }

  /// الحصول على CameraPosition الافتراضي (الرياض، السعودية)
  static CameraPosition getDefaultCameraPosition() {
    return const CameraPosition(
      target: LatLng(24.7136, 46.6753), // الرياض
      zoom: 14.0,
    );
  }
}

// ==================== Enums ====================

enum TravelMode { driving, walking, bicycling, transit }

enum MarkerColor { red, blue, green, yellow, orange, violet, cyan }
