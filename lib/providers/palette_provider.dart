import 'package:flutter/material.dart';
import '../models/color_palette.dart';
import '../services/storage_service.dart';

class PaletteProvider with ChangeNotifier {
  List<ColorPalette> _palettes = [];
  bool _isLoading = false;

  List<ColorPalette> get palettes => _palettes;
  bool get isLoading => _isLoading;

  // Load all palettes
  Future<void> loadPalettes() async {
    _isLoading = true;
    notifyListeners();

    try {
      _palettes = await StorageService.getAllPalettes();
      _palettes.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    } catch (e) {
      debugPrint('Error loading palettes: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  // Add new palette
  Future<void> addPalette(ColorPalette palette) async {
    try {
      await StorageService.savePalette(palette);
      _palettes.insert(0, palette);
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to save palette: $e');
    }
  }

  // Update palette
  Future<void> updatePalette(ColorPalette palette) async {
    try {
      await StorageService.updatePalette(palette);
      final index = _palettes.indexWhere((p) => p.id == palette.id);
      if (index != -1) {
        _palettes[index] = palette;
        notifyListeners();
      }
    } catch (e) {
      throw Exception('Failed to update palette: $e');
    }
  }

  // Delete palette
  Future<void> deletePalette(String id) async {
    try {
      await StorageService.deletePalette(id);
      _palettes.removeWhere((p) => p.id == id);
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to delete palette: $e');
    }
  }

  // Get palette by ID
  ColorPalette? getPaletteById(String id) {
    try {
      return _palettes.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }

  // Search palettes
  List<ColorPalette> searchPalettes(String query) {
    if (query.isEmpty) return _palettes;
    
    return _palettes.where((palette) {
      return palette.name.toLowerCase().contains(query.toLowerCase()) ||
          (palette.description?.toLowerCase().contains(query.toLowerCase()) ?? false);
    }).toList();
  }

  // Filter by category
  List<ColorPalette> filterByCategory(String category) {
    if (category == 'All') return _palettes;
    
    return _palettes.where((palette) {
      return palette.category == category;
    }).toList();
  }
}
