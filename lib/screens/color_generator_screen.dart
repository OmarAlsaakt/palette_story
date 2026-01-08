import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../models/color_palette.dart';
import '../providers/palette_provider.dart';
import '../services/color_generator_service.dart';
import '../utils/color_helpers.dart';
import '../widgets/color_swatch_card.dart';

class ColorGeneratorScreen extends StatefulWidget {
  const ColorGeneratorScreen({Key? key}) : super(key: key);

  @override
  State<ColorGeneratorScreen> createState() => _ColorGeneratorScreenState();
}

class _ColorGeneratorScreenState extends State<ColorGeneratorScreen> {
  List<Color> _generatedColors = [];
  String _currentKeyword = '';
  bool _isGenerating = false;

  final List<Map<String, dynamic>> _keywordCategories = [
    {
      'title': 'Nature',
      'keywords': ['ocean', 'sunset', 'forest', 'lavender', 'desert', 'mountain'],
    },
    {
      'title': 'Seasons',
      'keywords': ['spring', 'summer', 'autumn', 'winter'],
    },
    {
      'title': 'Moods',
      'keywords': ['calm', 'energetic', 'romantic', 'professional', 'playful'],
    },
    {
      'title': 'Styles',
      'keywords': ['vintage', 'modern', 'minimalist', 'bohemian', 'elegant'],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generate Colors'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF6C5CE7), Color(0xFFFF6B6B)],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Quick random generate
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton.icon(
                onPressed: _generateRandom,
                icon: const Icon(Icons.shuffle),
                label: const Text('Generate Random Palette'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'or choose a keyword:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 16),

            // Keyword categories
            ..._keywordCategories.map((category) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category['title'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: (category['keywords'] as List<String>).map((keyword) {
                        return ActionChip(
                          label: Text(keyword),
                          onPressed: () => _generateFromKeyword(keyword),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              );
            }).toList(),

            if (_isGenerating)
              const Padding(
                padding: EdgeInsets.all(32),
                child: Center(child: CircularProgressIndicator()),
              ),

            if (_generatedColors.isNotEmpty) ...[
              const SizedBox(height: 24),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFF5F7FA), Color(0xFFE4E8F0)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Generated Palette',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (_currentKeyword.isNotEmpty)
                              Text(
                                'From: $_currentKeyword',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                          ],
                        ),
                        IconButton(
                          icon: const Icon(Icons.refresh),
                          onPressed: _currentKeyword.isEmpty
                              ? _generateRandom
                              : () => _generateFromKeyword(_currentKeyword),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 140,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _generatedColors.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: ColorSwatchCard(
                              color: _generatedColors[index],
                              size: 100,
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: _savePalette,
                      icon: const Icon(Icons.save),
                      label: const Text('Save This Palette'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
            ],
          ],
        ),
      ),
    );
  }

  void _generateRandom() {
    setState(() {
      _isGenerating = true;
      _currentKeyword = '';
    });

    // Simulate loading for better UX
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _generatedColors = ColorGeneratorService.generateRandom(count: 7);
        _isGenerating = false;
      });
    });
  }

  void _generateFromKeyword(String keyword) {
    setState(() {
      _isGenerating = true;
      _currentKeyword = keyword;
    });

    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _generatedColors = ColorGeneratorService.generateFromKeyword(
          keyword,
          count: 7,
        );
        _isGenerating = false;
      });
    });
  }

  void _savePalette() {
    if (_generatedColors.isEmpty) return;

    final defaultName = _currentKeyword.isEmpty
        ? 'Random Palette'
        : '${_currentKeyword[0].toUpperCase()}${_currentKeyword.substring(1)} Palette';

    showDialog(
      context: context,
      builder: (context) => _SaveGeneratedPaletteDialog(
        colors: _generatedColors,
        defaultName: defaultName,
        keyword: _currentKeyword,
      ),
    );
  }
}

class _SaveGeneratedPaletteDialog extends StatefulWidget {
  final List<Color> colors;
  final String defaultName;
  final String keyword;

  const _SaveGeneratedPaletteDialog({
    Key? key,
    required this.colors,
    required this.defaultName,
    required this.keyword,
  }) : super(key: key);

  @override
  State<_SaveGeneratedPaletteDialog> createState() =>
      _SaveGeneratedPaletteDialogState();
}

class _SaveGeneratedPaletteDialogState
    extends State<_SaveGeneratedPaletteDialog> {
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.defaultName);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Save Palette'),
      content: TextField(
        controller: _nameController,
        decoration: const InputDecoration(
          labelText: 'Palette Name',
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _save,
          child: const Text('Save'),
        ),
      ],
    );
  }

  Future<void> _save() async {
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a palette name')),
      );
      return;
    }

    final palette = ColorPalette(
      id: const Uuid().v4(),
      name: _nameController.text.trim(),
      hexColors: widget.colors
          .map((color) => ColorHelpers.colorToHex(color))
          .toList(),
      createdAt: DateTime.now(),
      description: widget.keyword.isEmpty
          ? 'Generated randomly'
          : ColorGeneratorService.getDescription(widget.keyword),
      category: 'Custom',
    );

    try {
      await Provider.of<PaletteProvider>(context, listen: false)
          .addPalette(palette);

      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Palette saved successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }
}
