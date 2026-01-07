import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/color_palette.dart';
import '../utils/color_helpers.dart';
import '../widgets/color_info_display.dart';

class PaletteDetailScreen extends StatelessWidget {
  final ColorPalette palette;

  const PaletteDetailScreen({
    Key? key,
    required this.palette,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(palette.name),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF6C5CE7), Color(0xFFFF6B6B)],
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () => _sharePalette(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Palette info
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (palette.description != null) ...[
                    Text(
                      palette.description!,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                  if (palette.category != null)
                    Chip(
                      label: Text(palette.category!),
                      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                    ),
                ],
              ),
            ),

            // Color swatches
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.5,
              ),
              itemCount: palette.hexColors.length,
              itemBuilder: (context, index) {
                final hexColor = palette.hexColors[index];
                final color = ColorHelpers.hexToColor(hexColor);
                return _buildColorTile(context, color, index + 1);
              },
            ),

            // Detailed info for each color
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Color Details',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...palette.hexColors.map((hexColor) {
                    final color = ColorHelpers.hexToColor(hexColor);
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: ColorInfoDisplay(color: color),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Export options
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Export Options',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () => _copyAllHex(context),
                    icon: const Icon(Icons.copy),
                    label: const Text('Copy All Hex Codes'),
                  ),
                  const SizedBox(height: 8),
                  OutlinedButton.icon(
                    onPressed: () => _exportAsCSS(context),
                    icon: const Icon(Icons.code),
                    label: const Text('Export as CSS'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildColorTile(BuildContext context, Color color, int number) {
    final hexColor = ColorHelpers.colorToHex(color);
    final hsl = ColorHelpers.rgbToHsl(color.red, color.green, color.blue);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          Clipboard.setData(ClipboardData(text: hexColor));
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Copied $hexColor')),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Color $number',
                style: TextStyle(
                  color: ColorHelpers.getTextColor(color),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hexColor,
                    style: TextStyle(
                      color: ColorHelpers.getTextColor(color),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'RGB: ${color.red}, ${color.green}, ${color.blue}',
                    style: TextStyle(
                      color: ColorHelpers.getTextColor(color),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _copyAllHex(BuildContext context) {
    final allHex = palette.hexColors.join(', ');
    Clipboard.setData(ClipboardData(text: allHex));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('All hex codes copied!')),
    );
  }

  void _exportAsCSS(BuildContext context) {
    final buffer = StringBuffer();
    buffer.writeln('/* ${palette.name} */');
    buffer.writeln(':root {');
    for (int i = 0; i < palette.hexColors.length; i++) {
      buffer.writeln('  --color-${i + 1}: ${palette.hexColors[i]};');
    }
    buffer.writeln('}');

    Clipboard.setData(ClipboardData(text: buffer.toString()));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('CSS exported to clipboard!')),
    );
  }

  void _sharePalette(BuildContext context) {
    // Share functionality would use share_plus package
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Share feature coming soon!')),
    );
  }
}
