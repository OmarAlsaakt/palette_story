import 'package:hive/hive.dart';
import '../models/color_palette.dart';
import '../models/wardrobe_item.dart';

class StorageService {
  static const String _palettesBoxName = 'palettes';
  static const String _wardrobeBoxName = 'wardrobe';

  // Palette operations
  static Future<void> savePalette(ColorPalette palette) async {
    final box = await Hive.openBox<ColorPalette>(_palettesBoxName);
    await box.put(palette.id, palette);
  }

  static Future<List<ColorPalette>> getAllPalettes() async {
    final box = await Hive.openBox<ColorPalette>(_palettesBoxName);
    return box.values.toList();
  }

  static Future<ColorPalette?> getPalette(String id) async {
    final box = await Hive.openBox<ColorPalette>(_palettesBoxName);
    return box.get(id);
  }

  static Future<void> deletePalette(String id) async {
    final box = await Hive.openBox<ColorPalette>(_palettesBoxName);
    await box.delete(id);
  }

  static Future<void> updatePalette(ColorPalette palette) async {
    final box = await Hive.openBox<ColorPalette>(_palettesBoxName);
    await box.put(palette.id, palette);
  }

  // Wardrobe operations
  static Future<void> saveWardrobeItem(WardrobeItem item) async {
    final box = await Hive.openBox<WardrobeItem>(_wardrobeBoxName);
    await box.put(item.id, item);
  }

  static Future<List<WardrobeItem>> getAllWardrobeItems() async {
    final box = await Hive.openBox<WardrobeItem>(_wardrobeBoxName);
    return box.values.toList();
  }

  static Future<WardrobeItem?> getWardrobeItem(String id) async {
    final box = await Hive.openBox<WardrobeItem>(_wardrobeBoxName);
    return box.get(id);
  }

  static Future<void> deleteWardrobeItem(String id) async {
    final box = await Hive.openBox<WardrobeItem>(_wardrobeBoxName);
    await box.delete(id);
  }

  static Future<void> updateWardrobeItem(WardrobeItem item) async {
    final box = await Hive.openBox<WardrobeItem>(_wardrobeBoxName);
    await box.put(item.id, item);
  }

  // Clear all data
  static Future<void> clearAllData() async {
    final palettesBox = await Hive.openBox<ColorPalette>(_palettesBoxName);
    final wardrobeBox = await Hive.openBox<WardrobeItem>(_wardrobeBoxName);
    await palettesBox.clear();
    await wardrobeBox.clear();
  }
}
