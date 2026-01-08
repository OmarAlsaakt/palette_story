import 'dart:io';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:image/image.dart' as img;

class ColorExtractionService {
  // Extract colors from image file
  static Future<List<Color>> extractColors(
    File imageFile, {
    int maxColors = 7,
  }) async {
    try {
      // Compress image if too large
      final imageBytes = await imageFile.readAsBytes();
      File processedFile = imageFile;

      if (imageBytes.length > 2 * 1024 * 1024) {
        // If larger than 2MB, compress
        processedFile = await _compressImage(imageFile);
      }

      // Generate palette
      final PaletteGenerator paletteGenerator =
          await PaletteGenerator.fromImageProvider(
        FileImage(processedFile),
        size: const Size(200, 200),
        maximumColorCount: maxColors,
      );

      // Extract colors sorted by population
      final List<Color> colors = [];
      
      if (paletteGenerator.dominantColor != null) {
        colors.add(paletteGenerator.dominantColor!.color);
      }

      for (var paletteColor in paletteGenerator.colors) {
        if (colors.length >= maxColors) break;
        if (!colors.contains(paletteColor)) {
          colors.add(paletteColor);
        }
      }

      // Ensure we have at least some colors
      if (colors.isEmpty) {
        colors.add(Colors.grey);
      }

      return colors;
    } catch (e) {
      throw Exception('Failed to extract colors: $e');
    }
  }

  // Compress large images
  static Future<File> _compressImage(File file) async {
    final imageBytes = await file.readAsBytes();
    img.Image? image = img.decodeImage(imageBytes);

    if (image == null) return file;

    // Resize if too large
    if (image.width > 1024 || image.height > 1024) {
      image = img.copyResize(image, width: 1024);
    }

    // Save compressed image
    final compressedBytes = img.encodeJpg(image, quality: 85);
    final tempPath = '${file.parent.path}/compressed_${file.uri.pathSegments.last}';
    final compressedFile = File(tempPath);
    await compressedFile.writeAsBytes(compressedBytes);

    return compressedFile;
  }

  // Extract dominant color only
  static Future<Color> extractDominantColor(File imageFile) async {
    final colors = await extractColors(imageFile, maxColors: 1);
    return colors.first;
  }
}
