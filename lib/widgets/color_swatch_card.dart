import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/color_helpers.dart';

class ColorSwatchCard extends StatelessWidget {
  final Color color;
  final VoidCallback? onTap;
  final bool showHex;
  final double size;

  const ColorSwatchCard({
    Key? key,
    required this.color,
    this.onTap,
    this.showHex = true,
    this.size = 80,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hexColor = ColorHelpers.colorToHex(color);
    
    return GestureDetector(
      onTap: onTap,
      onLongPress: () {
        Clipboard.setData(ClipboardData(text: hexColor));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Copied $hexColor'),
            duration: const Duration(seconds: 1),
          ),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
          ),
          if (showHex) ...[
            const SizedBox(height: 8),
            Text(
              hexColor,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
