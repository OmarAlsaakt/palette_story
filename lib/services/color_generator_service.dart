import 'dart:math';
import 'package:flutter/material.dart';
import '../utils/color_helpers.dart';

class ColorGeneratorService {
  static final Map<String, List<String>> _keywordColors = {
    // Nature
    'ocean': ['#006994', '#0090C1', '#4FC3F7', '#B3E5FC', '#E1F5FE', '#003D5C', '#0277BD'],
    'sunset': ['#FF6B6B', '#FFE66D', '#FF8C42', '#A93F55', '#3D5A80', '#FF4757', '#FFA502'],
    'forest': ['#2D4A2B', '#5F7C57', '#8EAC82', '#C4DAC0', '#F0F4F0', '#1B3A1B', '#3E5C3E'],
    'lavender': ['#9B72AA', '#C09BD8', '#E5D4ED', '#8B5A8A', '#6B4C6F', '#D7B9E4', '#B794C8'],
    'desert': ['#EDC9AF', '#C19A6B', '#D2B48C', '#F4A460', '#DEB887', '#8B7355', '#A0826D'],
    'mountain': ['#7C98AB', '#A8DADC', '#457B9D', '#1D3557', '#F1FAEE', '#8B9AA8', '#5E7889'],
    'cherry': ['#FFB7C5', '#FF6B9D', '#C9184A', '#A4133C', '#590D22', '#FF85A1', '#FF477E'],
    
    // Seasons
    'spring': ['#77DD77', '#FFB347', '#AEC6CF', '#FFD1DC', '#FDFD96', '#98D8C8', '#C1E1C1'],
    'summer': ['#87CEEB', '#FFD700', '#FF6347', '#00CED1', '#FFA07A', '#20B2AA', '#FFE4B5'],
    'autumn': ['#D2691E', '#FF8C00', '#CD853F', '#8B4513', '#A0522D', '#B8860B', '#DAA520'],
    'winter': ['#B0E0E6', '#4682B4', '#F0F8FF', '#E6E6FA', '#708090', '#AFEEEE', '#D3D3D3'],
    
    // Moods
    'calm': ['#B4D7E0', '#E8F4EA', '#D4E4F7', '#C7CEEA', '#E0BBE4', '#FFDFD3', '#E8EAF6'],
    'energetic': ['#FF5733', '#FFC300', '#FF1744', '#00E676', '#FF6B35', '#F9CA24', '#FF3F34'],
    'romantic': ['#FFB6C1', '#FFC0CB', '#FFE4E1', '#FF69B4', '#DB7093', '#C71585', '#FF1493'],
    'professional': ['#2C3E50', '#34495E', '#7F8C8D', '#95A5A6', '#BDC3C7', '#3E4C59', '#5D6D7E'],
    'playful': ['#FF6B9D', '#FFA69E', '#FFD93D', '#6BCF7F', '#FF6B9D', '#C06C84', '#F67280'],
    
    // Styles
    'vintage': ['#D4A574', '#8B7355', '#C9B8A0', '#A0826D', '#6D5843', '#B8956A', '#9C7C5E'],
    'modern': ['#000000', '#FFFFFF', '#808080', '#2196F3', '#FFC107', '#E0E0E0', '#424242'],
    'minimalist': ['#FFFFFF', '#F5F5F5', '#E0E0E0', '#BDBDBD', '#9E9E9E', '#757575', '#424242'],
    'bohemian': ['#D4A574', '#8B4513', '#CD853F', '#DEB887', '#F4A460', '#BC8F8F', '#A0826D'],
    'elegant': ['#1A1A1D', '#4E4E50', '#6F2232', '#950740', '#C3073F', '#2E2E30', '#52525E'],
    
    // Events
    'wedding': ['#FFFFFF', '#FFE4E1', '#F0E68C', '#E6E6FA', '#FFF0F5', '#FFFACD', '#F5F5DC'],
    'birthday': ['#FF69B4', '#FFD700', '#87CEEB', '#98FB98', '#DDA0DD', '#F0E68C', '#FFB6C1'],
    'christmas': ['#C41E3A', '#165B33', '#FFFFFF', '#FFD700', '#4169E1', '#228B22', '#B8860B'],
    'halloween': ['#FF6600', '#000000', '#663399', '#800080', '#32CD32', '#8B0000', '#FF4500'],
    'easter': ['#FFDAB9', '#E6E6FA', '#98FB98', '#FFFFE0', '#FFB6C1', '#B0E0E6', '#F0E68C'],
  };

  static final Map<String, String> _descriptions = {
    'ocean': 'Cool, calming blues and teals reminiscent of ocean waves',
    'sunset': 'Warm oranges, pinks, and purples of a beautiful sunset',
    'forest': 'Rich greens and earth tones from deep woods',
    'lavender': 'Soft purples and mauves evoking lavender fields',
    'desert': 'Warm sandy tones and golden hues',
    'spring': 'Fresh pastels celebrating new beginnings',
    'summer': 'Bright, vibrant colors of sunny days',
    'autumn': 'Rich oranges, browns, and golden tones',
    'winter': 'Cool blues and crisp whites',
    'calm': 'Soothing pastels for peace and tranquility',
    'energetic': 'Bold, vibrant colors full of energy',
    'romantic': 'Soft pinks and warm tones for romance',
    'professional': 'Sophisticated neutrals for business',
    'playful': 'Fun, cheerful colors for joy',
  };

  // Generate palette from keyword
  static List<Color> generateFromKeyword(String keyword, {int count = 7}) {
    keyword = keyword.toLowerCase();
    
    if (_keywordColors.containsKey(keyword)) {
      final hexColors = _keywordColors[keyword]!;
      final colors = hexColors
          .take(count)
          .map((hex) => ColorHelpers.hexToColor(hex))
          .toList();
      return colors;
    }
    
    // If keyword not found, generate random harmonious palette
    return generateRandom(count: count);
  }

  // Generate palette from occasion
  static List<Color> generateFromOccasion(String occasion, {int count = 7}) {
    final occasionMap = {
      'casual': 'playful',
      'formal': 'elegant',
      'beach': 'ocean',
      'office': 'professional',
      'date': 'romantic',
      'festival': 'energetic',
      'gym': 'energetic',
    };
    
    final keyword = occasionMap[occasion.toLowerCase()] ?? 'modern';
    return generateFromKeyword(keyword, count: count);
  }

  // Generate harmonious palette from base color
  static List<Color> generateHarmony(Color baseColor, String type, {int count = 7}) {
    switch (type.toLowerCase()) {
      case 'monochromatic':
        return _generateMonochromatic(baseColor, count);
      case 'analogous':
        return _generateAnalogous(baseColor, count);
      case 'complementary':
        return _generateComplementary(baseColor, count);
      case 'triadic':
        return _generateTriadic(baseColor, count);
      default:
        return _generateMonochromatic(baseColor, count);
    }
  }

  // Generate random harmonious palette
  static List<Color> generateRandom({int count = 7}) {
    final random = Random();
    final baseHue = random.nextDouble() * 360;
    final colors = <Color>[];
    
    for (int i = 0; i < count; i++) {
      final hue = (baseHue + (i * 30)) % 360;
      final saturation = 50 + random.nextDouble() * 40;
      final lightness = 40 + random.nextDouble() * 40;
      
      final rgb = ColorHelpers.hslToRgb(hue, saturation, lightness);
      colors.add(Color.fromARGB(255, rgb['r']!, rgb['g']!, rgb['b']!));
    }
    
    return colors;
  }

  static List<Color> _generateMonochromatic(Color base, int count) {
    final hsl = ColorHelpers.rgbToHsl(base.red, base.green, base.blue);
    final colors = <Color>[];
    
    for (int i = 0; i < count; i++) {
      final lightness = 20 + (60.0 * i / count);
      final rgb = ColorHelpers.hslToRgb(hsl['h']!, hsl['s']!, lightness);
      colors.add(Color.fromARGB(255, rgb['r']!, rgb['g']!, rgb['b']!));
    }
    
    return colors;
  }

  static List<Color> _generateAnalogous(Color base, int count) {
    final hsl = ColorHelpers.rgbToHsl(base.red, base.green, base.blue);
    final colors = <Color>[];
    
    for (int i = 0; i < count; i++) {
      final hueOffset = -30 + (60.0 * i / count);
      final newHue = (hsl['h']! + hueOffset) % 360;
      final rgb = ColorHelpers.hslToRgb(newHue, hsl['s']!, hsl['l']!);
      colors.add(Color.fromARGB(255, rgb['r']!, rgb['g']!, rgb['b']!));
    }
    
    return colors;
  }

  static List<Color> _generateComplementary(Color base, int count) {
    final hsl = ColorHelpers.rgbToHsl(base.red, base.green, base.blue);
    final colors = <Color>[base];
    
    // Add complementary color
    final compHue = (hsl['h']! + 180) % 360;
    final rgb = ColorHelpers.hslToRgb(compHue, hsl['s']!, hsl['l']!);
    colors.add(Color.fromARGB(255, rgb['r']!, rgb['g']!, rgb['b']!));
    
    // Fill with variations
    while (colors.length < count) {
      final isBase = colors.length % 2 == 0;
      final hue = isBase ? hsl['h']! : compHue;
      final lightness = 30 + Random().nextDouble() * 50;
      final rgb2 = ColorHelpers.hslToRgb(hue, hsl['s']!, lightness);
      colors.add(Color.fromARGB(255, rgb2['r']!, rgb2['g']!, rgb2['b']!));
    }
    
    return colors;
  }

  static List<Color> _generateTriadic(Color base, int count) {
    final hsl = ColorHelpers.rgbToHsl(base.red, base.green, base.blue);
    final colors = <Color>[];
    
    for (int i = 0; i < count; i++) {
      final hueOffset = (i % 3) * 120.0;
      final newHue = (hsl['h']! + hueOffset) % 360;
      final lightness = 40 + (i ~/ 3) * 15.0;
      final rgb = ColorHelpers.hslToRgb(newHue, hsl['s']!, lightness.clamp(20, 80));
      colors.add(Color.fromARGB(255, rgb['r']!, rgb['g']!, rgb['b']!));
    }
    
    return colors;
  }

  // Get description for keyword
  static String getDescription(String keyword) {
    return _descriptions[keyword.toLowerCase()] ?? 
           'A beautiful harmonious color palette';
  }

  // Get all available keywords
  static List<String> getAllKeywords() {
    return _keywordColors.keys.toList()..sort();
  }
}
