import 'package:flutter/material.dart';
import '../models/wardrobe_item.dart';
import '../services/storage_service.dart';
import '../utils/color_helpers.dart';

class WardrobeProvider with ChangeNotifier {
  List<WardrobeItem> _items = [];
  bool _isLoading = false;
  List<WardrobeItem> _selectedItems = [];

  List<WardrobeItem> get items => _items;
  bool get isLoading => _isLoading;
  List<WardrobeItem> get selectedItems => _selectedItems;

  // Load all wardrobe items
  Future<void> loadItems() async {
    _isLoading = true;
    notifyListeners();

    try {
      _items = await StorageService.getAllWardrobeItems();
      _items.sort((a, b) => b.addedAt.compareTo(a.addedAt));
    } catch (e) {
      debugPrint('Error loading wardrobe items: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  // Add new item
  Future<void> addItem(WardrobeItem item) async {
    try {
      await StorageService.saveWardrobeItem(item);
      _items.insert(0, item);
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to save wardrobe item: $e');
    }
  }

  // Update item
  Future<void> updateItem(WardrobeItem item) async {
    try {
      await StorageService.updateWardrobeItem(item);
      final index = _items.indexWhere((i) => i.id == item.id);
      if (index != -1) {
        _items[index] = item;
        notifyListeners();
      }
    } catch (e) {
      throw Exception('Failed to update item: $e');
    }
  }

  // Delete item
  Future<void> deleteItem(String id) async {
    try {
      await StorageService.deleteWardrobeItem(id);
      _items.removeWhere((i) => i.id == id);
      _selectedItems.removeWhere((i) => i.id == id);
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to delete item: $e');
    }
  }

  // Toggle item selection
  void toggleItemSelection(WardrobeItem item) {
    if (_selectedItems.contains(item)) {
      _selectedItems.remove(item);
    } else {
      _selectedItems.add(item);
    }
    notifyListeners();
  }

  // Clear selection
  void clearSelection() {
    _selectedItems.clear();
    notifyListeners();
  }

  // Filter by category
  List<WardrobeItem> filterByCategory(String category) {
    if (category == 'All Items') return _items;
    
    return _items.where((item) => item.category == category).toList();
  }

  // Calculate outfit harmony score
  double calculateOutfitHarmony(List<WardrobeItem> outfit) {
    if (outfit.isEmpty) return 0;
    if (outfit.length == 1) return 100;

    double totalScore = 0;
    int comparisons = 0;

    // Compare each pair of items
    for (int i = 0; i < outfit.length; i++) {
      for (int j = i + 1; j < outfit.length; j++) {
        final score = _compareItemColors(outfit[i], outfit[j]);
        totalScore += score;
        comparisons++;
      }
    }

    return comparisons > 0 ? totalScore / comparisons : 0;
  }

  double _compareItemColors(WardrobeItem item1, WardrobeItem item2) {
    double bestScore = 0;

    // Compare dominant colors
    for (var hex1 in item1.dominantColors) {
      for (var hex2 in item2.dominantColors) {
        final color1 = ColorHelpers.hexToColor(hex1);
        final color2 = ColorHelpers.hexToColor(hex2);
        
        final score = _colorCompatibilityScore(color1, color2);
        if (score > bestScore) {
          bestScore = score;
        }
      }
    }

    return bestScore;
  }

  double _colorCompatibilityScore(Color c1, Color c2) {
    final hsl1 = ColorHelpers.rgbToHsl(c1.red, c1.green, c1.blue);
    final hsl2 = ColorHelpers.rgbToHsl(c2.red, c2.green, c2.blue);

    final hueDiff = (hsl1['h']! - hsl2['h']!).abs();
    
    // Complementary colors (180 degrees apart) - high score
    if (hueDiff > 160 && hueDiff < 200) return 90;
    
    // Analogous colors (30 degrees apart) - high score
    if (hueDiff < 40) return 85;
    
    // Triadic colors (120 degrees apart) - good score
    if (hueDiff > 100 && hueDiff < 140) return 75;
    
    // Neutral colors always work well
    if (hsl1['s']! < 20 || hsl2['s']! < 20) return 80;
    
    // Default moderate score
    return 60;
  }

  // Suggest matching items for an item
  List<WardrobeItem> suggestMatchingItems(WardrobeItem item, {int limit = 5}) {
    final otherItems = _items.where((i) => i.id != item.id).toList();
    
    // Calculate compatibility scores
    final scored = otherItems.map((otherItem) {
      final score = _compareItemColors(item, otherItem);
      return {'item': otherItem, 'score': score};
    }).toList();

    // Sort by score
    scored.sort((a, b) => (b['score'] as double).compareTo(a['score'] as double));

    // Return top matches
    return scored
        .take(limit)
        .map((s) => s['item'] as WardrobeItem)
        .toList();
  }
}
