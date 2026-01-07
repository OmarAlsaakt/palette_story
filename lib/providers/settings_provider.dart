import 'package:flutter/material.dart';
import '../models/app_settings.dart';

class SettingsProvider with ChangeNotifier {
  AppSettings _settings;

  SettingsProvider(this._settings);

  AppSettings get settings => _settings;
  ThemeMode get themeMode => _settings.themeMode;
  Color get accentColor => _settings.accentColor;
  String get defaultColorFormat => _settings.defaultColorFormat;
  int get colorExtractionCount => _settings.colorExtractionCount;
  bool get autoSave => _settings.autoSave;
  bool get hapticFeedback => _settings.hapticFeedback;
  bool get colorBlindMode => _settings.colorBlindMode;

  Future<void> setThemeMode(ThemeMode mode) async {
    _settings.themeMode = mode;
    await _settings.save();
    notifyListeners();
  }

  Future<void> setAccentColor(Color color) async {
    _settings.accentColor = color;
    await _settings.save();
    notifyListeners();
  }

  Future<void> setDefaultColorFormat(String format) async {
    _settings.defaultColorFormat = format;
    await _settings.save();
    notifyListeners();
  }

  Future<void> setColorExtractionCount(int count) async {
    _settings.colorExtractionCount = count;
    await _settings.save();
    notifyListeners();
  }

  Future<void> setAutoSave(bool value) async {
    _settings.autoSave = value;
    await _settings.save();
    notifyListeners();
  }

  Future<void> setHapticFeedback(bool value) async {
    _settings.hapticFeedback = value;
    await _settings.save();
    notifyListeners();
  }

  Future<void> setColorBlindMode(bool value) async {
    _settings.colorBlindMode = value;
    await _settings.save();
    notifyListeners();
  }
}
