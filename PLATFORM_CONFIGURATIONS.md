# 📱 Platform Configurations Guide

هذا الملف يوضح كل الـ Configurations اللي تمت إضافتها للمشروع عشان الـ Packages تشتغل صح على Android و iOS.

---

## 🤖 Android Configurations

### 1. **build.gradle.kts** (App Level)
✅ تم التحديث

**التغييرات:**
- `minSdk = 24` (مطلوب لـ: image_cropper, local_auth, Firebase)
- `compileSdk = 35` و `targetSdk = 35`
- `multiDexEnabled = true` (لدعم Firebase والتطبيقات الكبيرة)
- إضافة dependency: `androidx.multidex:multidex:2.0.1`
- تجهيز Firebase plugin (معلق حالياً - لحين إضافة google-services.json)

### 2. **AndroidManifest.xml**
✅ تم التحديث الكامل

**الـ Permissions المضافة:**

#### Internet & Network
```xml
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
```
- **المطلوبة لـ:** Dio, Firebase, Connectivity, Internet Checker

#### Camera & Photos
```xml
<uses-permission android:name="android.permission.CAMERA"/>
<uses-permission android:name="android.permission.READ_MEDIA_IMAGES"/>
<uses-permission android:name="android.permission.READ_MEDIA_VIDEO"/>
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
```
- **المطلوبة لـ:** image_picker, image_cropper, file_picker, qr_code_scanner, cached_network_image

#### Location
```xml
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>
<uses-permission android:name="android.permission.ACCESS_BACKGROUND_LOCATION"/>
```
- **المطلوبة لـ:** geolocator, google_maps_flutter, geocoding

#### Notifications
```xml
<uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>
<uses-permission android:name="android.permission.VIBRATE"/>
<uses-permission android:name="android.permission.WAKE_LOCK"/>
<uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED"/>
```
- **المطلوبة لـ:** firebase_messaging, flutter_local_notifications

#### Biometric
```xml
<uses-permission android:name="android.permission.USE_BIOMETRIC"/>
<uses-permission android:name="android.permission.USE_FINGERPRINT"/>
```
- **المطلوبة لـ:** local_auth

#### Camera Features
```xml
<uses-feature android:name="android.hardware.camera"/>
<uses-feature android:name="android.hardware.camera.autofocus"/>
```
- **المطلوبة لـ:** qr_code_scanner

**الـ Services & Receivers المضافة:**

#### Firebase Cloud Messaging
```xml
<service
    android:name="com.google.firebase.messaging.FirebaseMessagingService"
    android:exported="false">
    <intent-filter>
        <action android:name="com.google.firebase.MESSAGING_EVENT"/>
    </intent-filter>
</service>
```

#### Local Notifications
```xml
<receiver android:name="com.dexterous.flutterlocalnotifications.ScheduledNotificationBootReceiver"/>
<receiver android:name="com.dexterous.flutterlocalnotifications.ScheduledNotificationReceiver"/>
```

#### Queries (Android 11+)
إضافة queries للـ packages اللي بتفتح تطبيقات خارجية:
- url_launcher (http, https, tel, mailto)
- share_plus (SEND intent)

#### Application Attributes
- `android:usesCleartextTraffic="true"` (للسماح بـ HTTP في Development)
- `android:showWhenLocked="true"` (للإشعارات)
- `android:turnScreenOn="true"` (للإشعارات)

### 3. **build.gradle.kts** (Project Level)
✅ تم التحديث

**التغييرات:**
- إضافة buildscript للـ Firebase (معلق حالياً)
- جاهز لإضافة `com.google.gms:google-services:4.4.0`

---

## 🍎 iOS Configurations

### 1. **Info.plist**
✅ تم التحديث الكامل

**الـ Permission Descriptions المضافة:**

#### Camera
```xml
<key>NSCameraUsageDescription</key>
<string>نحتاج الوصول للكاميرا لالتقاط الصور والفيديو</string>
```
- **المطلوبة لـ:** image_picker, qr_code_scanner

#### Photo Library
```xml
<key>NSPhotoLibraryUsageDescription</key>
<string>نحتاج الوصول للصور لاختيار الصور من المعرض</string>
<key>NSPhotoLibraryAddUsageDescription</key>
<string>نحتاج الوصول لحفظ الصور في المعرض</string>
```
- **المطلوبة لـ:** image_picker, image_cropper

#### Location
```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>نحتاج موقعك لتوفير خدمات أفضل</string>
<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>نحتاج موقعك لتحديد موقعك على الخريطة</string>
```
- **المطلوبة لـ:** geolocator, google_maps_flutter

#### Face ID / Touch ID
```xml
<key>NSFaceIDUsageDescription</key>
<string>استخدم Face ID لتسجيل الدخول بسرعة وأمان</string>
```
- **المطلوبة لـ:** local_auth

#### Background Modes
```xml
<key>UIBackgroundModes</key>
<array>
    <string>fetch</string>
    <string>remote-notification</string>
</array>
```
- **المطلوبة لـ:** firebase_messaging

#### App Transport Security
```xml
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
</dict>
```
⚠️ **ملاحظة:** هذا للـ Development فقط - يجب إزالته في Production

### 2. **Podfile**
✅ تم التحديث

**التغييرات:**
- `platform :ios, '15.0'` (مطلوب للـ Firebase - تم التحديث)
- إضافة `use_modular_headers!` (مطلوب لـ Firebase)
- Fix لـ deployment target warnings
- Fix لـ Firebase pods (DT_TOOLCHAIN_DIR issue)
- `ENABLE_BITCODE = 'NO'` (معظم الـ packages لا تدعمه)

---

## 🔥 Firebase Setup (خطوات إضافية)

### Android
1. أضف `google-services.json` في:
   ```
   android/app/google-services.json
   ```

2. في `android/app/build.gradle.kts`، قم بإلغاء التعليق:
   ```kotlin
   id("com.google.gms.google-services")
   ```

3. في `android/build.gradle.kts`، قم بإلغاء التعليق:
   ```kotlin
   classpath("com.google.gms:google-services:4.4.0")
   ```

### iOS
1. أضف `GoogleService-Info.plist` في:
   ```
   ios/Runner/GoogleService-Info.plist
   ```

2. افتح Xcode وأضف الملف للـ project

3. نفذ:
   ```bash
   cd ios
   pod install
   ```

---

## 🗺️ Google Maps Setup (خطوات إضافية)

### Android
في `AndroidManifest.xml`، قم بإلغاء التعليق وأضف API Key:
```xml
<meta-data
    android:name="com.google.android.geo.API_KEY"
    android:value="YOUR_GOOGLE_MAPS_API_KEY"/>
```

### iOS
في `AppDelegate.swift`، أضف:
```swift
import GoogleMaps

GMSServices.provideAPIKey("YOUR_GOOGLE_MAPS_API_KEY")
```

---

## 📦 Packages التي تحتاج Configuration إضافية

### 1. **image_cropper**
- ✅ Permissions: تمت الإضافة
- ✅ minSdk 24: تم التحديث

### 2. **local_auth**
- ✅ Permissions: تمت الإضافة (USE_BIOMETRIC, NSFaceIDUsageDescription)
- ✅ minSdk 24: تم التحديث

### 3. **firebase_* packages**
- ⚠️ تحتاج: google-services.json (Android)
- ⚠️ تحتاج: GoogleService-Info.plist (iOS)
- ✅ Permissions: تمت الإضافة
- ✅ Services: تمت الإضافة

### 4. **flutter_local_notifications**
- ✅ Permissions: تمت الإضافة
- ✅ Receivers: تمت الإضافة

### 5. **geolocator & google_maps_flutter**
- ✅ Permissions: تمت الإضافة
- ⚠️ تحتاج: Google Maps API Key (للخرائط)

### 6. **url_launcher**
- ✅ Queries: تمت الإضافة (Android)

### 7. **share_plus**
- ✅ Queries: تمت الإضافة (Android)

### 8. **qr_code_scanner**
- ✅ Permissions: تمت الإضافة
- ✅ Features: تمت الإضافة

### 9. **flutter_secure_storage**
- ✅ No additional configuration needed

### 10. **easy_localization**
- ✅ Assets: موجودة في pubspec.yaml

---

## ✅ Checklist للتأكد من كل حاجة شغالة

### Android
- [x] minSdk = 24
- [x] compileSdk & targetSdk = 35
- [x] MultiDex enabled
- [x] All permissions added
- [x] Firebase services configured (commented)
- [x] Local notifications receivers added
- [x] Queries for external intents
- [x] Google Maps meta-data (commented)

### iOS
- [x] platform :ios, '15.0' (Updated for Firebase)
- [x] use_modular_headers!
- [x] All permission descriptions added
- [x] Background modes for notifications
- [x] Podfile post_install fixes
- [x] NSAppTransportSecurity (for development)

### Optional (تحتاج إضافة يدوية)
- [ ] google-services.json (Android)
- [ ] GoogleService-Info.plist (iOS)
- [ ] Google Maps API Key (both platforms)
- [ ] pod install (iOS after Firebase setup)

---

## 🚀 أوامر مفيدة

### Android
```bash
# Clean build
cd android
./gradlew clean

# Build debug APK
flutter build apk --debug

# Check dependencies
./gradlew app:dependencies
```

### iOS
```bash
# Install pods
cd ios
pod install
pod repo update

# Clean build
flutter clean
rm -rf ios/Pods ios/Podfile.lock

# Build iOS
flutter build ios
```

### Both
```bash
# Get packages
flutter pub get

# Check for issues
flutter doctor -v

# Run on device
flutter run
```

---

## ⚠️ Common Issues & Solutions

### 1. "Manifest merger failed" (Android)
**الحل:** تأكد من أن compileSdk و targetSdk متوافقين مع الـ dependencies

### 2. "No matching client found" (Firebase Android)
**الحل:** تأكد من إضافة google-services.json وأن package name متطابق

### 3. "Pod install failed" (iOS)
**الحل:**
```bash
cd ios
pod deintegrate
pod install --repo-update
```

### 4. "Permission denied" (Runtime)
**الحل:** استخدم package `permission_handler` لطلب الـ permissions في Runtime

### 5. "DT_TOOLCHAIN_DIR" error (iOS)
**الحل:** تم إضافة fix في Podfile post_install

---

## 📝 Notes

1. **Development vs Production:**
   - `android:usesCleartextTraffic="true"` يجب حذفها في Production
   - `NSAllowsArbitraryLoads` يجب حذفها في Production

2. **Permissions:**
   - بعض الـ permissions تحتاج runtime request باستخدام `permission_handler`
   - راجع صفحة كل package للتفاصيل

3. **Firebase:**
   - لا تنسى إضافة google-services files قبل استخدام Firebase
   - Firebase packages كبيرة - استخدم فقط اللي تحتاجه

4. **Google Maps:**
   - API Key مجاني لحد 25,000 map load يومياً
   - لا تنشر API Key على GitHub - استخدم environment variables

---

## 📚 Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Firebase Setup Guide](https://firebase.google.com/docs/flutter/setup)
- [Android Permissions](https://developer.android.com/guide/topics/permissions/overview)
- [iOS Info.plist Keys](https://developer.apple.com/documentation/bundleresources/information_property_list)
- [Google Maps Setup](https://pub.dev/packages/google_maps_flutter)

---

## 🎉 Done!

كل الـ configurations اللي محتاجها معظم الـ packages تمت إضافتها بنجاح! 🚀

**للبدء في استخدام Firebase:**
1. أضف google-services files
2. قم بإلغاء التعليق من Firebase plugins
3. نفذ `flutter pub get`
4. نفذ `cd ios && pod install` (iOS)
5. Run التطبيق!
