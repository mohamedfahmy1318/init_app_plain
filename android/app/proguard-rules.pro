# ==================== Flutter ====================
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }

# ==================== Gson (for JSON) ====================
-keepattributes Signature
-keepattributes *Annotation*
-dontwarn sun.misc.**
-keep class com.google.gson.** { *; }
-keep class * implements com.google.gson.TypeAdapter
-keep class * implements com.google.gson.TypeAdapterFactory
-keep class * implements com.google.gson.JsonSerializer
-keep class * implements com.google.gson.JsonDeserializer

# ==================== OkHttp & Dio ====================
-dontwarn okhttp3.**
-dontwarn okio.**
-keep class okhttp3.** { *; }
-keep interface okhttp3.** { *; }
-dontwarn javax.annotation.**
-keepnames class okhttp3.internal.publicsuffix.PublicSuffixDatabase

# ==================== Firebase ====================
-keep class com.google.firebase.** { *; }
-keep class com.google.android.gms.** { *; }
-dontwarn com.google.firebase.**
-dontwarn com.google.android.gms.**

# ==================== Secure Storage ====================
-keep class androidx.security.crypto.** { *; }

# ==================== Image Picker & Cropper ====================
-keep class androidx.exifinterface.** { *; }
-keep class com.yalantis.ucrop.** { *; }

# ==================== Google Maps ====================
-keep class com.google.android.gms.maps.** { *; }
-keep interface com.google.android.gms.maps.** { *; }

# ==================== Local Auth (Biometric) ====================
-keep class androidx.biometric.** { *; }

# ==================== WebView ====================
-keep class * extends android.webkit.WebChromeClient { *; }
-dontwarn android.webkit.WebView
-dontwarn android.webkit.JavascriptInterface

# ==================== QR Code Scanner ====================
-keep class com.google.zxing.** { *; }

# ==================== Your App Models ====================
# Add your data models here to prevent obfuscation
-keep class com.example.bainona.**.models.** { *; }
-keep class * implements android.os.Parcelable {
  public static final android.os.Parcelable$Creator *;
}

# ==================== Kotlin ====================
-dontwarn kotlin.**
-dontwarn kotlinx.**
-keep class kotlin.** { *; }
-keep class kotlinx.** { *; }

# ==================== General ====================
-keepattributes SourceFile,LineNumberTable
-keepattributes *Annotation*
-renamesourcefileattribute SourceFile
