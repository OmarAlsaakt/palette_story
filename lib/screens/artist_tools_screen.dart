import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '../utils/color_helpers.dart';
import '../widgets/color_swatch_card.dart';

class ArtistToolsScreen extends StatefulWidget {
  const ArtistToolsScreen({Key? key}) : super(key: key);

  @override
  State<ArtistToolsScreen> createState() => _ArtistToolsScreenState();
}

class _ArtistToolsScreenState extends State<ArtistToolsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Color _selectedColor = const Color(0xFF6C5CE7);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Artist Tools'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF6C5CE7), Color(0xFFFF6B6B)],
            ),
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(text: 'Color Theory'),
            Tab(text: 'Color Picker'),
            Tab(text: 'Tints & Shades'),
            Tab(text: 'Contrast Checker'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildColorTheoryTab(),
          _buildColorPickerTab(),
          _buildTintsShadesTab(),
          _buildContrastCheckerTab(),
        ],
      ),
    );
  }

  Widget _buildColorTheoryTab() {
    final complementary = ColorHelpers.getComplementary(_selectedColor);
    final analogous = ColorHelpers.getAnalogous(_selectedColor);
    final triadic = ColorHelpers.getTriadic(_selectedColor);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select Base Color',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: _showColorPicker,
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                color: _selectedColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Center(
                child: Text(
                  ColorHelpers.colorToHex(_selectedColor),
                  style: TextStyle(
                    color: ColorHelpers.getTextColor(_selectedColor),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          _buildHarmonySection(
            'Complementary',
            'Colors opposite on the color wheel',
            [complementary],
          ),
          const SizedBox(height: 20),
          _buildHarmonySection(
            'Analogous',
            'Colors next to each other on the wheel',
            analogous,
          ),
          const SizedBox(height: 20),
          _buildHarmonySection(
            'Triadic',
            'Three colors equally spaced around the wheel',
            triadic,
          ),
        ],
      ),
    );
  }

  Widget _buildHarmonySection(
      String title, String description, List<Color> colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: colors.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: ColorSwatchCard(color: colors[index], size: 70),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildColorPickerTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text(
            'Pick a Color',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ColorPicker(
            pickerColor: _selectedColor,
            onColorChanged: (color) {
              setState(() {
                _selectedColor = color;
              });
            },
            pickerAreaHeightPercent: 0.8,
            enableAlpha: false,
            displayThumbColor: true,
            labelTypes: const [],
          ),
          const SizedBox(height: 20),
          _buildColorInfoCard(_selectedColor),
        ],
      ),
    );
  }

  Widget _buildColorInfoCard(Color color) {
    final hsl = ColorHelpers.rgbToHsl(color.red, color.green, color.blue);
    final cmyk = ColorHelpers.rgbToCmyk(color.red, color.green, color.blue);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow('HEX', ColorHelpers.colorToHex(color)),
            _buildInfoRow('RGB', '${color.red}, ${color.green}, ${color.blue}'),
            _buildInfoRow('HSL',
                '${hsl['h']!.round()}°, ${hsl['s']!.round()}%, ${hsl['l']!.round()}%'),
            _buildInfoRow('CMYK',
                '${cmyk['c']!.round()}%, ${cmyk['m']!.round()}%, ${cmyk['y']!.round()}%, ${cmyk['k']!.round()}%'),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          Text(value),
        ],
      ),
    );
  }

  Widget _buildTintsShadesTab() {
    final tints = ColorHelpers.generateTints(_selectedColor, 10);
    final shades = ColorHelpers.generateShades(_selectedColor, 10);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select Base Color',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: _showColorPicker,
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                color: _selectedColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  ColorHelpers.colorToHex(_selectedColor),
                  style: TextStyle(
                    color: ColorHelpers.getTextColor(_selectedColor),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Tints (Lighter)',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: tints.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ColorSwatchCard(
                    color: tints[index],
                    size: 60,
                    showHex: false,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Shades (Darker)',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: shades.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ColorSwatchCard(
                    color: shades[index],
                    size: 60,
                    showHex: false,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContrastCheckerTab() {
    Color backgroundColor = Colors.white;
    Color foregroundColor = Colors.black;

    return StatefulBuilder(
      builder: (context, setState) {
        final contrastRatio =
            ColorHelpers.getContrastRatio(foregroundColor, backgroundColor);
        final passesAA = contrastRatio >= 4.5;
        final passesAAA = contrastRatio >= 7.0;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'WCAG Contrast Checker',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Background'),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: () async {
                            final color = await showDialog<Color>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Pick Background Color'),
                                content: SingleChildScrollView(
                                  child: ColorPicker(
                                    pickerColor: backgroundColor,
                                    onColorChanged: (color) {
                                      backgroundColor = color;
                                    },
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Cancel'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () =>
                                        Navigator.pop(context, backgroundColor),
                                    child: const Text('Select'),
                                  ),
                                ],
                              ),
                            );
                            if (color != null) {
                              setState(() {
                                backgroundColor = color;
                              });
                            }
                          },
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                              color: backgroundColor,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Foreground'),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: () async {
                            final color = await showDialog<Color>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Pick Foreground Color'),
                                content: SingleChildScrollView(
                                  child: ColorPicker(
                                    pickerColor: foregroundColor,
                                    onColorChanged: (color) {
                                      foregroundColor = color;
                                    },
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Cancel'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () =>
                                        Navigator.pop(context, foregroundColor),
                                    child: const Text('Select'),
                                  ),
                                ],
                              ),
                            );
                            if (color != null) {
                              setState(() {
                                foregroundColor = color;
                              });
                            }
                          },
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                              color: foregroundColor,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Card(
                child: Container(
                  color: backgroundColor,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        'Sample Text',
                        style: TextStyle(
                          color: foregroundColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'This is how your text will look',
                        style: TextStyle(
                          color: foregroundColor,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Contrast Ratio: ${contrastRatio.toStringAsFixed(2)}:1',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildComplianceRow('WCAG AA', passesAA),
                      const SizedBox(height: 8),
                      _buildComplianceRow('WCAG AAA', passesAAA),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildComplianceRow(String standard, bool passes) {
    return Row(
      children: [
        Icon(
          passes ? Icons.check_circle : Icons.cancel,
          color: passes ? Colors.green : Colors.red,
        ),
        const SizedBox(width: 8),
        Text(
          '$standard: ${passes ? "Pass" : "Fail"}',
          style: TextStyle(
            fontSize: 16,
            color: passes ? Colors.green : Colors.red,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  void _showColorPicker() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pick a Color'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: _selectedColor,
            onColorChanged: (color) {
              _selectedColor = color;
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {});
              Navigator.pop(context);
            },
            child: const Text('Select'),
          ),
        ],
      ),
    );
  }
}
