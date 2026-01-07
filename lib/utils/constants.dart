import 'package:flutter/material.dart';

class AppConstants {
  // App Info
  static const String appName = 'PaletteStory';
  static const String appTagline = 'Your Personal Color Companion';
  static const String appVersion = '1.0.0';

  // Categories
  static const List<String> wardrobeCategories = [
    'Top',
    'Bottom',
    'Dress',
    'Shoes',
    'Accessory',
    'Outerwear',
  ];

  static const List<String> seasons = [
    'Spring',
    'Summer',
    'Fall',
    'Winter',
    'All Season',
  ];

  static const List<String> occasions = [
    'Casual',
    'Formal',
    'Sport',
    'Party',
    'Business',
    'Date',
  ];

  static const List<String> paletteCategories = [
    'Fashion',
    'Art',
    'Nature',
    'Interior',
    'Custom',
  ];

  // Colors
  static const Color primaryPurple = Color(0xFF6C5CE7);
  static const Color secondaryPink = Color(0xFFFF6B6B);
  static const Color accentBlue = Color(0xFF4FC3F7);
  static const Color backgroundLight = Color(0xFFF8F9FA);
  static const Color backgroundDark = Color(0xFF1A1A2E);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF6C5CE7), Color(0xFFFF6B6B)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFFFDFCFB), Color(0xFFE2D1F9)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
