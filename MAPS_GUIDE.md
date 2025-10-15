# 🗺️ Google Maps Integration - دليل الخرائط الشامل

## 📋 المحتويات

1. [MapHelper - الوظائف المساعدة](#maphelper)
2. [Map Widgets - الواجهات الجاهزة](#map-widgets)
3. [أمثلة عملية](#أمثلة-عملية)
4. [الإعدادات المطلوبة](#الإعدادات)

---

## 🛠️ MapHelper - الوظائف المساعدة

### 1. الموقع الحالي

```dart
// الحصول على الموقع الحالي
Position? position = await MapHelper.getCurrentLocation();

if (position != null) {
  print('Lat: ${position.latitude}, Lng: ${position.longitude}');
}

// مراقبة تغيرات الموقع
MapHelper.getLocationStream().listen((position) {
  print('الموقع تغير: ${position.latitude}, ${position.longitude}');
});

// التحقق من الصلاحيات
bool hasPermission = await MapHelper.checkLocationPermission();

// طلب الصلاحيات
bool granted = await MapHelper.requestLocationPermission();

// فتح الإعدادات
await MapHelper.openLocationSettings();
```

---

### 2. Geocoding - تحويل الإحداثيات والعناوين

```dart
// تحويل الإحداثيات إلى عنوان
String? address = await MapHelper.getAddressFromCoordinates(
  24.7136, // Latitude
  46.6753, // Longitude
);
// النتيجة: "شارع الملك فهد، الرياض، السعودية"

// تحويل العنوان إلى إحداثيات
LatLng? location = await MapHelper.getCoordinatesFromAddress(
  'برج المملكة، الرياض'
);

// الحصول على تفاصيل كاملة
Placemark? details = await MapHelper.getPlacemarkDetails(24.7136, 46.6753);
if (details != null) {
  print('الشارع: ${details.street}');
  print('المدينة: ${details.locality}');
  print('الدولة: ${details.country}');
}
```

---

### 3. حساب المسافات

```dart
// حساب المسافة بالمتر
double distanceInMeters = MapHelper.calculateDistance(
  24.7136, 46.6753, // الرياض
  21.3891, 39.8579, // مكة
);

// الحصول على مسافة منسقة
String distance = MapHelper.getFormattedDistance(
  24.7136, 46.6753,
  21.3891, 39.8579,
);
// النتيجة: "720.5 كم"

// حساب الاتجاه (بالدرجات)
double bearing = MapHelper.calculateBearing(
  24.7136, 46.6753,
  21.3891, 39.8579,
);

// التحقق من وجود نقطة داخل نطاق معين
bool isInRadius = MapHelper.isLocationInRadius(
  24.7136, 46.6753, // المركز
  24.7200, 46.6800, // النقطة للفحص
  5000, // نصف القطر بالمتر (5 كم)
);
```

---

### 4. فتح الخرائط الخارجية

```dart
// فتح موقع في Google Maps
await MapHelper.openInGoogleMaps(
  latitude: 24.7136,
  longitude: 46.6753,
  label: 'برج المملكة',
);

// فتح الملاحة في Google Maps
await MapHelper.openNavigationInGoogleMaps(
  destinationLat: 24.7136,
  destinationLon: 46.6753,
  originLat: 24.6500, // اختياري
  originLon: 46.7000, // اختياري
  travelMode: TravelMode.driving, // driving, walking, bicycling, transit
);

// فتح Apple Maps (iOS)
await MapHelper.openInAppleMaps(
  latitude: 24.7136,
  longitude: 46.6753,
);

// فتح Waze
await MapHelper.openInWaze(
  latitude: 24.7136,
  longitude: 46.6753,
);
```

---

### 5. Markers المخصصة

```dart
// إنشاء Marker ملون
BitmapDescriptor redMarker = MapHelper.createColoredMarker(MarkerColor.red);
BitmapDescriptor blueMarker = MapHelper.createColoredMarker(MarkerColor.blue);

// إنشاء Marker من صورة
BitmapDescriptor customMarker = await MapHelper.createMarkerFromAsset(
  'assets/images/marker.png',
  width: 100,
  height: 100,
);

// استخدام في Marker
Marker marker = Marker(
  markerId: MarkerId('my_marker'),
  position: LatLng(24.7136, 46.6753),
  icon: redMarker,
  infoWindow: InfoWindow(title: 'موقع مهم'),
);
```

---

### 6. المسارات (Polylines)

```dart
// رسم مسار بين نقاط
List<LatLng> route = [
  LatLng(24.7136, 46.6753),
  LatLng(24.7200, 46.6800),
  LatLng(24.7300, 46.6900),
];

Polyline polyline = MapHelper.createPolyline(
  polylineId: 'my_route',
  points: route,
  color: Colors.blue,
  width: 5,
);

// مسار متقطع
Polyline dashedPolyline = MapHelper.createDashedPolyline(
  polylineId: 'dashed_route',
  points: route,
  color: Colors.red,
);
```

---

### 7. الدوائر والأشكال

```dart
// إنشاء دائرة
Circle circle = MapHelper.createCircle(
  circleId: 'delivery_zone',
  center: LatLng(24.7136, 46.6753),
  radiusInMeters: 1000, // 1 كم
  strokeColor: Colors.blue,
  fillColor: Colors.blue.withOpacity(0.2),
);

// إنشاء مستطيل
Polygon rectangle = MapHelper.createRectangle(
  polygonId: 'area',
  northEast: LatLng(24.7200, 46.6800),
  southWest: LatLng(24.7100, 46.6700),
);

// إنشاء شكل حر
Polygon customShape = MapHelper.createPolygon(
  polygonId: 'custom_area',
  points: [
    LatLng(24.7136, 46.6753),
    LatLng(24.7200, 46.6800),
    LatLng(24.7150, 46.6900),
    LatLng(24.7100, 46.6850),
  ],
  fillColor: Colors.green.withOpacity(0.3),
);
```

---

### 8. التحكم بالكاميرا

```dart
// تحريك الكاميرا لموقع
await MapHelper.animateCamera(
  controller,
  LatLng(24.7136, 46.6753),
  zoom: 15.0,
);

// تحريك الكاميرا لعرض جميع النقاط
List<LatLng> points = [
  LatLng(24.7136, 46.6753),
  LatLng(24.7200, 46.6800),
  LatLng(24.7300, 46.6900),
];

await MapHelper.animateCameraToFitBounds(
  controller,
  points,
  padding: 50,
);
```

---

## 🎨 Map Widgets - الواجهات الجاهزة

### 1. CustomMapWidget - خريطة أساسية

```dart
CustomMapWidget(
  initialPosition: LatLng(24.7136, 46.6753),
  initialZoom: 14.0,
  mapType: MapType.normal, // normal, satellite, hybrid, terrain
  myLocationEnabled: true,
  myLocationButtonEnabled: true,
  markers: {
    Marker(
      markerId: MarkerId('marker1'),
      position: LatLng(24.7136, 46.6753),
    ),
  },
  onMapTap: (location) {
    print('تم الضغط على: $location');
  },
  onMapCreated: (controller) {
    // حفظ controller للاستخدام لاحقاً
  },
)
```

---

### 2. LocationPickerWidget - اختيار موقع

```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => LocationPickerWidget(
      initialLocation: LatLng(24.7136, 46.6753),
      onLocationPicked: (location, address) {
        print('تم اختيار: $location');
        print('العنوان: $address');
      },
      confirmButtonText: 'تأكيد الموقع',
      cancelButtonText: 'إلغاء',
    ),
  ),
);
```

**المميزات:**
- ✅ اختيار الموقع بالضغط على الخريطة
- ✅ سحب الـ Marker لتغيير الموقع
- ✅ عرض العنوان تلقائياً
- ✅ زر الموقع الحالي
- ✅ عرض الإحداثيات

---

### 3. MapWithCurrentLocationWidget - خريطة مع الموقع الحالي

```dart
MapWithCurrentLocationWidget(
  zoom: 15.0,
  mapType: MapType.normal,
  onMapCreated: (controller) {
    // استخدام controller
  },
)
```

---

## 💡 أمثلة عملية

### مثال 1: تطبيق توصيل

```dart
class DeliveryPage extends StatefulWidget {
  @override
  State<DeliveryPage> createState() => _DeliveryPageState();
}

class _DeliveryPageState extends State<DeliveryPage> {
  GoogleMapController? _controller;
  LatLng? _restaurantLocation = LatLng(24.7136, 46.6753);
  LatLng? _deliveryLocation;
  Set<Marker> _markers = {};
  Set<Circle> _circles = {};

  @override
  void initState() {
    super.initState();
    _setupMap();
  }

  void _setupMap() {
    // إضافة marker للمطعم
    _markers.add(Marker(
      markerId: MarkerId('restaurant'),
      position: _restaurantLocation!,
      icon: MapHelper.createColoredMarker(MarkerColor.red),
      infoWindow: InfoWindow(title: 'المطعم'),
    ));

    // إضافة دائرة نطاق التوصيل
    _circles.add(MapHelper.createCircle(
      circleId: 'delivery_zone',
      center: _restaurantLocation!,
      radiusInMeters: 5000, // 5 كم
      strokeColor: Colors.blue,
      fillColor: Colors.blue.withOpacity(0.1),
    ));
  }

  Future<void> _pickDeliveryLocation() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LocationPickerWidget(
          onLocationPicked: (location, address) async {
            // التحقق من أن الموقع داخل نطاق التوصيل
            bool inRange = MapHelper.isLocationInRadius(
              _restaurantLocation!.latitude,
              _restaurantLocation!.longitude,
              location.latitude,
              location.longitude,
              5000, // 5 كم
            );

            if (inRange) {
              setState(() {
                _deliveryLocation = location;
                _markers.add(Marker(
                  markerId: MarkerId('delivery'),
                  position: location,
                  icon: MapHelper.createColoredMarker(MarkerColor.green),
                  infoWindow: InfoWindow(
                    title: 'موقع التوصيل',
                    snippet: address,
                  ),
                ));
              });

              // حساب المسافة
              String distance = MapHelper.getFormattedDistance(
                _restaurantLocation!.latitude,
                _restaurantLocation!.longitude,
                location.latitude,
                location.longitude,
              );

              ToastHelper.success('المسافة: $distance');
            } else {
              ToastHelper.error('الموقع خارج نطاق التوصيل');
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('اختر موقع التوصيل')),
      body: CustomMapWidget(
        initialPosition: _restaurantLocation!,
        markers: _markers,
        circles: _circles,
        onMapCreated: (controller) => _controller = controller,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _pickDeliveryLocation,
        icon: Icon(Icons.add_location),
        label: Text('اختر موقع التوصيل'),
      ),
    );
  }
}
```

---

### مثال 2: تتبع الموقع الحالي

```dart
class LiveTrackingPage extends StatefulWidget {
  @override
  State<LiveTrackingPage> createState() => _LiveTrackingPageState();
}

class _LiveTrackingPageState extends State<LiveTrackingPage> {
  GoogleMapController? _controller;
  StreamSubscription<Position>? _positionStream;
  List<LatLng> _path = [];
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};

  @override
  void initState() {
    super.initState();
    _startTracking();
  }

  void _startTracking() {
    _positionStream = MapHelper.getLocationStream(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10, // تحديث كل 10 متر
    ).listen((position) {
      final newLocation = LatLng(position.latitude, position.longitude);

      setState(() {
        _path.add(newLocation);

        // تحديث Marker
        _markers.clear();
        _markers.add(Marker(
          markerId: MarkerId('current'),
          position: newLocation,
          icon: MapHelper.createColoredMarker(MarkerColor.blue),
          infoWindow: InfoWindow(title: 'موقعك الحالي'),
        ));

        // رسم المسار
        _polylines.clear();
        _polylines.add(MapHelper.createPolyline(
          polylineId: 'path',
          points: _path,
          color: Colors.blue,
          width: 5,
        ));
      });

      // تحريك الكاميرا
      if (_controller != null) {
        MapHelper.animateCamera(_controller!, newLocation);
      }
    });
  }

  @override
  void dispose() {
    _positionStream?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('تتبع حي')),
      body: MapWithCurrentLocationWidget(
        onMapCreated: (controller) => _controller = controller,
      ),
    );
  }
}
```

---

## ⚙️ الإعدادات المطلوبة

### 1. Android (AndroidManifest.xml)

```xml
<!-- الصلاحيات -->
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>

<!-- API Key -->
<application>
    <meta-data
        android:name="com.google.android.geo.API_KEY"
        android:value="AIzaSyBRvxQVv7DEX_lklJnEDS4kTB7ehgXG8lU"/>
</application>
```

---

### 2. iOS (AppDelegate.swift)

```swift
import GoogleMaps

GMSServices.provideAPIKey("AIzaSyBRvxQVv7DEX_lklJnEDS4kTB7ehgXG8lU")
```

**Info.plist:**
```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>نحتاج للوصول لموقعك لعرضه على الخريطة</string>

<key>NSLocationAlwaysUsageDescription</key>
<string>نحتاج للوصول لموقعك في الخلفية</string>
```

---

## 🎯 الخلاصة

### MapHelper يوفر:
- ✅ 30+ وظيفة جاهزة
- ✅ دعم كامل للـ Geocoding
- ✅ حساب المسافات والاتجاهات
- ✅ Markers مخصصة
- ✅ رسم المسارات والأشكال
- ✅ فتح خرائط خارجية

### Map Widgets توفر:
- ✅ 3 واجهات جاهزة
- ✅ اختيار موقع تفاعلي
- ✅ عرض الموقع الحالي
- ✅ قابلة للتخصيص بالكامل

---

## 📱 تجربة الآن

افتح التطبيق واضغط على أيقونة 🗺️ في CoreDemoPage لتجربة جميع المميزات!

**MapDemoPage** توفر:
- ✅ جميع أنواع الخرائط
- ✅ إضافة Markers
- ✅ رسم دوائر ومسارات
- ✅ حساب المسافات
- ✅ البحث عن مواقع
- ✅ فتح في تطبيقات خارجية
