import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/color_helpers.dart';

class ColorInfoDisplay extends StatelessWidget {
  final Color color;
  final String format;

  const ColorInfoDisplay({
    Key? key,
    required this.color,
    this.format = 'HEX',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hex = ColorHelpers.colorToHex(color);
    final hsl = ColorHelpers.rgbToHsl(color.red, color.green, color.blue);
    final cmyk = ColorHelpers.rgbToCmyk(color.red, color.green, color.blue);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Color preview
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            const SizedBox(height: 16),
            // Color values
            _buildColorValue(
              context,
              'HEX',
              hex,
              Icons.tag,
            ),
            const Divider(),
            _buildColorValue(
              context,
              'RGB',
              '${color.red}, ${color.green}, ${color.blue}',
              Icons.palette,
            ),
            const Divider(),
            _buildColorValue(
              context,
              'HSL',
              '${hsl['h']!.round()}°, ${hsl['s']!.round()}%, ${hsl['l']!.round()}%',
              Icons.gradient,
            ),
            const Divider(),
            _buildColorValue(
              context,
              'CMYK',
              '${cmyk['c']!.round()}%, ${cmyk['m']!.round()}%, ${cmyk['y']!.round()}%, ${cmyk['k']!.round()}%',
              Icons.print,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColorValue(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return InkWell(
      onTap: () {
        Clipboard.setData(ClipboardData(text: value));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Copied $label: $value'),
            duration: const Duration(seconds: 1),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Icon(icon, size: 20, color: Colors.grey[600]),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.content_copy,
              size: 18,
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }
}
