// import 'dart:io';
// import 'dart:typed_data';
// import 'dart:ui' as ui;
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:path_provider/path_provider.dart';
// //import 'package:share_plus/share_plus.dart';
// import '../models/color_palette.dart';
// import '../utils/color_helpers.dart';

// class ShareService {
//   // Share palette as image
//   static Future<void> sharePaletteImage(
//     ColorPalette palette,
//     GlobalKey repaintBoundaryKey,
//   ) async {
//     try {
//       RenderRepaintBoundary boundary = repaintBoundaryKey.currentContext!
//           .findRenderObject() as RenderRepaintBoundary;
//       ui.Image image = await boundary.toImage(pixelRatio: 3.0);
//       ByteData? byteData =
//           await image.toByteData(format: ui.ImageByteFormat.png);
//       Uint8List pngBytes = byteData!.buffer.asUint8List();

//       final tempDir = await getTemporaryDirectory();
//       final file = await File('${tempDir.path}/palette_${palette.id}.png')
//           .create();
//       await file.writeAsBytes(pngBytes);

//       await Share.shareXFiles(
//         [XFile(file.path)],
//         text: '${palette.name} - Created with PaletteStory',
//       );
//     } catch (e) {
//       throw Exception('Failed to share image: $e');
//     }
//   }

//   // Share palette as text
//   static Future<void> sharePaletteText(ColorPalette palette) async {
//     final buffer = StringBuffer();
//     buffer.writeln('${palette.name}');
//     buffer.writeln('─' * 30);
    
//     for (int i = 0; i < palette.hexColors.length; i++) {
//       buffer.writeln('Color ${i + 1}: ${palette.hexColors[i]}');
//     }
    
//     buffer.writeln('\nCreated with PaletteStory 🎨');

//     await Share.share(buffer.toString());
//   }

//   // Export to JSON
//   static Future<File> exportToJson(ColorPalette palette) async {
//     final tempDir = await getTemporaryDirectory();
//     final file = File('${tempDir.path}/palette_${palette.id}.json');
    
//     final jsonString = palette.toJson().toString();
//     await file.writeAsString(jsonString);
    
//     return file;
//   }

//   // Export to CSS
//   static Future<File> exportToCss(ColorPalette palette) async {
//     final tempDir = await getTemporaryDirectory();
//     final file = File('${tempDir.path}/palette_${palette.id}.css');
    
//     final buffer = StringBuffer();
//     buffer.writeln('/* ${palette.name} */');
//     buffer.writeln(':root {');
    
//     for (int i = 0; i < palette.hexColors.length; i++) {
//       buffer.writeln('  --color-${i + 1}: ${palette.hexColors[i]};');
//     }
    
//     buffer.writeln('}');
    
//     await file.writeAsString(buffer.toString());
//     return file;
//   }

//   // Copy to clipboard
//   static String generateClipboardText(ColorPalette palette) {
//     return palette.hexColors.join(', ');
//   }
// }
