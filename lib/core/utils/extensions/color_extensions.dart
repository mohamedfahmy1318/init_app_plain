import 'package:flutter/material.dart';

/// ========================================================
/// Color Extensions
/// ========================================================
/// Extensions مفيدة للألوان
/// ========================================================

extension ColorExtensions on Color {
  /// تحويل Color لـ Hex String
  String toHex({bool includeAlpha = false}) {
    if (includeAlpha) {
      return '#${alpha.toRadixString(16).padLeft(2, '0')}'
          '${red.toRadixString(16).padLeft(2, '0')}'
          '${green.toRadixString(16).padLeft(2, '0')}'
          '${blue.toRadixString(16).padLeft(2, '0')}';
    }
    return '#${red.toRadixString(16).padLeft(2, '0')}'
        '${green.toRadixString(16).padLeft(2, '0')}'
        '${blue.toRadixString(16).padLeft(2, '0')}';
  }

  /// تفتيح اللون
  Color lighten([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    final lightness = (hsl.lightness + amount).clamp(0.0, 1.0);
    return hsl.withLightness(lightness).toColor();
  }

  /// تغميق اللون
  Color darken([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    final lightness = (hsl.lightness - amount).clamp(0.0, 1.0);
    return hsl.withLightness(lightness).toColor();
  }

  /// زيادة التشبع
  Color saturate([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    final saturation = (hsl.saturation + amount).clamp(0.0, 1.0);
    return hsl.withSaturation(saturation).toColor();
  }

  /// تقليل التشبع
  Color desaturate([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    final saturation = (hsl.saturation - amount).clamp(0.0, 1.0);
    return hsl.withSaturation(saturation).toColor();
  }

  /// تغيير الشفافية
  Color withOpacity(double opacity) {
    assert(opacity >= 0 && opacity <= 1);
    return Color.fromRGBO(red, green, blue, opacity);
  }

  /// اللون المعاكس
  Color get invert {
    return Color.fromRGBO(
      255 - red,
      255 - green,
      255 - blue,
      opacity,
    );
  }

  /// اللون التكميلي
  Color get complement {
    final hsl = HSLColor.fromColor(this);
    final hue = (hsl.hue + 180) % 360;
    return hsl.withHue(hue).toColor();
  }

  /// Grayscale
  Color get grayscale {
    final luminance = computeLuminance();
    return Color.fromRGBO(
      (luminance * 255).toInt(),
      (luminance * 255).toInt(),
      (luminance * 255).toInt(),
      opacity,
    );
  }

  /// هل اللون فاتح؟
  bool get isLight {
    return computeLuminance() > 0.5;
  }

  /// هل اللون غامق؟
  bool get isDark {
    return !isLight;
  }

  /// لون النص المناسب (أبيض أو أسود)
  Color get textColor {
    return isLight ? Colors.black : Colors.white;
  }

  /// مزج لونين
  Color mix(Color other, [double amount = 0.5]) {
    assert(amount >= 0 && amount <= 1);
    return Color.fromRGBO(
      ((1 - amount) * red + amount * other.red).round(),
      ((1 - amount) * green + amount * other.green).round(),
      ((1 - amount) * blue + amount * other.blue).round(),
      ((1 - amount) * opacity + amount * other.opacity),
    );
  }

  /// Material Color من Color
  MaterialColor toMaterialColor() {
    final strengths = <double>[.05];
    final swatch = <int, Color>{};
    final r = red;
    final g = green;
    final b = blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }

    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }

    return MaterialColor(value, swatch);
  }
}

extension HexColor on String {
  /// تحويل Hex String لـ Color
  Color toColor() {
    var hexColor = replaceAll('#', '');
    
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    
    if (hexColor.length == 8) {
      return Color(int.parse(hexColor, radix: 16));
    }
    
    return Colors.black;
  }
}
