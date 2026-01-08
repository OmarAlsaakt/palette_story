import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettings {
  ThemeMode themeMode;
  Color accentColor;
  String defaultColorFormat;
  int colorExtractionCount;
  bool autoSave;
  bool hapticFeedback;
  bool colorBlindMode;

  AppSettings({
    this.themeMode = ThemeMode.system,
    this.accentColor = const Color(0xFF6C5CE7),
    this.defaultColorFormat = 'HEX',
    this.colorExtractionCount = 7,
    this.autoSave = false,
    this.hapticFeedback = true,
    this.colorBlindMode = false,
  });

  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('themeMode', themeMode.index);
    await prefs.setInt('accentColor', accentColor.value);
    await prefs.setString('defaultColorFormat', defaultColorFormat);
    await prefs.setInt('colorExtractionCount', colorExtractionCount);
    await prefs.setBool('autoSave', autoSave);
    await prefs.setBool('hapticFeedback', hapticFeedback);
    await prefs.setBool('colorBlindMode', colorBlindMode);
  }

  static Future<AppSettings> load() async {
    final prefs = await SharedPreferences.getInstance();
    return AppSettings(
      themeMode: ThemeMode.values[prefs.getInt('themeMode') ?? 0],
      accentColor: Color(prefs.getInt('accentColor') ?? 0xFF6C5CE7),
      defaultColorFormat: prefs.getString('defaultColorFormat') ?? 'HEX',
      colorExtractionCount: prefs.getInt('colorExtractionCount') ?? 7,
      autoSave: prefs.getBool('autoSave') ?? false,
      hapticFeedback: prefs.getBool('hapticFeedback') ?? true,
      colorBlindMode: prefs.getBool('colorBlindMode') ?? false,
    );
  }
}
