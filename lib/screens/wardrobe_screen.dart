import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../models/wardrobe_item.dart';
import '../providers/wardrobe_provider.dart';
import '../services/color_extraction_service.dart';
import '../utils/color_helpers.dart';
import '../utils/constants.dart';
import '../widgets/wardrobe_item_card.dart';

class WardrobeScreen extends StatefulWidget {
  const WardrobeScreen({Key? key}) : super(key: key);

  @override
  State<WardrobeScreen> createState() => _WardrobeScreenState();
}

class _WardrobeScreenState extends State<WardrobeScreen> {
  String _selectedCategory = 'All Items';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Wardrobe'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF6C5CE7), Color(0xFFFF6B6B)],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Category tabs
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              children: ['All Items', ...AppConstants.wardrobeCategories]
                  .map((category) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(category),
                    selected: _selectedCategory == category,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() {
                          _selectedCategory = category;
                        });
                      }
                    },
                  ),
                );
              }).toList(),
            ),
          ),

          // Wardrobe items grid
          Expanded(
            child: Consumer<WardrobeProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                final items = provider.filterByCategory(_selectedCategory);

                if (items.isEmpty) {
                  return _buildEmptyState();
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return WardrobeItemCard(
                      item: item,
                      onTap: () => _showItemDetails(context, item),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addNewItem,
        icon: const Icon(Icons.add),
        label: const Text('Add Item'),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.checkroom_outlined,
            size: 100,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 24),
          Text(
            'No wardrobe items yet',
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Start building your digital wardrobe!',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  void _addNewItem() async {
    final ImagePicker picker = ImagePicker();
    
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take Photo'),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from Gallery'),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
          ],
        ),
      ),
    );

    if (source == null) return;

    final XFile? image = await picker.pickImage(source: source);
    if (image == null) return;

    // Show add item dialog
    showDialog(
      context: context,
      builder: (context) => _AddWardrobeItemDialog(imagePath: image.path),
    );
  }

  void _showItemDetails(BuildContext context, WardrobeItem item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.file(
                      File(item.imagePath),
                      height: 300,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    item.category,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Dominant Colors',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: item.dominantColors.map((hexColor) {
                      final color = ColorHelpers.hexToColor(hexColor);
                      return Column(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: color,
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            hexColor,
                            style: const TextStyle(fontSize: 10),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                  if (item.season != null) ...[
                    const SizedBox(height: 16),
                    Text('Season: ${item.season}'),
                  ],
                  if (item.occasion != null) ...[
                    const SizedBox(height: 8),
                    Text('Occasion: ${item.occasion}'),
                  ],
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () async {
                      Navigator.pop(context);
                      await Provider.of<WardrobeProvider>(context, listen: false)
                          .deleteItem(item.id);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Item deleted')),
                      );
                    },
                    icon: const Icon(Icons.delete),
                    label: const Text('Delete Item'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _AddWardrobeItemDialog extends StatefulWidget {
  final String imagePath;

  const _AddWardrobeItemDialog({Key? key, required this.imagePath})
      : super(key: key);

  @override
  State<_AddWardrobeItemDialog> createState() => _AddWardrobeItemDialogState();
}

class _AddWardrobeItemDialogState extends State<_AddWardrobeItemDialog> {
  String _selectedCategory = 'Top';
  String? _selectedSeason;
  String? _selectedOccasion;
  bool _isExtracting = false;
  List<String> _extractedColors = [];

  @override
  void initState() {
    super.initState();
    _extractColors();
  }

  Future<void> _extractColors() async {
    setState(() {
      _isExtracting = true;
    });

    try {
      final colors = await ColorExtractionService.extractColors(
        File(widget.imagePath),
        maxColors: 5,
      );

      setState(() {
        _extractedColors =
            colors.map((c) => ColorHelpers.colorToHex(c)).toList();
        _isExtracting = false;
      });
    } catch (e) {
      setState(() {
        _isExtracting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Wardrobe Item'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(
                File(widget.imagePath),
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            if (_isExtracting)
              const Center(child: CircularProgressIndicator()),
            if (_extractedColors.isNotEmpty) ...[
              const Text('Extracted Colors:'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: _extractedColors.map((hex) {
                  return Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: ColorHelpers.hexToColor(hex),
                      shape: BoxShape.circle,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
            ],
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              decoration: const InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(),
              ),
              items: AppConstants.wardrobeCategories.map((cat) {
                return DropdownMenuItem(value: cat, child: Text(cat));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value!;
                });
              },
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _selectedSeason,
              decoration: const InputDecoration(
                labelText: 'Season (Optional)',
                border: OutlineInputBorder(),
              ),
              items: AppConstants.seasons.map((season) {
                return DropdownMenuItem(value: season, child: Text(season));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedSeason = value;
                });
              },
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _selectedOccasion,
              decoration: const InputDecoration(
                labelText: 'Occasion (Optional)',
                border: OutlineInputBorder(),
              ),
              items: AppConstants.occasions.map((occasion) {
                return DropdownMenuItem(value: occasion, child: Text(occasion));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedOccasion = value;
                });
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _isExtracting ? null : _save,
          child: const Text('Add'),
        ),
      ],
    );
  }

  Future<void> _save() async {
    final item = WardrobeItem(
      id: const Uuid().v4(),
      imagePath: widget.imagePath,
      dominantColors: _extractedColors,
      category: _selectedCategory,
      season: _selectedSeason,
      occasion: _selectedOccasion,
      addedAt: DateTime.now(),
    );

    try {
      await Provider.of<WardrobeProvider>(context, listen: false).addItem(item);
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Item added successfully!'),
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
