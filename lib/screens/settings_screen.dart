import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/settings_provider.dart';
import '../services/storage_service.dart';
import '../utils/constants.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF6C5CE7), Color(0xFFFF6B6B)],
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          _buildSection(
            context,
            'Appearance',
            [
              _buildThemeModeTile(context),
              _buildColorExtractionCountTile(context),
            ],
          ),
          _buildSection(
            context,
            'Data Management',
            [
              ListTile(
                leading: const Icon(Icons.delete_sweep),
                title: const Text('Clear All Data'),
                subtitle: const Text('Delete all palettes and wardrobe items'),
                onTap: () => _confirmClearData(context),
              ),
            ],
          ),
          _buildSection(
            context,
            'Default Settings',
            [
              _buildColorFormatTile(context),
              _buildAutoSaveTile(context),
              _buildHapticFeedbackTile(context),
            ],
          ),
          _buildSection(
            context,
            'About',
            [
              ListTile(
                leading: const Icon(Icons.info),
                title: const Text('App Version'),
                subtitle: const Text(AppConstants.appVersion),
              ),
              ListTile(
                leading: const Icon(Icons.description),
                title: const Text('About PaletteStory'),
                subtitle: const Text(AppConstants.appTagline),
                onTap: () => _showAboutDialog(context),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildThemeModeTile(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, provider, child) {
        return ListTile(
          leading: const Icon(Icons.brightness_6),
          title: const Text('Theme Mode'),
          subtitle: Text(_getThemeModeText(provider.themeMode)),
          onTap: () => _showThemeModeDialog(context, provider),
        );
      },
    );
  }

  Widget _buildColorFormatTile(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, provider, child) {
        return ListTile(
          leading: const Icon(Icons.format_color_text),
          title: const Text('Default Color Format'),
          subtitle: Text(provider.defaultColorFormat),
          onTap: () => _showColorFormatDialog(context, provider),
        );
      },
    );
  }

  Widget _buildColorExtractionCountTile(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, provider, child) {
        return ListTile(
          leading: const Icon(Icons.palette),
          title: const Text('Colors to Extract'),
          subtitle: Text('${provider.colorExtractionCount} colors'),
          onTap: () => _showColorCountDialog(context, provider),
        );
      },
    );
  }

  Widget _buildAutoSaveTile(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, provider, child) {
        return SwitchListTile(
          secondary: const Icon(Icons.save),
          title: const Text('Auto-save Palettes'),
          subtitle: const Text('Automatically save extracted palettes'),
          value: provider.autoSave,
          onChanged: (value) => provider.setAutoSave(value),
        );
      },
    );
  }

  Widget _buildHapticFeedbackTile(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, provider, child) {
        return SwitchListTile(
          secondary: const Icon(Icons.vibration),
          title: const Text('Haptic Feedback'),
          subtitle: const Text('Vibrate on interactions'),
          value: provider.hapticFeedback,
          onChanged: (value) => provider.setHapticFeedback(value),
        );
      },
    );
  }

  String _getThemeModeText(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
      case ThemeMode.system:
        return 'System Default';
    }
  }

  void _showThemeModeDialog(BuildContext context, SettingsProvider provider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Theme Mode'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<ThemeMode>(
              title: const Text('Light'),
              value: ThemeMode.light,
              groupValue: provider.themeMode,
              onChanged: (value) {
                provider.setThemeMode(value!);
                Navigator.pop(context);
              },
            ),
            RadioListTile<ThemeMode>(
              title: const Text('Dark'),
              value: ThemeMode.dark,
              groupValue: provider.themeMode,
              onChanged: (value) {
                provider.setThemeMode(value!);
                Navigator.pop(context);
              },
            ),
            RadioListTile<ThemeMode>(
              title: const Text('System Default'),
              value: ThemeMode.system,
              groupValue: provider.themeMode,
              onChanged: (value) {
                provider.setThemeMode(value!);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showColorFormatDialog(BuildContext context, SettingsProvider provider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Color Format'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: ['HEX', 'RGB', 'HSL'].map((format) {
            return RadioListTile<String>(
              title: Text(format),
              value: format,
              groupValue: provider.defaultColorFormat,
              onChanged: (value) {
                provider.setDefaultColorFormat(value!);
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showColorCountDialog(BuildContext context, SettingsProvider provider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Colors to Extract'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [5, 7, 10].map((count) {
            return RadioListTile<int>(
              title: Text('$count colors'),
              value: count,
              groupValue: provider.colorExtractionCount,
              onChanged: (value) {
                provider.setColorExtractionCount(value!);
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  Future<void> _confirmClearData(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear All Data'),
        content: const Text(
          'This will permanently delete all your palettes and wardrobe items. This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Delete All'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await StorageService.clearAllData();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('All data cleared successfully')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: AppConstants.appName,
      applicationVersion: AppConstants.appVersion,
      applicationIcon: const Icon(Icons.palette, size: 48),
      children: [
        const Text(
          AppConstants.appTagline,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 16),
        const Text(
          'A comprehensive color palette generator and management application for artists, designers, fashion enthusiasts, and anyone interested in color coordination.',
        ),
        const SizedBox(height: 16),
        const Text(
          'Features:\n'
          '• Extract colors from images\n'
          '• Save and organize color palettes\n'
          '• Digital wardrobe management\n'
          '• Professional artist tools\n'
          '• AI-powered color generation\n'
          '• Export and sharing capabilities',
          style: TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}
