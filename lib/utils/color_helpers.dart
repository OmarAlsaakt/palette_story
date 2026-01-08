import 'dart:math';
import 'package:flutter/material.dart';

class ColorHelpers {
  // Convert Color to Hex string
  static String colorToHex(Color color) {
    return '#${color.value.toRadixString(16).substring(2).toUpperCase()}';
  }

  // Convert Hex string to Color
  static Color hexToColor(String hex) {
    final hexCode = hex.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }

  // RGB to HSL
  static Map<String, double> rgbToHsl(int r, int g, int b) {
    double rd = r / 255.0;
    double gd = g / 255.0;
    double bd = b / 255.0;

    double max = [rd, gd, bd].reduce((a, b) => a > b ? a : b);
    double min = [rd, gd, bd].reduce((a, b) => a < b ? a : b);
    double h = 0, s = 0, l = (max + min) / 2.0;

    if (max != min) {
      double d = max - min;
      s = l > 0.5 ? d / (2.0 - max - min) : d / (max + min);

      if (max == rd) {
        h = (gd - bd) / d + (gd < bd ? 6 : 0);
      } else if (max == gd) {
        h = (bd - rd) / d + 2;
      } else {
        h = (rd - gd) / d + 4;
      }
      h /= 6;
    }

    return {'h': h * 360, 's': s * 100, 'l': l * 100};
  }

  // HSL to RGB
  static Map<String, int> hslToRgb(double h, double s, double l) {
    h = h / 360;
    s = s / 100;
    l = l / 100;

    double r, g, b;

    if (s == 0) {
      r = g = b = l;
    } else {
      double q = l < 0.5 ? l * (1 + s) : l + s - l * s;
      double p = 2 * l - q;
      r = _hue2rgb(p, q, h + 1 / 3);
      g = _hue2rgb(p, q, h);
      b = _hue2rgb(p, q, h - 1 / 3);
    }

    return {
      'r': (r * 255).round(),
      'g': (g * 255).round(),
      'b': (b * 255).round(),
    };
  }

  static double _hue2rgb(double p, double q, double t) {
    if (t < 0) t += 1;
    if (t > 1) t -= 1;
    if (t < 1 / 6) return p + (q - p) * 6 * t;
    if (t < 1 / 2) return q;
    if (t < 2 / 3) return p + (q - p) * (2 / 3 - t) * 6;
    return p;
  }

  // RGB to CMYK
  static Map<String, double> rgbToCmyk(int r, int g, int b) {
    double rd = r / 255.0;
    double gd = g / 255.0;
    double bd = b / 255.0;

    double k = 1 - [rd, gd, bd].reduce((a, b) => a > b ? a : b);
    double c = (1 - rd - k) / (1 - k);
    double m = (1 - gd - k) / (1 - k);
    double y = (1 - bd - k) / (1 - k);

    return {
      'c': (c * 100).isNaN ? 0 : c * 100,
      'm': (m * 100).isNaN ? 0 : m * 100,
      'y': (y * 100).isNaN ? 0 : y * 100,
      'k': k * 100,
    };
  }

  // Get complementary color
  static Color getComplementary(Color color) {
    final hsl = rgbToHsl(color.red, color.green, color.blue);
    final newHue = (hsl['h']! + 180) % 360;
    final rgb = hslToRgb(newHue, hsl['s']!, hsl['l']!);
    return Color.fromARGB(255, rgb['r']!, rgb['g']!, rgb['b']!);
  }

  // Get analogous colors
  static List<Color> getAnalogous(Color color) {
    final hsl = rgbToHsl(color.red, color.green, color.blue);
    final colors = <Color>[];
    
    for (var offset in [-30.0, 0.0, 30.0]) {
      final newHue = (hsl['h']! + offset) % 360;
      final rgb = hslToRgb(newHue, hsl['s']!, hsl['l']!);
      colors.add(Color.fromARGB(255, rgb['r']!, rgb['g']!, rgb['b']!));
    }
    
    return colors;
  }

  // Get triadic colors
  static List<Color> getTriadic(Color color) {
    final hsl = rgbToHsl(color.red, color.green, color.blue);
    final colors = <Color>[];
    
    for (var offset in [0.0, 120.0, 240.0]) {
      final newHue = (hsl['h']! + offset) % 360;
      final rgb = hslToRgb(newHue, hsl['s']!, hsl['l']!);
      colors.add(Color.fromARGB(255, rgb['r']!, rgb['g']!, rgb['b']!));
    }
    
    return colors;
  }

  // Generate tints (lighter versions)
  static List<Color> generateTints(Color color, int count) {
    final colors = <Color>[];
    final hsl = rgbToHsl(color.red, color.green, color.blue);
    
    for (int i = 0; i < count; i++) {
      final lightness = hsl['l']! + (100 - hsl['l']!) * (i / count);
      final rgb = hslToRgb(hsl['h']!, hsl['s']!, lightness);
      colors.add(Color.fromARGB(255, rgb['r']!, rgb['g']!, rgb['b']!));
    }
    
    return colors;
  }

  // Generate shades (darker versions)
  static List<Color> generateShades(Color color, int count) {
    final colors = <Color>[];
    final hsl = rgbToHsl(color.red, color.green, color.blue);
    
    for (int i = 0; i < count; i++) {
      final lightness = hsl['l']! * (1 - i / count);
      final rgb = hslToRgb(hsl['h']!, hsl['s']!, lightness);
      colors.add(Color.fromARGB(255, rgb['r']!, rgb['g']!, rgb['b']!));
    }
    
    return colors;
  }

  // Mix two colors
  static Color mixColors(Color c1, Color c2, double ratio) {
    final r = (c1.red * (1 - ratio) + c2.red * ratio).round();
    final g = (c1.green * (1 - ratio) + c2.green * ratio).round();
    final b = (c1.blue * (1 - ratio) + c2.blue * ratio).round();
    return Color.fromARGB(255, r, g, b);
  }

  // Calculate contrast ratio (WCAG)
  static double getContrastRatio(Color fg, Color bg) {
    final l1 = _getLuminance(fg);
    final l2 = _getLuminance(bg);
    final lighter = max(l1, l2);
    final darker = min(l1, l2);
    return (lighter + 0.05) / (darker + 0.05);
  }

  static double _getLuminance(Color color) {
    final r = _linearize(color.red / 255);
    final g = _linearize(color.green / 255);
    final b = _linearize(color.blue / 255);
    return 0.2126 * r + 0.7152 * g + 0.0722 * b;
  }

  static double _linearize(double channel) {
    if (channel <= 0.03928) {
      return channel / 12.92;
    }
    return pow((channel + 0.055) / 1.055, 2.4).toDouble();
  }

  // Check if color is light or dark
  static bool isLightColor(Color color) {
    return _getLuminance(color) > 0.5;
  }

  // Get text color based on background
  static Color getTextColor(Color backgroundColor) {
    return isLightColor(backgroundColor) ? Colors.black : Colors.white;
  }
}
